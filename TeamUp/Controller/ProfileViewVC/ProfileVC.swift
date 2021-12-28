//
//  ProfileVC.swift
//  TeamUp
//
//  Created by Apple on 04/09/21.
//

import UIKit

class ProfileVC: BaseViewController,UICollectionViewDelegate,ContainerToMaster {
   
    
  
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var containerMedia: UIView!
    @IBOutlet weak var containerHistory: UIView!
    @IBOutlet weak var containerRatings: UIView!
    @IBOutlet var btnHistory: UIButton!
    @IBOutlet weak var btnAddPost: UIButton!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var btnChat: UIButton!
    @IBOutlet weak var btnBookAppointMent: UIButton!
    
    var dictData = NSDictionary()
    var strType = String()
    var containerViewController: ProfileMediaVC?
    
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       if segue.identifier == "ContainerMedia" {
           containerViewController = segue.destination as? ProfileMediaVC
           containerViewController!.containerToMaster = self
       }
   }
    
    func changeLabel(text: String) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.title = "Profile"
        self.imgProfile.layer.cornerRadius = imgProfile.frame.height/2
        self.imgProfile.clipsToBounds = true
        self.containerMedia.isHidden = false
        self.containerHistory.isHidden = true
        self.containerRatings.isHidden = true
        self.btnHistory.isHidden = true
        print(dictData)
        
//        for subview in self.view.subviews {
//            print(subview)
//            if subview.isKind(of: containerMedia){
//
//            }
////            if subview.isKind(of: ProfileMediaVC.self) {
////                print(subview)
////            }
//        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        containerViewController?.changeLabel(text: "Nice! It's work!")
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
       // self.rightNavButton()
        let dict = AppSharedData.getUserInfo()
        let userInfo = dict["type"]as? String ?? ""
        if userInfo != "user"{
            self.rightNavButton()
        }else{
            
        }
        
        if strType == "SearchView" {
        self.setData(dict: dictData)
            self.btnEdit.isHidden = true
            self.btnChat.isHidden = false
            self.btnAddPost.isHidden = true
            self.btnBookAppointMent.isHidden = false
        }else if strType == "Schedule"{
            self.btnEdit.isHidden = true
            self.btnChat.isHidden = false
            self.btnAddPost.isHidden = true
            self.btnBookAppointMent.isHidden = true
            
            if let user_image = dictData["user_image"] as? String{
                let profilePic = user_image
                if profilePic != "" {
                    let url = URL(string: profilePic)
                    self.imgProfile.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "DefaultUserIcon"))
                }
            }
            self.lblName.text = dictData["name"] as? String
            let dict = AppSharedData.getUserInfo()
            self.lblSubTitle.text = dict["name"]as? String ?? ""//objArray?["description"] as? String
            
        }else{
        let dict = AppSharedData.getUserInfo()
        self.setData(dict: dict)
            self.btnEdit.isHidden = false
            self.btnChat.isHidden = true
            self.btnAddPost.isHidden = false
            self.btnBookAppointMent.isHidden = true
        }
       
    }
    
    func setData(dict:NSDictionary) {
        self.lblName.text! = "\(dict.GetString(forKey: "first_name")) \(dict.GetString(forKey: "last_name"))"
        self.lblSubTitle.text! = dict.GetString(forKey: "profession")
       
//        let image = dict.GetString(forKey: "user_image")
//        self.imgProfile.image = UIImage(named: "DefaultUserIcon")
//        if image != "" {
//        let url = URL(string: image ?? "")
//            self.imgProfile.kf.setImage(with: url)
//        }
        
        let profilePic = dict.GetString(forKey: "user_image")
         if profilePic != "" {
             let url = URL(string: profilePic)
             self.imgProfile.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "DefaultUserIcon"))
         }else{
             self.imgProfile.image = #imageLiteral(resourceName: "DefaultUserIcon")
        }
        
    }

    @IBAction func btnAddPost(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "AddPostVC") as! AddPostVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnEdit(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "EditProfileVC") as! EditProfileVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func btnMedia(_ sender: Any) {
        self.containerMedia.isHidden = false
        self.containerHistory.isHidden = true
        self.containerRatings.isHidden = true
        
    }
    
    @IBAction func btnHistory(_ sender: Any) {
        self.containerMedia.isHidden = true
        self.containerHistory.isHidden = false
        self.containerRatings.isHidden = true
        
    }
    
    
    @IBAction func btnChat(_ sender: Any) {
        self.tabBarController?.selectedIndex = 0
    }
    
    @IBAction func btnBookAppoint(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "BookAppointMentVC") as! BookAppointMentVC
        vc.modalPresentationStyle = .formSheet
        vc.modalTransitionStyle  = .crossDissolve
        vc.dictData = self.dictData
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func btnRatings(_ sender: Any) {
        self.containerMedia.isHidden = true
        self.containerHistory.isHidden = true
        self.containerRatings.isHidden = false
    }
    
}


extension UIView {
    func subviews<T:UIView>(ofType WhatType:T.Type) -> [T] {
        var result = self.subviews.compactMap {$0 as? T}
        for sub in self.subviews {
            result.append(contentsOf: sub.subviews(ofType:WhatType))
        }
        return result
    }
}
