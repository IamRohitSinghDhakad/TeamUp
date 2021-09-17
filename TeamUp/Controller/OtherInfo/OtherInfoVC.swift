//
//  OtherInfoVC.swift
//  TeamUp
//
//  Created by Apple on 05/09/21.
//

import UIKit
import iOSDropDown

class OtherInfoVC: UIViewController {

    @IBOutlet weak var tfAddress: UITextField!
    @IBOutlet weak var tfAgeGroup: UITextField!
    @IBOutlet weak var tfTeamFree: UITextField!
    @IBOutlet weak var tfSchool: UITextField!
    @IBOutlet weak var tfAmount: UITextField!
    @IBOutlet weak var tfSkils: UITextField!
    @IBOutlet weak var tfSportsSkill: DropDown!
    @IBOutlet weak var tfSpecification: DropDown!
    
    
    
    @IBOutlet weak var btnPriceper: UIButton!
    
    @IBOutlet weak var btnFreeTeam: UIButton!
    var arrSubCategory = NSMutableArray()
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.call_WsSubCategory()
        self.btnFreeTeam.setImage(UIImage(named: "circle"), for: .normal)
        self.navigationItem.setHidesBackButton(false, animated: true)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func btnNext(_ sender: Any) {
        self.call_OtherInfo()
    }
    
    @IBAction func btnSelectPrice(_ sender: Any) {
        self.btnPriceper.setImage(UIImage(named: "circle"), for: .normal)
        self.btnFreeTeam.setImage(UIImage(named: "black"), for: .normal)
    }
    
    
    @IBAction func btnSelectionTeam(_ sender: Any) {
        self.btnPriceper.setImage(UIImage(named: "black"), for: .normal)
        self.btnFreeTeam.setImage(UIImage(named: "circle"), for: .normal)
    }
    
    

}

//MARK:- Call Webservice
extension OtherInfoVC{
    
    func call_OtherInfo(){
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
            return
        }
        
        let dicrParam = ["username":AppSharedData.sharedObject().userName,
                         "password":AppSharedData.sharedObject().password,
                         "type":"1",
                         "name":AppSharedData.sharedObject().userFname,
                         "mobile":AppSharedData.sharedObject().phone,
                         "email":AppSharedData.sharedObject().email,
                         "dob":AppSharedData.sharedObject().dob,
                         "age":"29",
                         "sex":"mail",
                         "address":AppSharedData.sharedObject().address,
                         "city":"indore",
                         "country":"india",
                         "pincode":"202245",
                         "business_address":"patnipura",
                         "business_city":"indore",
                         "business_country":"india",
                         "user_image":"",
                         "lat":"29.241426",
                         "lng":"73.517815",
                         "category_id":AppSharedData.sharedObject().catId,
                         "sub_category_id":"3",
                         "other_category":"athlet",
                         "other_sub_category":"",
                         "club_name":AppSharedData.sharedObject().password,
                         "club_address":AppSharedData.sharedObject().password,
                         "age_group":"18",
                         "price":"25",
                         "social_id":"",
                         "social_type":"",
                         "language":"En","register_id":"1"]as [String:Any]
        
        objWebServiceManager.showIndicator()
        objWebServiceManager.requestGet(strURL: WsUrl.url_SignUp, params: dicrParam, queryParams: [:], strCustomValidation: "") { (response) in
            objWebServiceManager.hideIndicator()
            let status = (response["status"] as? Int)
            let message = (response["message"] as? String)
            if status == MessageConstant.k_StatusCode{
                let dict = response as NSDictionary
                let result = (dict["result"] as! NSDictionary)
                if dict.count > 0 {
                    AppSharedData.setUserInfo(dictInfo: result)
                }
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabVC") as! TabVC
                vc.selectedIndex = 2
                self.navigationController?.pushViewController(vc, animated: true)
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
                    
                    self.tfSpecification.optionArray = arrCat
                    self.tfSportsSkill.optionArray = arrCat
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

