//
//  SignUPVC.swift
//  TeamUp
//
//  Created by Apple on 03/09/21.
//

import UIKit
import iOSDropDown

class SignUPVC: UIViewController,myCategoryDelegate {
    
    
    @IBOutlet weak var btnCategory: UIButton!
    
    var arrCategory = NSMutableArray()
    var catId = String()
    
    @IBOutlet weak var viewDropDown: DropDown!
    @IBOutlet weak var tfProffession: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.call_WsCategory()
        self.navigationItem.setHidesBackButton(false, animated: true)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        
      
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func btnChooseCategory(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "CategoryVC") as! CategoryVC
        vc.modalPresentationStyle = .popover
        vc.arrCategory = self.arrCategory
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    func getMyCategory(strTitle: String, strId: String) {
        AppSharedData.sharedObject().catId = strId
        self.catId = strId
        self.btnCategory.setTitle(strTitle, for: .normal)
        self.btnCategory.setTitleColor(UIColor.black, for: .normal)
    }
    
    
    
    @IBAction func btnSignUp(_ sender: Any) {
        if self.catId == "" {
        objAlert.showAlert(message: "Please Select Category", title: "", controller: self)
        }else if tfProffession.text == "" {
            objAlert.showAlert(message: MessageConstant.enterProfession, title: "", controller: self)
        }else{
        let vc = storyboard?.instantiateViewController(identifier: "StepTwoSignUpVC") as! StepTwoSignUpVC
            AppSharedData.sharedObject().profession = self.tfProffession.text!
        self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func btnLogIn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
    //MARK:- Call Webservice
    extension SignUPVC{
        func call_WsCategory(){
            if !objWebServiceManager.isNetworkAvailable(){
                objWebServiceManager.hideIndicator()
                objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
                return
            }
            objWebServiceManager.showIndicator()
            objWebServiceManager.requestGet(strURL: WsUrl.url_getCategory, params: [:], queryParams: [:], strCustomValidation: "") { (response) in
                objWebServiceManager.hideIndicator()
//                let jsonDecoder = JSONDecoder()
//                let responseModel = try jsonDecoder.decode(CategoryModel.self, from: response!)
                let status = (response["status"] as? Int)
                let message = (response["message"] as? String)
             //   print(response)
                if status == MessageConstant.k_StatusCode{
                    if let user_details  = response["result"] as? NSArray {
                        self.arrCategory = user_details.mutableCopy() as! NSMutableArray
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

   


