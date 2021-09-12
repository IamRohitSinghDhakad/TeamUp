//
//  StepTwoSignUpVC.swift
//  TeamUp
//
//  Created by Rohit Singh Dhakad on 07/09/21.
//

import UIKit

class StepTwoSignUpVC: UIViewController {
    
    
    var catId = String()
    @IBOutlet weak var tfLastName: UITextField!
    @IBOutlet weak var tfFirstName: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tfLastName.delegate = self
        self.tfFirstName.delegate = self
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    // MARK: - TextFieldDelegate
    override func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == tfFirstName {
            tfLastName.becomeFirstResponder()
        }else if textField == tfFirstName {
            tfLastName.resignFirstResponder()
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == tfFirstName {
            let validCharacterSet = NSCharacterSet(charactersIn: ValidationFile.NameAcceptableCharacter).inverted
            let filter = string.components(separatedBy: validCharacterSet)
            if filter.count == 1 {
                let newLength: Int = textField.text!.count + string.count - range.length
                return (newLength > 50) ? false : true
            } else {
                return false
            }
        }
       
        if textField == tfLastName {
            let validCharacterSet = NSCharacterSet(charactersIn: ValidationFile.NameAcceptableCharacter).inverted
            let filter = string.components(separatedBy: validCharacterSet)
            if filter.count == 1 {
                let newLength: Int = textField.text!.count + string.count - range.length
                return (newLength > 50) ? false : true
            } else {
                return false
            }
        }
        return true
    }
    
    @IBAction func btnNext(_ sender: Any) {
        if tfFirstName.text! == "" {
            objAlert.showAlert(message: MessageConstant.BlankFname, title: "", controller: self)
        }else if tfLastName.text! == "" {
            objAlert.showAlert(message: MessageConstant.BlankLname, title: "", controller: self)
        }else{
        let vc = storyboard?.instantiateViewController(identifier: "StepThreeSignUpVC") as! StepThreeSignUpVC
            AppSharedData.sharedObject().userFname = tfFirstName.text!
            AppSharedData.sharedObject().userLastname = tfLastName.text!
        self.navigationController?.pushViewController(vc, animated: true)
        }
    }

}


