//
//  StepThreeSignUpVC.swift
//  TeamUp
//
//  Created by Rohit Singh Dhakad on 07/09/21.
//

import UIKit

class StepThreeSignUpVC: UIViewController,RSCountrySelectedDelegate {
    
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfPhone: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet var lblCountryCode: UILabel!
    
    
    var strCountryDialCode = ""
    var strCountryCode = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        self.navigationItem.setHidesBackButton(false, animated: true)

    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func btnOpenCountryPicker(_ sender: Any) {
        let sb = UIStoryboard.init(name: "CountryPicker", bundle: Bundle.main).instantiateViewController(withIdentifier: "RSCountryPickerController")as! RSCountryPickerController
        sb.RScountryDelegate = self
        self.navigationController?.pushViewController(sb, animated: false)
    }
    
    //MARK:- Protocol to get Country Info
    func RScountrySelected(countrySelected country: CountryInfo) {
        let imagePath = "CountryPicker.bundle/\(country.country_code).png"
       // self.imgVwFlag.image = UIImage(named: imagePath)
        strCountryDialCode = country.dial_code
        strCountryCode = country.country_code
        self.lblCountryCode.text = country.dial_code
    }
    
    @IBAction func btnNext(_ sender: Any) {
        if tfEmail.text! == "" {
            objAlert.showAlert(message: MessageConstant.BlankEmail, title: "", controller: self)
        }else if tfPhone.text! == "" {
            objAlert.showAlert(message: MessageConstant.BlankPhoneNo, title: "", controller: self)
        }else if tfPassword.text! == "" {
            objAlert.showAlert(message: MessageConstant.BlankPassword, title: "", controller: self)
        }else{
        let vc = storyboard?.instantiateViewController(identifier: "StepFourSignUpVC") as! StepFourSignUpVC
            AppSharedData.sharedObject().email = tfEmail.text!
            AppSharedData.sharedObject().phone = tfPhone.text!
            AppSharedData.sharedObject().password = tfPassword.text!
        self.navigationController?.pushViewController(vc, animated: true)
        }
       
    }

}
