//
//  SearchResultVC.swift
//  TeamUp
//
//  Created by Apple on 03/09/21.
//

import UIKit
import Kingfisher

class SearchResultVC: UIViewController,UITableViewDelegate,UITableViewDataSource,myViewDelegate,MyFilterDelegate {
    
    func callViewProfile(index: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "ProfileVC") as! ProfileVC
        vc.dictData = (arrUserList[index.row] as? NSDictionary)!
        vc.strType = "SearchView"
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBOutlet weak var tblSearchList: UITableView!
    
    var catId = String()
    var subCatId = String()
    var arrUserList = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Search Result"
        tblSearchList.register(UINib(nibName: "FavoritesCellTableViewCell", bundle: nil), forCellReuseIdentifier: "FavoritesCellTableViewCell")
        tblSearchList.delegate = self
        tblSearchList.dataSource = self
        let filterButton = UIBarButtonItem(image: UIImage(named: "filter"), style: .plain, target: self, action: #selector(filter))
            self.navigationItem.rightBarButtonItem  = filterButton
        self.call_GetUserList(strLat: AppSharedData.sharedObject().lat, strlong: AppSharedData.sharedObject().long, strRatings: "", strSort: "")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    @objc func filter(){
        let vc = storyboard?.instantiateViewController(identifier: "FilterVC") as! FilterVC
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func filterData(strLat: String, strLong: String, strRating: String, strSortBy: String) {
        
        self.call_GetUserList(strLat: strLat, strlong: strLong, strRatings: strRating, strSort: strSortBy)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
  
        
        return arrUserList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritesCellTableViewCell") as! FavoritesCellTableViewCell
        let dict = arrUserList[indexPath.row] as? NSDictionary
        cell.lblName.text! = dict?.GetString(forKey: "name") ?? ""
        cell.lblKm.text! = dict?.GetString(forKey: "distance") ?? ""
        cell.lblRupes.text! = dict?.GetString(forKey: "price") ?? ""
        cell.viewRating.editable = ((dict?.GetFloat(forKey: "avg_rating")) != nil)
        cell.hgtConstantHart.constant = 0
        cell.selectedIndex = indexPath
        cell.delegate = self
        
//        let image = dict?.GetString(forKey: "user_image")
//        cell.imgProfile.image = UIImage(named: "DefaultUserIcon")
//        if image != "" {
//        let url = URL(string: image ?? "")
//        cell.imgProfile.kf.setImage(with: url)
        
        let profilePic = dict?.GetString(forKey: "user_image")
         if profilePic != "" {
             let url = URL(string: profilePic ?? "")
             cell.imgProfile.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "DefaultUserIcon"))
         }else{
             cell.imgProfile.image = #imageLiteral(resourceName: "DefaultUserIcon")
        }
    
        return cell
    }
    

    @IBAction func btnSave(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "LocationVC") as! LocationVC
        vc.arrAnnotation = self.arrUserList
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func call_GetUserList(strLat:String,strlong:String,strRatings:String,strSort:String){
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
            return
        }
        objWebServiceManager.showIndicator()
        let catId = "?category_id=\(self.catId)"
        let subCatId = "&sub_category_id=\(self.subCatId)"
        let lat = "&lat=\(strLat)"
        let long = "&lng=\(strlong)"
        let rating = "&rating=\(strRatings)"
        let sortBy = "&sort_by=\(strSort)"
        
        let url  = WsUrl.url_get_users+"\(catId)\(subCatId)\(lat)\(long)\(rating)\(sortBy)"
        objWebServiceManager.requestGet(strURL: url, params: [:], queryParams: [:], strCustomValidation: "") { (response) in
            objWebServiceManager.hideIndicator()
            let status = (response["status"] as? Int)
            let message = (response["message"] as? String)
         //   print(response)
            if status == MessageConstant.k_StatusCode{
                if let user_details  = response["result"] as? NSArray {
                    print("user_details>>>>>\(user_details)")
                    self.arrUserList = user_details.mutableCopy() as! NSMutableArray
                    self.tblSearchList.reloadData()
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


