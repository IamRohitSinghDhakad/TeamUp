//
//  SearchResultVC.swift
//  TeamUp
//
//  Created by Apple on 03/09/21.
//

import UIKit
import Kingfisher

class SearchResultVC: UIViewController,UITableViewDelegate,UITableViewDataSource,myViewDelegate {
    
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
        self.call_GetUserList()
    }
    
    @objc func filter(){
        let vc = storyboard?.instantiateViewController(identifier: "FilterVC") as! FilterVC
        self.navigationController?.pushViewController(vc, animated: true)
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
        
        let image = dict?.GetString(forKey: "user_image")
        cell.imgProfile.image = UIImage(named: "DefaultUserIcon")
        if image != "" {
        let url = URL(string: image ?? "")
        cell.imgProfile.kf.setImage(with: url)
        }
        return cell
    }
    

    @IBAction func btnSave(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "LocationVC") as! LocationVC
        vc.arrAnnotation = self.arrUserList
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
   
    
    
    
    func call_GetUserList(){
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
            return
        }
        objWebServiceManager.showIndicator()
        let catId = "?category_id=\(self.catId)"
        let subCatId = "&sub_category_id=\(self.subCatId)"
        
        let url  = WsUrl.url_get_users+"\(catId)\(subCatId)"
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

/*
 {
 address = "332, Bajrang Nagar, Indore, Madhya Pradesh 452010, India";
 age = "-1";
 "age_group" = "";
 "avg_rating" = "4.2";
 "category_id" = 10;
 "category_name" = "Chinese medical doctor";
 "club_address" = "";
 "club_name" = "";
 code = GDG68;
 distance = "8561.74 KM";
 dob = "15-10-2021";
 email = hchvjf;
 entryby = "";
 entrydt = "2021-09-27 18:08:55";
 "first_name" = gdgh;
 "g_address" = Indore;
 "g_email" = hcgxhf;
 "g_fname" = hfcu;
 "g_latitude" = "22.7195687";
 "g_lname" = yrgd;
 "g_longitude" = "75.8577258";
 "g_mobile" = 6686556;
 language = "";
 "last_name" = hchff;
 lat = "22.7458388";
 lng = "75.883343";
 mobile = 8868885;
 name = "gdgh hchff";
 otp = "";
 password = fhchc;
 price = "";
 profession = hfdhf;
 "register_id" = "Not Found";
 relationship = hfhch;
 "social_id" = "";
 "social_type" = "";
 status = 1;
 "sub_category_id" = 5;
 type = provider;
 "user_id" = 6;
 "user_image" = "https://ambitious.in.net/Arun/teamUp/";
 */
