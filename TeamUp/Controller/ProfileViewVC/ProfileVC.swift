//
//  ProfileVC.swift
//  TeamUp
//
//  Created by Apple on 04/09/21.
//

import UIKit

class ProfileVC: BaseViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var cvCollectionList: UICollectionView!
    
    
    @IBOutlet weak var imgProfile: UIImageView!
    
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var lblName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.title = "Profile"
        self.cvCollectionList.delegate = self
        self.cvCollectionList.dataSource = self
        
        self.imgProfile.layer.cornerRadius = imgProfile.frame.height/2
        self.imgProfile.clipsToBounds = true
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mediaTypeCell", for: indexPath) as! mediaTypeCell
        cell.imgMedia.image = UIImage(named: "booo")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width-20)/3, height: (collectionView.frame.width)/3)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
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
        
        
    }
    
    @IBAction func btnHistory(_ sender: Any) {
        
        
    }
    
    
    @IBAction func btnRatings(_ sender: Any) {
    }
    
}

class mediaTypeCell:UICollectionViewCell {
    @IBOutlet weak var imgMedia: UIImageView!
}
