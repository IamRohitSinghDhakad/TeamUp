//
//  ContactUsVc.swift
//  TeamUp
//
//  Created by Apple on 30/09/21.
//

import UIKit

class ContactUsVc: UIViewController {
    
    
    @IBOutlet weak var tvDescription: UITextView!
    @IBOutlet weak var tfFeedbackTitle: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Contact Us"
        self.tvDescription.layer.borderWidth = 1
        self.tvDescription.layer.borderColor = UIColor.lightGray.cgColor
        self.tvDescription.layer.cornerRadius = 5
      
    }
    
    @IBAction func btnSubmit(_ sender: Any) {
        if tfFeedbackTitle.text! == "" {
            objAlert.showAlert(message: MessageConstant.entermessageTitle, title: "", controller: self)
        }else if tvDescription.text! == "" {
            objAlert.showAlert(message: MessageConstant.enterDescription, title: "", controller: self)
        }else {
            self.call_ContactUs()
        }
        
    }
    

}

//MARK:- Call Webservice
extension ContactUsVc{
    func call_ContactUs(){
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
            return
        }
        objWebServiceManager.showIndicator()
        let dict = AppSharedData.getUserInfo()
        
        let title = "&title=\(tfFeedbackTitle.text!)"
        let msg = "&message=\(tvDescription.text!)"
        
        let url  = WsUrl.url_contact_us+"?user_id=\(dict["user_id"] ?? "")\(title)\(msg)"
        objWebServiceManager.requestGet(strURL: url, params: [:], queryParams: [:], strCustomValidation: "") { (response) in
            let json = response as NSDictionary
            let status = json.GetInt(forKey: "status")
            objWebServiceManager.hideIndicator()
            if status == 1 {
                self.navigationController?.popViewController(animated: true)
            }else{
                objAlert.showAlert(message: "Something went wrong!", title: "", controller: self)
            }
        } failure: { (Error) in
            objWebServiceManager.hideIndicator()
        }
    }
}
