//
//  OtherInfoVC.swift
//  TeamUp
//
//  Created by Apple on 05/09/21.
//

import UIKit
import iOSDropDown

class OtherInfoVC: UIViewController,myCategoryDelegate{
    
    

    @IBOutlet weak var tfAddress: UITextField!
    @IBOutlet weak var tfAgeGroup: UITextField!
    @IBOutlet weak var tfTeamFree: UITextField!
    @IBOutlet weak var tfSchool: UITextField!
    @IBOutlet weak var tfSkils: UITextField!
    //@IBOutlet weak var tfSportsSkill: DropDown!
    @IBOutlet weak var lblSubCategory: UILabel!
    
    @IBOutlet weak var btnSportsSkill: UIButton!
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
    @IBOutlet var vwSkillSpecialization: UIView!
    @IBOutlet var vwPerHourText: UIView!
    @IBOutlet var stackVwCoachingClubBtn: UIStackView!
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.vwSkillSpecialization.isHidden = true
        self.vwPerHourText.isHidden = true
        self.call_WsSubCategory()
        self.title = "Other Info"
        self.btnFreeTeam.setImage(UIImage(named: "circle"), for: .normal)
        self.navigationItem.setHidesBackButton(false, animated: true)
        self.userAndProvider(isProvider: AppSharedData.sharedObject().isProvider)
        self.checkMarkSlectone(isCheckMark: true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        
        let allCategory = AppSharedData.sharedObject().allSelectedProfession
        
        if allCategory.contains("coach") || allCategory.contains("personal trainer") || allCategory.contains("specific skill trainer") {
            self.vwSkillSpecialization.isHidden = false
        }else{
            self.vwSkillSpecialization.isHidden = true
        }
        
        if AppSharedData.sharedObject().isProvider{
            if allCategory.contains("sports doctor"){
                self.vwPerHourText.isHidden = true
            }else{
                self.vwPerHourText.isHidden = false
            }
        }else{
            self.vwPerHourText.isHidden = true
        }
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
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
    
    
    @IBAction func btnSportsSkill(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "CategoryVC") as! CategoryVC
        vc.modalPresentationStyle = .popover
        vc.arrSubCategory = self.arrSubCategory
        vc.strType = "SubCat"
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    func getMyCategory(strTitle: String, strId: String) {
        self.subCatId = strId
        
        self.lblSubCategory.text! = strTitle
        self.lblSubCategory.textColor = UIColor.black
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
                         "name":AppSharedData.sharedObject().userName+AppSharedData.sharedObject().userLastname,
                         "mobile":AppSharedData.sharedObject().phone,
                         "email":AppSharedData.sharedObject().email,
                         "dob":AppSharedData.sharedObject().dob,
                         "age":AppSharedData.sharedObject().age,
                         "address":AppSharedData.sharedObject().address,
                         "profession":AppSharedData.sharedObject().profession,
                         "lat":AppSharedData.sharedObject().lat,
                         "lng":AppSharedData.sharedObject().long,
                         "category_id":AppSharedData.sharedObject().catId,
                         "sub_category_id":self.subCatId,
                         "g_fname":AppSharedData.sharedObject().guardianFname,
                         "g_lname":AppSharedData.sharedObject().guardianLname,
                         "g_mobile":AppSharedData.sharedObject().guardianMobileNo,
                         "g_email":AppSharedData.sharedObject().guardianEmail,
                         "relationship":AppSharedData.sharedObject().relationShip,
                         "g_address":AppSharedData.sharedObject().guardianAddress,
                         "g_latitude":AppSharedData.sharedObject().guardianLat,
                         "g_longitude":AppSharedData.sharedObject().guardianLong,
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
                if let user_details  = response["result"] as? NSArray {
                    self.arrSubCategory = user_details.mutableCopy() as! NSMutableArray
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

