//
//  GuardinInfoVC.swift
//  TeamUp
//
//  Created by Apple on 03/09/21.
//

import UIKit

class GuardinInfoVC: UIViewController {

    @IBOutlet weak var tfAddress: UITextField!
    @IBOutlet weak var tfRelation: UITextField!
    @IBOutlet weak var tfLastName: UITextField!
    @IBOutlet weak var tfUserName: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfFirstName: UITextField!
    @IBOutlet weak var tfMobile: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(false, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    

    @IBAction func btnEditProfile(_ sender: Any) {
        if tfFirstName.text! == "" {
            objAlert.showAlert(message: MessageConstant.BlankFname, title: "", controller: self)
        }else if tfLastName.text! == "" {
            objAlert.showAlert(message: MessageConstant.BlankLname, title: "", controller: self)
        }else if tfMobile.text! == "" {
            objAlert.showAlert(message: MessageConstant.BlankPhoneNo, title: "", controller: self)
        }else if tfEmail.text! == "" {
            objAlert.showAlert(message: MessageConstant.BlankEmail, title: "", controller: self)
        }else if tfRelation.text! == "" {
            objAlert.showAlert(message: MessageConstant.BlankRelationship, title: "", controller: self)
        }else if tfAddress.text! == "" {
            objAlert.showAlert(message: MessageConstant.Blankaddress, title: "", controller: self)
        }else{
        let vc = storyboard?.instantiateViewController(identifier: "OtherInfoVC") as! OtherInfoVC
            AppSharedData.sharedObject().relationShip = tfRelation.text!
            AppSharedData.sharedObject().guardianFname = tfFirstName.text!
            AppSharedData.sharedObject().guardianLname = tfLastName.text!
            AppSharedData.sharedObject().guardianMobileNo = tfMobile.text!
            AppSharedData.sharedObject().guardianEmail = tfEmail.text!
            AppSharedData.sharedObject().guardianAddress = tfAddress.text!
        self.navigationController?.pushViewController(vc, animated: true)
        }
    }
 
}
