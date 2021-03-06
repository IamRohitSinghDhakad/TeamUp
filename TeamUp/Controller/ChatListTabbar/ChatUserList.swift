//
//  ChatUserList.swift
//  TeamUp
//
//  Created by Apple on 05/09/21.
//

import UIKit
import Kingfisher
import SDWebImage

class ChatUserList: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tblUserChatList: UITableView!
    
    var arrChatList = NSMutableArray()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblUserChatList.delegate = self
        self.tblUserChatList.dataSource = self
        // Do any additional setup after loading the view.
      //  self.call_GetChetList()
        self.call_EditProfile()
       
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


    @objc func switchTarget(sender: UISwitch!)
    {
        if sender.isOn {
            AppSharedData.sharedObject().call_UpDateToggleStatus(strStatus: "1")
        } else{
            AppSharedData.sharedObject().call_UpDateToggleStatus(strStatus: "0")
        }
    }

    
    override func viewWillAppear(_ animated: Bool) {
        self.call_GetChetList()
       
        let dict = AppSharedData.getUserInfo()
        let userInfo = dict["type"]as? String ?? ""
        print(userInfo)
        if userInfo != "user"{
            self.rightNavButton()
        }else{
            
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrChatList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserChatCell") as! UserChatCell
        let dict = arrChatList[indexPath.row] as? NSDictionary
        print("")
        cell.lblMessage.text! = dict?.GetString(forKey: "last_message") ?? ""
        cell.lblTime.text! = dict?.GetString(forKey: "time_ago") ?? ""
        cell.lblName.text! = dict?.GetString(forKey: "sender_name") ?? ""
        //sender_image
//        let image = dict?.GetString(forKey: "sender_image")
//        cell.imgProfile.image = UIImage(named: "DefaultUserIcon")
//        if image != "" {
//        let url = URL(string: image ?? "")
//        cell.imgProfile.kf.setImage(with: url)
//        }
        
        let profilePic = dict?.GetString(forKey: "sender_image")
         if profilePic != "" {
             let url = URL(string: profilePic ?? "")
             cell.imgProfile.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "DefaultUserIcon"))
         }else{
             cell.imgProfile.image = #imageLiteral(resourceName: "DefaultUserIcon")
        }
        
        cell.imgProfile.layer.cornerRadius = cell.imgProfile.frame.height/2
        cell.imgProfile.clipsToBounds = true
        return cell
    }
    
   
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "ChatListVC") as! ChatListVC
        vc.dictPrevious = (arrChatList[indexPath.row] as? NSDictionary)!
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    func call_GetChetList(){
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
            return
        }
        
        objWebServiceManager.showIndicator()
       
        let dict = AppSharedData.getUserInfo()
        let url  = WsUrl.url_get_conversation+"?user_id=\(dict.GetString(forKey: "user_id"))" //\(dict["user_id"] ?? "")
        
        objWebServiceManager.requestGet(strURL: url, params: [:], queryParams: [:], strCustomValidation: "") { [self] (response) in
            objWebServiceManager.hideIndicator()
            let status = (response["status"] as? Int)
            let message = (response["message"] as? String)
         //   print(response)
            if status == MessageConstant.k_StatusCode{
                if let user_details  = response["result"] as? NSArray {
                    print("user_details>>>>>\(user_details)")
                    self.arrChatList = user_details.mutableCopy() as! NSMutableArray
                    if self.arrChatList.count > 0 {
                        self.tblUserChatList.displayBackgroundText(text: "")
                    }else{
                        self.tblUserChatList.displayBackgroundText(text: "Chat History Not found")
                    }
                    self.tblUserChatList.reloadData()
                }
                else {
                    objAlert.showAlert(message: "Something went wrong!", title: "", controller: self)
                }
            }else{
                objWebServiceManager.hideIndicator()
                if let msgg = response["result"]as? String{
                    objAlert.showAlert(message: msgg, title: "", controller: self)
                    self.tblUserChatList.displayBackgroundText(text: "Chat History Not found")
                }else{
                    objAlert.showAlert(message: message ?? "", title: "", controller: self)
                }
            }
        } failure: { (Error) in
            objWebServiceManager.hideIndicator()
        }
    }
    

   

}

class UserChatCell:UITableViewCell {
    
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblMessage: UILabel!
}


extension ChatUserList{
    
    func call_EditProfile(){
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
            return
        }
        objWebServiceManager.showIndicator()
        let dict = AppSharedData.getUserInfo()
        let url  = WsUrl.url_getUserProfile+"?user_id=\(dict["user_id"] ?? "")"
        
        objWebServiceManager.requestGet(strURL: url, params: [:], queryParams: [:], strCustomValidation: "") { (response) in
            let json = response as NSDictionary
            
            print(json)
            
            let status = json.GetInt(forKey: "status")
            objWebServiceManager.hideIndicator()
            if status == 1 {
                
                self.setProfileData(dict: json.GetNSDictionary(forKey: "result"))
            }else{
                objAlert.showAlert(message: "Data Not Found", title: "Alert", controller: self)
            }
        } failure: { (Error) in
            objWebServiceManager.hideIndicator()
        }
    }
    
    
    
    func setProfileData(dict:NSDictionary) {
        let status = dict.GetString(forKey: "status")
        
        if status == "1"{
            AppSharedData.sharedObject().strToggleStatus = true
        }else{
            AppSharedData.sharedObject().strToggleStatus = false
        }
        //self.rightNavButton()

        let dict = AppSharedData.getUserInfo()
        let userInfo = dict["type"]as? String ?? ""
        if userInfo != "user"{
            self.rightNavButton()
        }else{
            
        }

        
    }
}
