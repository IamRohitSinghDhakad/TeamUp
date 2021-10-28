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
    
    var profession = ""
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
    
}
