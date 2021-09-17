//
//  StepFourSignUpVC.swift
//  TeamUp
//
//  Created by Rohit Singh Dhakad on 07/09/21.
//

import UIKit

class StepFourSignUpVC: UIViewController {

    @IBOutlet var tfAge: UITextField!
    @IBOutlet var tfAddress: UITextField!
    
    var datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showDatePicker()
        self.navigationItem.setHidesBackButton(false, animated: true)
        
                let currentDate = Date()
                var dateComponents = DateComponents()
                let calendar = Calendar.init(identifier: .gregorian)
                dateComponents.year = -18
                let minDate = calendar.date(byAdding: dateComponents, to: currentDate)
                dateComponents.year = -18
                let maxDate = calendar.date(byAdding: dateComponents, to: currentDate)
                datePicker.maximumDate = maxDate
                
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func btnSubmit(_ sender: Any) {
        if tfAge.text! == "" {
            objAlert.showAlert(message: MessageConstant.BlankDOB, title: "", controller: self)
        }else if tfAddress.text! == "" {
            objAlert.showAlert(message: MessageConstant.Blankaddress, title: "", controller: self)
        }else{
        let vc = storyboard?.instantiateViewController(identifier: "GuardinInfoVC") as! GuardinInfoVC
            AppSharedData.sharedObject().age = tfAge.text!
            AppSharedData.sharedObject().address = tfAddress.text!
        self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}


extension StepFourSignUpVC{
    
    func showDatePicker(){
        let screenWidth = UIScreen.main.bounds.width
        datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))//1
        datePicker.datePickerMode = .date //2
        datePicker.maximumDate = Date()

        // iOS 14 and above
        if #available(iOS 14, *) {// Added condition for iOS 14
            datePicker.preferredDatePickerStyle = .wheels
            datePicker.sizeToFit()
        }
        
        //ToolBar
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0)) //4
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolBar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        self.tfAge.inputAccessoryView = toolBar
        self.tfAge.inputView = datePicker
        
    }

      @objc func donedatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-YYYY"
        self.tfAge.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
     }

     @objc func cancelDatePicker(){
        self.view.endEditing(true)
      }
}
