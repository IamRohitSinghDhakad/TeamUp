//
//  BookAppointMentVC.swift
//  TeamUp
//
//  Created by Apple on 05/09/21.
//

import UIKit

class BookAppointMentVC: UIViewController {
    
    
    
    
    @IBOutlet weak var tfSelectDate: UITextField!
    @IBOutlet weak var tvDescription: UITextView!
    @IBOutlet weak var tfSelectTime: UITextField!
    
    var datePicker = UIDatePicker()
    var dictData = NSDictionary()
    var type = Int()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let currentDate = Date()
        var dateComponents = DateComponents()
        let calendar = Calendar.init(identifier: .gregorian)
        dateComponents.year = +80
        let maxDate = calendar.date(byAdding: dateComponents, to: currentDate)
        datePicker.maximumDate = maxDate
        self.tfSelectDate.delegate = self
        self.tfSelectTime.delegate = self
    }
    

  
    
    @IBAction func btnBook(_ sender: Any) {
        if tfSelectDate.text! == "" {
            objAlert.showAlert(message: "Please Select Date", title: "", controller: self)
        }else if tfSelectTime.text! == "" {
            objAlert.showAlert(message: "Please Select Time", title: "", controller: self)
        }else if tvDescription.text! == "" {
            objAlert.showAlert(message: "Please Enter Description", title: "", controller: self)
        }else{
            self.call_BookAppointMentVC()
        }
        
    }
    
    @IBAction func btnCross(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == tfSelectDate {
            self.showDatePicker(strType: "date")
        }else if textField == tfSelectTime {
            self.showDatePicker(strType: "")
        }
    }
    
}



extension BookAppointMentVC {
    
    func showDatePicker(strType:String){
        let screenWidth = UIScreen.main.bounds.width
        datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))//1
        if strType == "date" {
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()

        // iOS 14 and above
        if #available(iOS 14, *) {
            datePicker.preferredDatePickerStyle = .wheels
            datePicker.sizeToFit()
        }
        self.type = 1
        //ToolBar
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0)) //4
        let doneButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        toolBar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        self.tfSelectDate.inputAccessoryView = toolBar
        self.tfSelectDate.inputView = datePicker
        }else{
            datePicker.datePickerMode = .time
            datePicker.maximumDate = Date()
            
            // iOS 14 and above
            if #available(iOS 14, *) {
                datePicker.preferredDatePickerStyle = .wheels
                datePicker.sizeToFit()
            }
            self.type = 2
            //ToolBar
            let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0)) //4
            let doneButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
            let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
            let cancelButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
            
            toolBar.setItems([doneButton,spaceButton,cancelButton], animated: false)
            self.tfSelectTime.inputAccessoryView = toolBar
            self.tfSelectTime.inputView = datePicker
        }
    }

    @objc func donedatePicker(){
        let formatter = DateFormatter()
        if type == 1 {
        formatter.dateFormat = "YYYY-MM-dd"
        self.tfSelectDate.text = formatter.string(from: datePicker.date)
        }else if type == 2 {
        formatter.dateFormat = "hh:mm:ss"
        self.tfSelectTime.text = formatter.string(from: datePicker.date)
        }
        self.view.endEditing(true)
     }

     @objc func cancelDatePicker(){
        self.view.endEditing(true)
      }
}

//https://ambitious.in.net/Arun/teamUp/index.php/api/book_appointment?from_user_id=2&to_user_id=3&appointment_date=2020-10-03&appointment_time=12:00:00&description=test&status=pending

//MARK:- Call Webservice
extension BookAppointMentVC {
    func call_BookAppointMentVC(){
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
            return
        }
        
        objWebServiceManager.showIndicator()
        let dict = AppSharedData.getUserInfo()
        let userId = dict.GetString(forKey: "user_id")
        let userToId = dictData.GetString(forKey: "user_id")
     
        let selectedDate = "&appointment_date=\(tfSelectDate.text!)"
        let selectedTime = "&appointment_time=\(tfSelectTime.text!)"
        let selectedUserId = "&to_user_id=\(userToId)"
        let selectedFromUserId = "?from_user_id=\(userId)"
        let selectedDescription = "&description==\(tvDescription.text!)"
        let selectedStatus = "&status=Pending"
        
        let url  = WsUrl.url_book_appointment+"\(selectedFromUserId)\(selectedUserId)\(selectedDate)\(selectedTime)\(selectedDescription)\(selectedStatus)"
        objWebServiceManager.requestGet(strURL: url, params: [:], queryParams: [:], strCustomValidation: "") { (response) in
            let json = response as NSDictionary
            let status = json.GetInt(forKey: "status")
            objWebServiceManager.hideIndicator()
            if status == 1 {
                self.dismiss(animated: true, completion: nil)
            }else{
                objAlert.showAlert(message: "Something went wrong!", title: "", controller: self)
            }
        } failure: { (Error) in
            objWebServiceManager.hideIndicator()
        }
    }
}
