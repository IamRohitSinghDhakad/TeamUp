//
//  NotificationVC.swift
//  TeamUp
//
//  Created by Apple on 04/09/21.
//

import UIKit
import Kingfisher

class NotificationVC: UIViewController,UITableViewDelegate,UITableViewDataSource,sheduleAcceptDelegate {
    
    @IBOutlet weak var tblNotification: UITableView!
    
    var arrShedule = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblNotification.register(UINib(nibName: "NotificationCell", bundle: nil), forCellReuseIdentifier: "NotificationCell")
        tblNotification.delegate = self
        tblNotification.dataSource = self
        self.call_GetAppointMent()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrShedule.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell") as! NotificationCell
        let dict = arrShedule[indexPath.row] as? NSDictionary
     
        cell.lblName.text! = "Your Appointment Shedule with \(dict?.GetString(forKey: "name") ?? "")"
        cell.lblTime.text! = dict?.GetString(forKey: "time_ago") ?? ""
        let image = dict?.GetString(forKey: "user_image")
        cell.imgProfile.image = UIImage(named: "DefaultUserIcon")
        if image != "" {
            let url = URL(string: image ?? "")
            cell.imgProfile.kf.setImage(with: url)
        }
        cell.delegate = self
        cell.indexPath = indexPath
        return cell
    }
    
    func stringToDate(_ str: String)->Date{
        let formatter = DateFormatter()
        formatter.dateFormat="yyyy-MM-dd hh:mm:ss"
        return formatter.date(from: str)!
    }
    
    
    func toDate(withFormat format: String = "yyyy-MM-dd HH:mm:ss",strDate:String)-> Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Tehran")
        dateFormatter.locale = Locale(identifier: "fa-IR")
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: strDate)
        return date
    }
    
    func mySheduleAccept(for cell: NotificationCell) {
        let indexPath = cell.indexPath
        let dict = arrShedule[indexPath!.row] as? NSDictionary
        self.call_updateAppointMent(dict: dict!, strType: "accept")
    }
    
    func mySheduleReject(for cell: NotificationCell) {
         let indexPath = cell.indexPath
         let dict = arrShedule[indexPath!.row] as? NSDictionary
        self.call_updateAppointMent(dict: dict!, strType: "reject")
    }

    func call_GetAppointMent(){
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
            return
        }
        
        objWebServiceManager.showIndicator()
        let dict = AppSharedData.getUserInfo()
        let url  = WsUrl.url_get_appointment+"?user_id=\(dict["user_id"] ?? "")"
        
        objWebServiceManager.requestGet(strURL: url, params: [:], queryParams: [:], strCustomValidation: "") { (response) in
            objWebServiceManager.hideIndicator()
            let status = (response["status"] as? Int)
            let message = (response["message"] as? String)
         //   print(response)
            if status == MessageConstant.k_StatusCode{
                if let user_details  = response["result"] as? NSArray {
                    print("user_details>>>>>\(user_details)")
                    self.arrShedule = user_details.mutableCopy() as! NSMutableArray
                    if self.arrShedule.count > 0 {
                        self.tblNotification.displayBackgroundText(text: "")
                    }else{
                        self.tblNotification.displayBackgroundText(text: "No Record Found")
                    }
                    self.tblNotification.reloadData()
                }
                else {
                    objAlert.showAlert(message: "Something went wrong!", title: "", controller: self)
                }
            }else{
                objWebServiceManager.hideIndicator()
                if let msgg = response["result"]as? String{
                    objAlert.showAlert(message: msgg, title: "", controller: self)
                }else{
                    objAlert.showAlert(message: message ?? "", title: "", controller: self)
                }
            }
        } failure: { (Error) in
            objWebServiceManager.hideIndicator()
        }
    }
    
    func convertDateFormatter(date: String) -> String
     {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"//this your string date format
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "yyyy MMM EEEE HH:mm"///this is what you want to convert format
        let timeStamp = dateFormatter.string(from: date!)
        return timeStamp
    }
    
}


extension Date {
    func timeAgoDisplay() -> String {
        
        let calendar = Calendar.current
        let minuteAgo = calendar.date(byAdding: .minute, value: -1, to: Date())!
        let hourAgo = calendar.date(byAdding: .hour, value: -1, to: Date())!
        let dayAgo = calendar.date(byAdding: .day, value: -1, to: Date())!
        let weekAgo = calendar.date(byAdding: .day, value: -7, to: Date())!
        
        if minuteAgo < self {
            let diff = Calendar.current.dateComponents([.second], from: self, to: Date()).second ?? 0
            return "\(diff) Sec ago"
        } else if hourAgo < self {
            let diff = Calendar.current.dateComponents([.minute], from: self, to: Date()).minute ?? 0
            return "\(diff) Min ago"
        } else if dayAgo < self {
            let diff = Calendar.current.dateComponents([.hour], from: self, to: Date()).hour ?? 0
            return "\(diff) Hours ago"
        } else if weekAgo < self {
            let diff = Calendar.current.dateComponents([.day], from: self, to: Date()).day ?? 0
            return "\(diff) Days ago"
        }
        let diff = Calendar.current.dateComponents([.weekOfYear], from: self, to: Date()).weekOfYear ?? 0
        return "\(diff) Weeks ago"
    }
}

//MARK:- Call Webservice
extension NotificationVC  {
    func call_updateAppointMent(dict:NSDictionary,strType:String){
        
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
            return
        }
        
        objWebServiceManager.showIndicator()
        let status = "&status=\(strType)"
        let url  = WsUrl.url_update_appointment+"?appointment_id=\(dict.GetString(forKey: "appointment_id"))\(status)"
        
        
        objWebServiceManager.requestGet(strURL: url, params: [:], queryParams: [:], strCustomValidation: "") { (response) in
            let json = response as NSDictionary
            let status = json.GetInt(forKey: "status")
            objWebServiceManager.hideIndicator()
            if status == 1 {
                self.call_GetAppointMent()
            }else{
                objAlert.showAlert(message: "Something went wrong!", title: "", controller: self)
            }
        } failure: { (Error) in
            objWebServiceManager.hideIndicator()
        }
    }
}


    

    


