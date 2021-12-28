//
//  FindMeVC.swift
//  TeamUp
//
//  Created by Apple on 04/09/21.
//

import UIKit
import iOSDropDown
import LocationPicker

class FindMeVC: UIViewController {

    
    @IBOutlet weak var tfSubCategory: DropDown!
    @IBOutlet weak var tfCategory: DropDown!
    @IBOutlet weak var btnLocation: UIButton!
    @IBOutlet var tfProfessionCategory: DropDown!
    
    
    let locationPicker = LocationPickerViewController()
    
    var arrSubCategory = NSMutableArray()
    var arrProfession = NSMutableArray()
    var subCatId = String()
    var arrCategory = NSMutableArray()
    var catId = String()
    var strLat = String()
    var strLong = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  self.title = "Find me"
        // Do any additional setup after loading the view.
        self.call_WsCategory()
        self.call_WsProfessionCategory()
       
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
        super.viewWillAppear(animated)
        
       // self.rightNavButton()
        let dict = AppSharedData.getUserInfo()
        let userInfo = dict["type"]as? String ?? ""
        if userInfo != "user"{
            self.rightNavButton()
        }else{
            
        }
    }
  
    
    @IBAction func btnLocation(_ sender: Any) {
        locationPicker.showCurrentLocationInitially = true
        locationPicker.currentLocationButtonBackground = .blue
        locationPicker.searchTextFieldColor = UIColor.white
        locationPicker.mapType = .standard
        locationPicker.searchBarPlaceholder = "Search places"
        locationPicker.completion = { [self] location in
            AppSharedData.sharedObject().lat = "\(String(describing: location?.coordinate.latitude))"
            AppSharedData.sharedObject().long = "\(String(describing: location?.coordinate.longitude))"
            btnLocation.setTitle(location?.name, for: .normal)
            self.btnLocation.setTitleColor(UIColor.black, for: .normal)
        }
        navigationController?.pushViewController(locationPicker, animated: true)
    }

    @IBAction func btnFindMe(_ sender: Any) {
//        if tfCategory.text! == "" {
//            objAlert.showAlert(message: "Please Select Category", title: "", controller: self)
//        }else if tfSubCategory.text! == "" {
//            objAlert.showAlert(message: "Please Select SubCategory", title: "", controller: self)
//        }else if (AppSharedData.sharedObject().lat == "") && (AppSharedData.sharedObject().long == "") {
//            objAlert.showAlert(message: "Please Select Location", title: "", controller: self)
//        }else{
    let vc = storyboard?.instantiateViewController(identifier: "SearchResultVC") as! SearchResultVC
     vc.catId = self.catId
     vc.subCatId = self.subCatId
    self.navigationController?.pushViewController(vc, animated: true)
        self.tfCategory.optionArray = NSArray() as! [String]
        self.tfSubCategory.optionArray = NSArray() as! [String]
        self.btnLocation.setTitle("", for: .normal)
  //      }
    }
    
    
    func setTfDelegate() {
        tfSubCategory.didSelect{ [self](selectedText , index ,id) in
            let dict = arrSubCategory[index] as! NSDictionary
            self.subCatId = dict["category_id"] as! String
            
        }
        
        tfCategory.didSelect{ [self](selectedText , index ,id) in
            let dict = arrCategory[index] as! NSDictionary
            self.catId = dict["category_id"] as! String
        }
    }

}

extension FindMeVC {
    func call_WsCategory(){
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
            return
        }
        objWebServiceManager.showIndicator()
        objWebServiceManager.requestGet(strURL: WsUrl.url_getCategory, params: [:], queryParams: [:], strCustomValidation: "") { (response) in
            objWebServiceManager.hideIndicator()
//                let jsonDecoder = JSONDecoder()
//                let responseModel = try jsonDecoder.decode(CategoryModel.self, from: response!)
            let status = (response["status"] as? Int)
            let message = (response["message"] as? String)
         //   print(response)
            if status == MessageConstant.k_StatusCode{
                var arrCat = [String]()
                if let user_details  = response["result"] as? NSArray {
                    self.arrCategory = user_details.mutableCopy() as! NSMutableArray
                    for i in 0..<user_details.count {
                        let dict = user_details[i] as! NSDictionary
                        arrCat.append(dict["category_name"] as? String ?? "")
                    }
                    self.tfCategory.optionArray = arrCat
                    self.call_WsSubCategory()
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
    

    func call_WsSubCategory(){
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
            return
        }
        let dicrParam = ["category_id":AppSharedData.sharedObject().catId]as [String:Any]
        objWebServiceManager.showIndicator()
        objWebServiceManager.requestGet(strURL: WsUrl.url_getSubCategory, params: [:], queryParams: [:], strCustomValidation: "") { (response) in
            objWebServiceManager.hideIndicator()
            let status = (response["status"] as? Int)
            let message = (response["message"] as? String)
            print(response)
            if status == MessageConstant.k_StatusCode{
                var arrCat = [String]()
                if let user_details  = response["result"] as? NSArray {
                    self.arrSubCategory = user_details.mutableCopy() as! NSMutableArray
                    for i in 0..<user_details.count {
                        let dict = user_details[i] as! NSDictionary
                        arrCat.append(dict["sub_category_name"] as? String ?? "")
                    }
                    self.tfSubCategory.optionArray = arrCat
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


//MARK:- Call Webservice
extension FindMeVC{
    func call_WsProfessionCategory(){
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
            return
        }
        objWebServiceManager.showIndicator()
        objWebServiceManager.requestGet(strURL: WsUrl.url_getProfession, params: [:], queryParams: [:], strCustomValidation: "") { (response) in
            objWebServiceManager.hideIndicator()

            let status = (response["status"] as? Int)
            let message = (response["message"] as? String)
            print(response)
         
            if status == MessageConstant.k_StatusCode{
                var arrProfessionCat = [String]()
                if let user_details  = response["result"] as? NSArray {
                    self.arrProfession = user_details.mutableCopy() as! NSMutableArray
                    for i in 0..<user_details.count {
                        let dict = user_details[i] as! NSDictionary
                        arrProfessionCat.append(dict["profession_category_name"] as? String ?? "")
                    }
                    self.tfProfessionCategory.optionArray = arrProfessionCat
                  
                }
                else {
                    objAlert.showAlert(message: "Something went wrong!", title: "", controller: self)
                }
            }
            else{
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
