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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imgProfile.layer.cornerRadius = self.imgProfile.frame.height/2
        self.imgProfile.clipsToBounds = true
        
        // Do any additional setup after loading the view.
        self.title = "Shedule Request"
        self.btnReject.layer.borderWidth = 1
        self.btnReject.layer.borderColor = UIColor.black.cgColor
    }
    

    @IBAction func btnViewProfile(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "FavoriteVC") as! FavoriteVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func btnAccept(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "NotificationVC") as! NotificationVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnReject(_ sender: Any) {
        
    }
    
}
