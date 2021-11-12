//
//  ProfileMediaVC.swift
//  TeamUp
//
//  Created by Apple on 06/10/21.
//

import UIKit
import Kingfisher

class ProfileMediaVC: UIViewController,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    
    
    @IBOutlet weak var collectionView: UICollectionView!
    var arrMedia = NSMutableArray()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.call_GetPostHistory()
    }
    
    
    // MARK: - CollectionDelegateAndDatasource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrMedia.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mediaTypeCell", for: indexPath) as! mediaTypeCell
        let dict = arrMedia[indexPath.row] as? NSDictionary
        
//        let image = dict?.GetString(forKey: "user_image")
//        cell.imgMedia.image = UIImage(named: "DefaultUserIcon")
//        if image != "" {
//            let url = URL(string: image ?? "")
//            cell.imgMedia.kf.setImage(with: url)
//        }
        
        let profilePic = dict?.GetString(forKey: "user_image")
         if profilePic != "" {
             let url = URL(string: profilePic ?? "")
             cell.imgMedia.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "DefaultUserIcon"))
         }else{
             cell.imgMedia.image = #imageLiteral(resourceName: "DefaultUserIcon")
        }
        
        cell.imgMedia.layer.cornerRadius = 10
        cell.imgMedia.clipsToBounds = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width-20)/3, height: (collectionView.frame.width)/3)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    
    func call_GetPostHistory(){
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
            return
        }
        
        objWebServiceManager.showIndicator()
       
        let url  = WsUrl.url_get_post+"?post_id=&post_by="
        
        objWebServiceManager.requestGet(strURL: url, params: [:], queryParams: [:], strCustomValidation: "") { (response) in
            objWebServiceManager.hideIndicator()
            let status = (response["status"] as? Int)
            let message = (response["message"] as? String)
         //   print(response)
            if status == MessageConstant.k_StatusCode{
                if let user_details  = response["result"] as? NSArray {
                    print("user_details>>>>>\(user_details)")
                    self.arrMedia = user_details.mutableCopy() as! NSMutableArray
                    self.collectionView.reloadData()
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



class mediaTypeCell:UICollectionViewCell {
    @IBOutlet weak var imgMedia: UIImageView!
}
