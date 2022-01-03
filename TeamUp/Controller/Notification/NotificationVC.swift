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
    @IBOutlet var VwButtons: UIView!
    @IBOutlet var btnNewAppointments: UIButton!
    @IBOutlet var btnAddAppointments: UIButton!
    
    var arrShedule = NSMutableArray()
    var arrOldAppointment = NSMutableArray()
    var arrNewAppointmnet = NSMutableArray()
    var currentUser = ""
    var strType = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblNotification.register(UINib(nibName: "NotificationCell", bundle: nil), forCellReuseIdentifier: "NotificationCell")
        tblNotification.delegate = self
        tblNotification.dataSource = self
       
    }
    
    func rightNavButton(){

        let frameSize = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: 50, height: 30))
        let customSwitch = UISwitch(frame: frameSize)

        if AppSharedData.sharedObject().strToggleStatus == true{
            customSwitch.isOn = true
            customSwitch.setOn(true, animated: true)
        }else{
            customSwitch.isOn = false
            customSwitch.setOn(false, animated: true)
        }
       
        customSwitch.onTintColor = UIColor.lightGray
       

        customSwitch.addTarget(self, action: #selector(FindMeVC.switchTarget(sender:)), for: .valueChanged)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: customSwitch)
    }

    @IBAction func btnActionNewAppointments(_ sender: Any) {
        self.strType = "NewAppointment"
        self.tblNotification.reloadData()
    }
    
    @IBAction func btnActionOldAppointments(_ sender: Any) {
        self.strType = "OldAppointment"
        self.tblNotification.reloadData()
    }
    

    @objc func switchTarget(sender: UISwitch!)
    {
        if sender.isOn {
            AppSharedData.sharedObject().call_UpDateToggleStatus(strStatus: "1")
        } else{
            AppSharedData.sharedObject().call_UpDateToggleStatus(strStatus: "0")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let dict = AppSharedData.getUserInfo()
        self.currentUser = dict["type"]as? String ?? ""
        if self.currentUser != "user"{
            self.rightNavButton()
            self.strType = "NewAppointment"
            self.call_GetNewAppointMent()
            self.call_GetOldAppointMent()
        }else{
            self.call_GetAppointMent()
        }
    }

    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.currentUser == "user"{
            return arrShedule.count
        }else{
            if strType == "NewAppointment"{
                return self.arrNewAppointmnet.count
            }else{
                return self.arrOldAppointment.count
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell") as! NotificationCell
        
        if self.currentUser == "user"{
         
            self.VwButtons.isHidden = true
            
            let dict = arrShedule[indexPath.row] as? NSDictionary
         
            cell.lblName.text! = "Your Appointment Shedule with \(dict?.GetString(forKey: "name") ?? "")"
            cell.lblTime.text! = dict?.GetString(forKey: "time_ago") ?? ""
            if let user_image = dict?.GetString(forKey: "user_image"){
                let profilePic = user_image
                if profilePic != "" {
                    let url = URL(string: profilePic)
                    cell.imgProfile.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "DefaultUserIcon"))
                }
            }else{
                cell.imgProfile.image = #imageLiteral(resourceName: "DefaultUserIcon")
            }

            cell.stackviewButtons.isHidden = true
            cell.delegate = self
            cell.indexPath = indexPath
            
        }else{
            self.VwButtons.isHidden = false
            if strType == "NewAppointment"{
                let dict = arrNewAppointmnet[indexPath.row] as? NSDictionary
             
                cell.lblName.text! = "Your Appointment Shedule with \(dict?.GetString(forKey: "name") ?? "")"
                cell.lblTime.text! = dict?.GetString(forKey: "time_ago") ?? ""
                if let user_image = dict?.GetString(forKey: "user_image"){
                    let profilePic = user_image
                    if profilePic != "" {
                        let url = URL(string: profilePic)
                        cell.imgProfile.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "DefaultUserIcon"))
                    }
                }else{
                    cell.imgProfile.image = #imageLiteral(resourceName: "DefaultUserIcon")
                }
  
                cell.stackviewButtons.isHidden = false
                cell.delegate = self
                cell.indexPath = indexPath
            }else{
               
                let dict = arrOldAppointment[indexPath.row] as? NSDictionary
             
                cell.lblName.text! = "Your Appointment Shedule with \(dict?.GetString(forKey: "name") ?? "")"
                cell.lblTime.text! = dict?.GetString(forKey: "time_ago") ?? ""
                if let user_image = dict?.GetString(forKey: "user_image"){
                    let profilePic = user_image
                    if profilePic != "" {
                        let url = URL(string: profilePic)
                        cell.imgProfile.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "DefaultUserIcon"))
                    }
                }else{
                    cell.imgProfile.image = #imageLiteral(resourceName: "DefaultUserIcon")
                }
                cell.stackviewButtons.isHidden = true
                cell.delegate = self
                cell.indexPath = indexPath
            }
        }
        
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SheduleRequestVC")as! SheduleRequestVC
        
        if self.currentUser != "user"{
            if strType == "NewAppointment"{
                vc.objArray = self.arrNewAppointmnet[indexPath.row] as? NSDictionary
            }else{
                vc.objArray = self.arrOldAppointment[indexPath.row] as? NSDictionary
            }
        }else{
            vc.objArray = self.arrShedule[indexPath.row] as? NSDictionary
        }
        self.navigationController?.pushViewController(vc, animated: true)
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

//======================= Provider APi =========================//
extension NotificationVC{
    
    func call_GetOldAppointMent(){
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
            return
        }
        
        objWebServiceManager.showIndicator()
        let dict = AppSharedData.getUserInfo()
        let url  = WsUrl.url_get_appointment+"?to_user_id=\(dict["user_id"] ?? "")&status=accept,complete"
        
        objWebServiceManager.requestGet(strURL: url, params: [:], queryParams: [:], strCustomValidation: "") { (response) in
            objWebServiceManager.hideIndicator()
            let status = (response["status"] as? Int)
            let message = (response["message"] as? String)
         //   print(response)
            if status == MessageConstant.k_StatusCode{
                if let user_details  = response["result"] as? NSArray {
                    print("user_details>>>>>\(user_details)")
                    self.arrOldAppointment = user_details.mutableCopy() as! NSMutableArray
                    if self.arrOldAppointment.count > 0 {
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
    
    
    func call_GetNewAppointMent(){
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
            return
        }
        
        objWebServiceManager.showIndicator()
        let dict = AppSharedData.getUserInfo()
        let url  = WsUrl.url_get_appointment+"?to_user_id=\(dict["user_id"] ?? "")&status=pending"
        // user_id=\(dict["user_id"] ?? "")"
        
        objWebServiceManager.requestGet(strURL: url, params: [:], queryParams: [:], strCustomValidation: "") { (response) in
            objWebServiceManager.hideIndicator()
            let status = (response["status"] as? Int)
            let message = (response["message"] as? String)
         //   print(response)
            if status == MessageConstant.k_StatusCode{
                if let user_details  = response["result"] as? NSArray {
                    print("user_details>>>>>\(user_details)")
                    self.arrNewAppointmnet = user_details.mutableCopy() as! NSMutableArray
                    if self.arrNewAppointmnet.count > 0 {
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
}
