//
//  ProfileRatingsVC.swift
//  TeamUp
//
//  Created by Apple on 06/10/21.
//

import UIKit
import Kingfisher

class ProfileRatingsVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var arrRatings = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.register(UINib(nibName: "ProfileRatingsCell", bundle: nil), forCellReuseIdentifier: "ProfileRatingsCell")
        self.call_RatingReviews()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrRatings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileRatingsCell") as! ProfileRatingsCell
        let dict = arrRatings[indexPath.row] as? NSDictionary
        cell.lblTitle.text! = dict?.GetString(forKey: "name") ?? ""
        cell.lblSubTitle.text! = dict?.GetString(forKey: "review") ?? ""
        cell.ratingView.maxRating = 5//dict?.GetInt(forKey: "rating") ?? 0
        cell.ratingView.fullImage = UIImage(named: "star")!
        cell.lblTime.text! = timeInterval(timeAgo: dict?.GetString(forKey: "entrydt") ?? "")
        
        let image = dict?.GetString(forKey: "user_image")
        cell.imgProfile.image = UIImage(named: "DefaultUserIcon")
        if image != "" {
            let url = URL(string: image ?? "")
            cell.imgProfile.kf.setImage(with: url)
        }
        
        return cell
    }
    
    
    
    func call_RatingReviews(){
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
            return
        }
        
        objWebServiceManager.showIndicator()
        
        let url  = WsUrl.url_review+"?post_id=1"
        
        objWebServiceManager.requestGet(strURL: url, params: [:], queryParams: [:], strCustomValidation: "") { (response) in
            objWebServiceManager.hideIndicator()
            let status = (response["status"] as? Int)
            let message = (response["message"] as? String)
            //   print(response)
            if status == MessageConstant.k_StatusCode{
                if let user_details  = response["result"] as? NSArray {
                    print("user_details>>>>>\(user_details)")
                    self.arrRatings = user_details.mutableCopy() as! NSMutableArray
                    self.tableView.reloadData()
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


extension ProfileRatingsVC {
    func timeInterval(timeAgo:String) -> String
    {
        let df = DateFormatter()
        
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateWithTime = df.date(from: timeAgo)
        
        let interval = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: dateWithTime!, to: Date())
        
        if let year = interval.year, year > 0 {
            return year == 1 ? "\(year)" + " " + "year ago" : "\(year)" + " " + "years ago"
        } else if let month = interval.month, month > 0 {
            return month == 1 ? "\(month)" + " " + "month ago" : "\(month)" + " " + "months ago"
        } else if let day = interval.day, day > 0 {
            return day == 1 ? "\(day)" + " " + "day ago" : "\(day)" + " " + "days ago"
        }else if let hour = interval.hour, hour > 0 {
            return hour == 1 ? "\(hour)" + " " + "hour ago" : "\(hour)" + " " + "hours ago"
        }else if let minute = interval.minute, minute > 0 {
            return minute == 1 ? "\(minute)" + " " + "minute ago" : "\(minute)" + " " + "minutes ago"
        }else if let second = interval.second, second > 0 {
            return second == 1 ? "\(second)" + " " + "second ago" : "\(second)" + " " + "seconds ago"
        } else {
            return "a moment ago"
            
        }
    }
}
