//
//  SheduleRequestVC.swift
//  TeamUp
//
//  Created by Apple on 04/09/21.
//

import UIKit

class SheduleRequestVC: BaseViewController {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var btnAccept: UIButton!
    @IBOutlet weak var btnReject: UIButton!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var tfCategory: UITextField!
    @IBOutlet weak var tfLocation: UITextField!
    @IBOutlet weak var tfSports: UITextField!
    @IBOutlet var lblDate: UILabel!
    @IBOutlet var lblTime: UILabel!
    @IBOutlet var lblDescriptions: UILabel!
    
    var objArray:NSDictionary?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lblDate.text = "Booking Date"
        self.lblTime.text = "Booking Time"
        self.lblDescriptions.text = "Datails"
        
     //   self.tabBarController?.tabBar.isHidden = true
        self.imgProfile.layer.cornerRadius = self.imgProfile.frame.height/2
        self.imgProfile.clipsToBounds = true
        
        // Do any additional setup after loading the view.
        self.title = "Shedule Request"
        self.btnReject.layer.borderWidth = 1
        self.btnReject.layer.borderColor = UIColor.black.cgColor
        
        self.lblName.text = objArray?["name"] as? String
        
        let dict = AppSharedData.getUserInfo()
        self.lblSubTitle.text = dict["name"]as? String ?? ""//objArray?["description"] as? String
        
        self.tfCategory.text = objArray?["appointment_date"] as? String
        self.tfSports.text = objArray?["appointment_time"] as? String
        self.tfLocation.text = objArray?["description"] as? String
        
        if let user_image = objArray?["user_image"] as? String{
            let profilePic = user_image
            if profilePic != "" {
                let url = URL(string: profilePic)
                self.imgProfile.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "DefaultUserIcon"))
            }
        }
        
    }
    

    @IBAction func btnViewProfile(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "ProfileVC") as! ProfileVC
        vc.strType = "Schedule"
        vc.dictData = self.objArray!
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func btnAccept(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "NotificationVC") as! NotificationVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnReject(_ sender: Any) {
        
    }
    
}
