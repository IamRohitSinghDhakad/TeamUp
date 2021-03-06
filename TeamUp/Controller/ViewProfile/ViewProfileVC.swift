//
//  ViewProfileVC.swift
//  TeamUp
//
//  Created by Apple on 05/09/21.
//

import UIKit
import Kingfisher

class ViewProfileVC: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var cvCollectionList: UICollectionView!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var lblName: UILabel!
    
    var dictData = NSDictionary()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "View Profile"
        self.cvCollectionList.delegate = self
        self.cvCollectionList.dataSource = self
        
        self.imgProfile.layer.cornerRadius = imgProfile.frame.height/2
        self.imgProfile.clipsToBounds = true
        
        self.lblName.text! = dictData.GetString(forKey: "name")
        self.lblSubTitle.text! = dictData.GetString(forKey: "profession")
//        let image = dictData.GetString(forKey: "user_image")
//        let url = URL(string: image)
//        self.imgProfile.kf.setImage(with: url)
        
        // if let user_image = dict.GetString(forKey: "user_image"){
            let profilePic = dictData.GetString(forKey: "user_image")
             if profilePic != "" {
                 let url = URL(string: profilePic)
                 self.imgProfile.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "DefaultUserIcon"))
             }else{
                self.imgProfile.image = #imageLiteral(resourceName: "DefaultUserIcon")
            }
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mediaTypeCell", for: indexPath) as! mediaTypeCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width-20)/3, height: (collectionView.frame.width)/3)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }

   
    @IBAction func btnChat(_ sender: Any) {
      
    }
    
    @IBAction func btnBookAppointment(_ sender: Any) {
      
    }
    
    
    @IBAction func btnMedia(_ sender: Any) {
        
        
    }
    
    @IBAction func btnHistory(_ sender: Any) {
        
        
    }
    
    
    @IBAction func btnRatings(_ sender: Any) {
    }
    
}
