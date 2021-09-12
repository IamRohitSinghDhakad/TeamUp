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
        tfFirstName.text! = AppSharedData.sharedObject().userFname
        tfLastName.text! = AppSharedData.sharedObject().userLastname
        tfAddress.text! = AppSharedData.sharedObject().address
        tfEmail.text! = AppSharedData.sharedObject().email
        tfMobile.text! = AppSharedData.sharedObject().phone
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
        }else if tfUserName.text! == "" {
            objAlert.showAlert(message: MessageConstant.BlankUsername, title: "", controller: self)
        }else if tfRelation.text! == "" {
            objAlert.showAlert(message: MessageConstant.BlankRelationship, title: "", controller: self)
        }else if tfAddress.text! == "" {
            objAlert.showAlert(message: MessageConstant.Blankaddress, title: "", controller: self)
        }else{
        let vc = storyboard?.instantiateViewController(identifier: "OtherInfoVC") as! OtherInfoVC
            AppSharedData.sharedObject().relationShip = tfRelation.text!
            AppSharedData.sharedObject().userName = tfUserName.text!
        self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
