//
//  LoginVC.swift
//  TeamUp
//
//  Created by Apple on 03/09/21.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    

    
    @IBAction func btnDontHaveAcc(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "SignUPVC") as! SignUPVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func btnLogin(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "TabVC") as! TabVC
        vc.selectedIndex = 2
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnForgotPass(_ sender: Any) {
        
    }
}


//MARK:- Call Webservice

extension LoginVC{
    
    func call_WsLogin(){
        
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
            return
        }
        
        objWebServiceManager.showIndicator()
        
        let dicrParam = ["username":self.tfEmail.text!,
                         "password":self.tfPassword.text!]as [String:Any]
        
        objWebServiceManager.requestGet(strURL: WsUrl.url_Login, params: dicrParam, queryParams: [:], strCustomValidation: "") { (response) in
            objWebServiceManager.hideIndicator()
            
            let status = (response["status"] as? Int)
            let message = (response["message"] as? String)
         //   print(response)
            if status == MessageConstant.k_StatusCode{
                if let user_details  = response["result"] as? [String:Any] {
                    let isEmailVerified = user_details["email_verified"] as! String
                    if isEmailVerified == "0" {
                        var strUserName = ""
                        if let userName = user_details["name"]as? String{
                            strUserName = userName
                        }
                        //Show Email Verification Popup
                    
                    }
                    else {
                   //     print(user_details)
                        objAppShareData.SaveUpdateUserInfoFromAppshareData(userDetail: user_details)
                        objAppShareData.fetchUserInfoFromAppshareData()
                        self.pushVc(viewConterlerId: "DemoViewController")
                    }
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
          //  print(Error)
            objWebServiceManager.hideIndicator()
        }
        
        
    }
    
}
