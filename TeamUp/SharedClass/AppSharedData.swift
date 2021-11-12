//
//  AppSharedData.swift
//  Somi
//
//  Created by Rohit Singh Dhakad on 25/03/21.
//

import UIKit


let objAppShareData : AppSharedData  = AppSharedData.sharedObject()


class AppSharedData: NSObject {

    //MARK: - Shared object
    private static var sharedManager: AppSharedData = {
        let manager = AppSharedData()
        return manager
    }()
    
    // MARK: - Accessors
    class func sharedObject() -> AppSharedData {
        return sharedManager
    }
    
    //MARK:- Variables
    var UserDetail = userDetailModel(dict: [:])
    var strFirebaseToken = ""
    var isFromNotification = Bool()
    var isNotificationDict = [String:Any]()
    var catId = ""
    var userFname = ""
    var userLastname = ""
    var email = ""
    var password = ""
    var phone = ""
    var dialCode = ""
    var dob = ""
    var address = ""
    var age = ""
    var userName = ""
    var lat = ""
    var long = ""
    var userType = ""
    var profession = ""
    var language = ""
    var professionID = ""
    var allSelectedProfession = ""
    var isProvider = Bool()
    
   ///Guardian Information
    var guardianFname = ""
    var guardianLname = ""
    var guardianMobileNo = ""
    var guardianEmail = ""
    var guardianAddress = ""
    var relationShip = ""
    var guardianLat = ""
    var guardianLong = ""
    
    //toggleStatus
    var strToggleStatus = Bool()
    
    
    
    static let userInfo = "Infinote"
    

    open var isLoggedIn: Bool {
        get {
            if (UserDefaults.standard.value(forKey:  UserDefaults.KeysDefault.userInfo) as? [String : Any]) != nil {
                objAppShareData.fetchUserInfoFromAppshareData()
                return true
            }
            return false
        }
    }
    
    
    class func setUserInfo(dictInfo: NSDictionary?){
        let userDefaults = UserDefaults.standard
        userDefaults.set(dictInfo, forKey: AppSharedData.userInfo)
    }
    
    class func getUserInfo() -> NSDictionary {
        if let dict = UserDefaults.standard.dictionary(forKey: AppSharedData.userInfo) {
            let dictData = dict as NSDictionary
            return dictData
        }
        return NSDictionary()
    }
    
    // MARK: - saveUpdateUserInfoFromAppshareData ---------------------
    func SaveUpdateUserInfoFromAppshareData(userDetail:[String:Any])
    {
        let outputDict = self.removeNSNull(from:userDetail)
        
        UserDefaults.standard.set(outputDict, forKey: UserDefaults.KeysDefault.userInfo)
        
    }
    
    // MARK: - FetchUserInfoFromAppshareData -------------------------
    func fetchUserInfoFromAppshareData()
    {
        
        if let userDic = UserDefaults.standard.value(forKey:  UserDefaults.KeysDefault.userInfo) as? [String : Any]{
            
            UserDetail = userDetailModel.init(dict: userDic)
        }
    }
    
    func removeNSNull(from dict: [String: Any]) -> [String: Any] {
        var mutableDict = dict
        let keysWithEmptString = dict.filter { $0.1 is NSNull }.map { $0.0 }
        for key in keysWithEmptString {
            mutableDict[key] = ""
            print(key)
        }
        return mutableDict
    }
    
    //MARK: - Sign Out
    
    func signOut() {
        UserDefaults.standard.removeObject(forKey: UserDefaults.KeysDefault.userInfo)
        UserDetail = userDetailModel(dict: [:])
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let vc = (UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "TabVC") as? TabVC)!
        let navController = UINavigationController(rootViewController: vc)
        navController.isNavigationBarHidden = true
        appDelegate.window?.rootViewController = navController
    }
    
    
    func call_UpDateToggleStatus(strStatus:String){
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
           // objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
            return
        }
        objWebServiceManager.showIndicator()
        
        let dict = AppSharedData.getUserInfo()
        
      //  let param = ["statua":strStatus,
       //              "user_id":dict["user_id"] ?? ""]as [String:Any]
       // print(param)
        let url  = WsUrl.url_update_profile + "user_id=\(dict["user_id"] ?? "")&status=\(strStatus)"
        print(url)
        objWebServiceManager.requestGet(strURL: url, params: [:], queryParams: [:], strCustomValidation: "") { (response) in
            let json = response as NSDictionary
            let status = json.GetInt(forKey: "status")
            print(response)
            objWebServiceManager.hideIndicator()
            if status == 1 {
                self.setProfileData(dict: json.GetNSDictionary(forKey: "result"))
            }else{
              //  objAlert.showAlert(message: "Data Not Found", title: "Alert", controller: self)
            }
        } failure: { (Error) in
            objWebServiceManager.hideIndicator()
        }
    }
    
    func setProfileData(dict:NSDictionary) {
        let status = dict.GetString(forKey: "status")
        if status == "1"{
            AppSharedData.sharedObject().strToggleStatus = true
        }else{
            AppSharedData.sharedObject().strToggleStatus = false
        }
    }
    
}
