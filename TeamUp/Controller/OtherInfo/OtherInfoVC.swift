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
    @IBOutlet weak var tfSkils: UITextField!
    @IBOutlet weak var tfSportsSkill: DropDown!
    
    @IBOutlet weak var btnCheckMark: UIButton!
    @IBOutlet weak var btnPriceper: UIButton!
    @IBOutlet weak var btnFreeTeam: UIButton!
    var arrSubCategory = NSMutableArray()
    
    @IBOutlet weak var hgtSelectOneView: NSLayoutConstraint!
    @IBOutlet weak var vwAgeGroup: UIView!
    @IBOutlet weak var vwAddress: UIView!
    @IBOutlet weak var vwSchool: UIView!
    @IBOutlet weak var vwTeamFee: UIView!
    
    var subCatId = String()
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.call_WsSubCategory()
        self.btnFreeTeam.setImage(UIImage(named: "circle"), for: .normal)
        self.navigationItem.setHidesBackButton(false, animated: true)
        self.userAndProvider(isProvider: AppSharedData.sharedObject().isProvider)
        self.checkMarkSlectone(isCheckMark: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    
    func setTfDelegate() {
        tfSportsSkill.didSelect{ [self](selectedText , index ,id) in
            let dict = arrSubCategory[index] as! NSDictionary
            self.subCatId = dict["category_id"] as! String
            
        }
    }
    
    func userAndProvider(isProvider:Bool) {
        if (isProvider) {
            self.hgtSelectOneView.constant = 112
        }
        else
        {
        self.hgtSelectOneView.constant = 0
        }
    }
    
    @IBAction func btnNext(_ sender: Any) {
        self.call_OtherInfo()
    }
    
    @IBAction func btnSelectPrice(_ sender: Any) {
        self.btnPriceper.setImage(UIImage(named: "circle"), for: .normal)
        self.btnFreeTeam.setImage(UIImage(named: "black"), for: .normal)
    }
    
    
    @IBAction func btnCheckMark(_ sender: Any) {
        if (btnCheckMark.isSelected == false) {
            self.btnCheckMark.isSelected = true
            self.btnCheckMark.setImage(UIImage(named: "box"), for: .normal)
            self.checkMarkSlectone(isCheckMark: true)
        }else if (btnCheckMark.isSelected == true){
            self.btnCheckMark.setImage(UIImage(named: "check"), for: .normal)
            self.checkMarkSlectone(isCheckMark: false)
            self.btnCheckMark.isSelected = false
        }
        
    }
        func checkMarkSlectone(isCheckMark:Bool) {
            if (isCheckMark) {
                self.vwSchool.isHidden = true
                self.vwAddress.isHidden = true
                self.vwTeamFee.isHidden = true
                self.vwAgeGroup.isHidden = true
            }else{
                self.vwSchool.isHidden = false
                self.vwAddress.isHidden = false
                self.vwTeamFee.isHidden = false
                self.vwAgeGroup.isHidden = false
            }
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
        
        let dicrParam = ["password":AppSharedData.sharedObject().password,
                         "type":"1",
                         "first_name":AppSharedData.sharedObject().userFname,
                         "last_name":AppSharedData.sharedObject().userLastname,
                         "name":AppSharedData.sharedObject().userName,
                         "mobile":AppSharedData.sharedObject().phone,
                         "email":AppSharedData.sharedObject().email,
                         "dob":AppSharedData.sharedObject().dob,
                         "age":AppSharedData.sharedObject().age,
                         "address":AppSharedData.sharedObject().address,
                         "profession":AppSharedData.sharedObject().profession,
                         "lat":"29.241426",
                         "lng":"73.517815",
                         "category_id":AppSharedData.sharedObject().catId,
                         "sub_category_id":self.subCatId,
                         "g_fname":AppSharedData.sharedObject().guardianFname,
                         "g_lname":AppSharedData.sharedObject().guardianLname,
                         "g_mobile":AppSharedData.sharedObject().guardianMobileNo,
                         "g_email":AppSharedData.sharedObject().guardianEmail,
                         "relationship":AppSharedData.sharedObject().relationShip,
                         "g_address":AppSharedData.sharedObject().guardianAddress,
                         "g_latitude":"29.241426",
                         "g_longitude":"73.517815",
                         "club_name":tfSchool.text!,
                         "club_address":tfAddress.text!,
                         "age_group":tfAgeGroup.text!,
                         "price":tfTeamFree.text!,
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

