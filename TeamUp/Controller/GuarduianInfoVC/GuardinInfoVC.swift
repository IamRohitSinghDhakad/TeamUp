//
//  GuardinInfoVC.swift
//  TeamUp
//
//  Created by Apple on 03/09/21.
//

import UIKit
import LocationPicker

class GuardinInfoVC: UIViewController,RSCountrySelectedDelegate {
    
    

    @IBOutlet weak var tfAddress: UITextField!
    @IBOutlet weak var tfRelation: UITextField!
    @IBOutlet weak var tfLastName: UITextField!
    @IBOutlet weak var tfUserName: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfFirstName: UITextField!
    @IBOutlet weak var tfMobile: UITextField!
    @IBOutlet var lblCountryCode: UILabel!
    
    
    var strCountryDialCode = ""
    var strCountryCode = ""
    let locationPicker = LocationPickerViewController()
    
    
    
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
    
    @IBAction func btnAddress(_ sender: Any) {
        locationPicker.showCurrentLocationInitially = true
        locationPicker.currentLocationButtonBackground = .blue
        locationPicker.searchTextFieldColor = UIColor.white
        locationPicker.mapType = .standard
        locationPicker.searchBarPlaceholder = "Search places"
        locationPicker.completion = { [self] location in
            AppSharedData.sharedObject().guardianLat = "\(String(describing: location?.coordinate.latitude))"
            AppSharedData.sharedObject().guardianLong = "\(String(describing: location?.coordinate.longitude))"
            tfAddress.text = location?.name
        }
        navigationController?.pushViewController(locationPicker, animated: true)

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
            AppSharedData.sharedObject().guardianMobileNo = self.lblCountryCode.text! + tfMobile.text!
            AppSharedData.sharedObject().dialCode = self.lblCountryCode.text!
            AppSharedData.sharedObject().guardianEmail = tfEmail.text!
            AppSharedData.sharedObject().guardianAddress = tfAddress.text!
        self.navigationController?.pushViewController(vc, animated: true)
        }
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
    }
    
}
