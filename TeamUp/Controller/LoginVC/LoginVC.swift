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
        let vc = storyboard?.instantiateViewController(identifier: "SignUpFirstViewController") as! SignUpFirstViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func btnLogin(_ sender: Any) {
        if tfEmail.text! == "" {
        objAlert.showAlert(message: MessageConstant.BlankEmail, title: "", controller: self)
        }else if tfPassword.text! == "" {
            objAlert.showAlert(message: MessageConstant.BlankPassword, title: "", controller: self)
        }else{
            self.call_WsLogin()
        }
    }
    
    @IBAction func btnForgotPass(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "ForgotPasswordVC") as! ForgotPasswordVC
        self.navigationController?.pushViewController(vc, animated: true)
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
                         "password":self.tfPassword.text!,"register_id":"1"]as [String:Any]
        
        objWebServiceManager.requestGet(strURL: WsUrl.url_Login, params: dicrParam, queryParams: [:], strCustomValidation: "") { (response) in
            objWebServiceManager.hideIndicator()
            
            let status = (response["status"] as? Int)
            let message = (response["message"] as? String)
         //   print(response)
            if status == MessageConstant.k_StatusCode{
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabVC") as! TabVC
                vc.selectedIndex = 0
                self.navigationController?.pushViewController(vc, animated: true)
                let dict = response as NSDictionary
                let result = (dict["result"] as! NSDictionary)
                if dict.count > 0 {
                    AppSharedData.setUserInfo(dictInfo: result)
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
