//
//  ProfileVC.swift
//  TeamUp
//
//  Created by Apple on 04/09/21.
//

import UIKit

class ProfileVC: BaseViewController,UICollectionViewDelegate {
  
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var containerMedia: UIView!
    @IBOutlet weak var containerHistory: UIView!
    @IBOutlet weak var containerRatings: UIView!
    
    
    @IBOutlet weak var btnAddPost: UIButton!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var btnChat: UIButton!
    @IBOutlet weak var btnBookAppointMent: UIButton!
    
    
    
    var dictData = NSDictionary()
    var strType = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.title = "Profile"
        self.imgProfile.layer.cornerRadius = imgProfile.frame.height/2
        self.imgProfile.clipsToBounds = true
        self.containerMedia.isHidden = false
        self.containerHistory.isHidden = true
        self.containerRatings.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if strType == "SearchView" {
        self.setData(dict: dictData)
            self.btnEdit.isHidden = true
            self.btnChat.isHidden = false
            self.btnAddPost.isHidden = true
            self.btnBookAppointMent.isHidden = false
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
        let image = dict.GetString(forKey: "user_image")
        self.imgProfile.image = UIImage(named: "DefaultUserIcon")
        if image != "" {
        let url = URL(string: image ?? "")
            self.imgProfile.kf.setImage(with: url)
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


