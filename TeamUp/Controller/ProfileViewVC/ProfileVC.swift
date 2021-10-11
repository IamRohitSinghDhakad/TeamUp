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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.title = "Profile"
        
        self.imgProfile.layer.cornerRadius = imgProfile.frame.height/2
        self.imgProfile.clipsToBounds = true
        self.containerMedia.isHidden = false
        self.containerHistory.isHidden = true
        self.containerRatings.isHidden = true
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
    
    
    @IBAction func btnRatings(_ sender: Any) {
        self.containerMedia.isHidden = true
        self.containerHistory.isHidden = true
        self.containerRatings.isHidden = false
    }
    
}


