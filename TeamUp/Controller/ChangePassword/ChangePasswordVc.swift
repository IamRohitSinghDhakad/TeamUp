//
//  ChangePasswordVc.swift
//  Infinote
//
//  Created by Clarigo Infotech private Limited  on 03/10/19.
//  Copyright © 2019 Clarigo Infotech private Limited . All rights reserved.
//

import UIKit

class ChangePasswordVc: UIViewController {

    //MARK:- ClassOutlets
    @IBOutlet weak var tfOldPassword: UITextField!
    
    @IBOutlet weak var tfNewPassword: UITextField!
    
   
    
    //MARK:- ClassVariables
    
    
    //MARK:- ViewLifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Change Password"
        self.tfOldPassword.isSecureTextEntry = true
        self.tfNewPassword.isSecureTextEntry = true
        
    }
    
    @IBAction func btnSubmit(_ sender: Any) {
        if tfOldPassword.text! == "" {
            self.view.makeToast("Please Enter OldPassword")
        }else if tfNewPassword.text! == "" {
            self.view.makeToast("Please Enter NewPassword")
        }else if tfNewPassword.text! == tfOldPassword.text! {
           self.view.makeToast("Don't Match Newpassword and Oldpassword")
        }else {
            self.call_WsChangePassword()
        }
    }
    
}

//MARK:- Call Webservice
extension ChangePasswordVc{
    func call_WsChangePassword(){
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
            return
        }
        objWebServiceManager.showIndicator()
        let dicrParam = ["old_password":self.tfOldPassword.text!,"new_password":self.tfNewPassword.text!] as [String:Any]
        objWebServiceManager.requestPost(strURL: WsUrl.url_ChangePassword, queryParams: [:], params: dicrParam, strCustomValidation: "", showIndicator: false, success:  { (response) in
            objWebServiceManager.hideIndicator()
            let status = (response["status"] as? Int)
            let message = (response["message"] as? String)
        
            if status == MessageConstant.k_StatusCode{
                self.showToast(message: "Success", font: UIFont.systemFont(ofSize: 16.0))
                self.navigationController?.popViewController(animated: true)
            }else{
                objWebServiceManager.hideIndicator()
                if let msgg = response["result"]as? String{
                    objAlert.showAlert(message: msgg, title: "", controller: self)
                }else{
                    objAlert.showAlert(message: message ?? "", title: "", controller: self)
                }
            }
        }, failure: { (Error) in
            objWebServiceManager.hideIndicator()
        })
        
    }
    
}
   
