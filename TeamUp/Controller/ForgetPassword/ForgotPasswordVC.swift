//
//  ForgotPasswordVC.swift
//  TeamUp
//
//  Created by Apple on 12/09/21.
//

import UIKit

class ForgotPasswordVC: UIViewController {
    
    
    @IBOutlet weak var tfEmail: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Forgot Password"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnSave(_ sender: Any) {
        if tfEmail.text! == "" {
        objAlert.showAlert(message: MessageConstant.BlankEmail, title: "", controller: self)
        }else{
        self.call_WsForgotPass()
        }
    }
}

//MARK:- Call Webservice
extension ForgotPasswordVC{
    func call_WsForgotPass(){
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
            return
        }
        objWebServiceManager.showIndicator()
        let dicrParam = ["username":self.tfEmail.text!] as [String:Any]
        objWebServiceManager.requestPost(strURL: WsUrl.url_forgotPassword, queryParams: [:], params: dicrParam, strCustomValidation: "", showIndicator: false, success:  { (response) in
            objWebServiceManager.hideIndicator()
            
            let status = (response["status"] as? Int)
            let message = (response["message"] as? String)
        
            if status == MessageConstant.k_StatusCode{
                self.showToast(message: "Success", font: UIFont.systemFont(ofSize: 16.0))
                self.tfEmail.text! = ""
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

