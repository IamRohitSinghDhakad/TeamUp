//
//  EditProfileVC.swift
//  TeamUp
//
//  Created by Apple on 03/09/21.
//

import UIKit
import Alamofire
import Kingfisher

class EditProfileVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
   
    @IBOutlet weak var tfDob: UITextField!
    @IBOutlet weak var tvDescription: UITextView!
    @IBOutlet weak var tfFirstName: UITextField!
    @IBOutlet weak var tfAddress: UITextField!
    @IBOutlet weak var tfLastName: UITextField!
    @IBOutlet weak var tfMobileNo: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var tfpassword: UITextField!
    
    
    
    let imagePicker = UIImagePickerController()
    var image = UIImage()
    var imageData:Data? = nil
    
    var datePicker = UIDatePicker()
    var dictData:Result?
    var arrProfileData = NSMutableArray()
    
    var intYear = Int()
    var intMonth = Int()
    var intDay = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Edit Profile"
        self.imagePicker.delegate = self
        self.call_EditProfile()
        
        let currentDate = Date()
        var dateComponents = DateComponents()
        let calendar = Calendar.init(identifier: .gregorian)
        dateComponents.year = 0
        let minDate = calendar.date(byAdding: dateComponents, to: currentDate)
        dateComponents.year = 0
        let maxDate = calendar.date(byAdding: dateComponents, to: currentDate)
        datePicker.maximumDate = maxDate
        self.showDatePicker()
        self.imgProfile.layer.cornerRadius = self.imgProfile.frame.height/2
        self.imgProfile.clipsToBounds = true
    }
    
    
    @IBAction func btnSave(_ sender: Any) {
        if tfFirstName.text == "" {
            objAlert.showAlert(message: MessageConstant.entermessageTitle, title: "", controller: self)
        }else if imgProfile.image == nil {
            objAlert.showAlert(message: MessageConstant.selectImage, title: "", controller: self)
        }else {
            let dict = AppSharedData.getUserInfo()
            let url = WsUrl.url_update_profile
            let convetUrl = URL(string: url)
            self.upload(image: (imgProfile.image?.jpegData(compressionQuality: 0.5))!, to: convetUrl!, params: ["user_id":dict.GetString(forKey: "user_id"),"email":tfEmail.text!,"first_name":tfFirstName.text!,"last_name":tfLastName.text!,"mobile":tfMobileNo.text!,"address":tfAddress.text!,"dob":tfDob.text!,"password":tfpassword.text!])
        }
    }
    
    @IBAction func btnEditProfile(_ sender: Any) {
        self.ImagePickerOptions()
    }
    
}



extension EditProfileVC {
    
    //MARK:- ImagePicker Options Method
    func ImagePickerOptions (){
        self.view.endEditing(true)
        
        let alert: UIAlertController = UIAlertController(title: "Choose Image", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: UIAlertAction.Style.default)  {
            UIAlertAction in
            self.openCamera()
        }
        let gallaryAction = UIAlertAction(title: "Gallery", style: UIAlertAction.Style.default)  {
            UIAlertAction in
            self.openGallary()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)  {
            UIAlertAction in
        }
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        alert.addAction(cancelAction)
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.present(alert, animated: true, completion: nil)
        } else {
            
        }
        
    }
    
    func openCamera() {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)) {
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            self .present(imagePicker, animated: true, completion: nil)
        }  else  {
            openGallary()
        }
    }
    
    func openGallary() {
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.present(imagePicker, animated: true, completion: nil)
        } else  {
        }
    }
    
    //MARK:UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let tempImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        imgProfile.image  = tempImage
        self.imageData = tempImage.jpegData(compressionQuality: 0.5)
        self.dismiss(animated: true, completion: nil)
    }
   
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}






//MARK:- Call Webservice
extension EditProfileVC{
    func call_EditProfile(){
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
            return
        }
        objWebServiceManager.showIndicator()
        let dict = AppSharedData.getUserInfo()
        let url  = WsUrl.url_getUserProfile+"?user_id=\(dict["user_id"] ?? "")"
        
        objWebServiceManager.requestGet(strURL: url, params: [:], queryParams: [:], strCustomValidation: "") { (response) in
            let json = response as NSDictionary
            
            print(json)
            
            let status = json.GetInt(forKey: "status")
            objWebServiceManager.hideIndicator()
            if status == 1 {
                self.setProfileData(dict: json.GetNSDictionary(forKey: "result"))
            }else{
                objAlert.showAlert(message: "Data Not Found", title: "Alert", controller: self)
            }
        } failure: { (Error) in
            objWebServiceManager.hideIndicator()
        }
    }
    
    func setProfileData(dict:NSDictionary) {
        self.tfEmail.text! = dict.GetString(forKey: "email")
        self.tfFirstName.text! = dict.GetString(forKey: "first_name")
        self.tfLastName.text! = dict.GetString(forKey: "last_name")
        self.tfMobileNo.text! = dict.GetString(forKey: "mobile")
        self.tfAddress.text! = dict.GetString(forKey: "address")
        self.tfDob.text! = dict.GetString(forKey: "dob")
        self.tfpassword.text! = dict.GetString(forKey: "password")
        
//        let image = dict.GetString(forKey: "user_image")
//        self.imgProfile.image = UIImage(named: "DefaultUserIcon")
//        if image != "" {
//        let url = URL(string: image ?? "")
//            self.imgProfile.kf.setImage(with: url)
//            self.imageData = imgProfile.image?.jpegData(compressionQuality: 0.5)
//        }
        
       // if let user_image = dict.GetString(forKey: "user_image"){
           let profilePic = dict.GetString(forKey: "user_image")
            if profilePic != "" {
                let url = URL(string: profilePic)
                self.imgProfile.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "DefaultUserIcon"))
            }
//        }else{
//            self.imgProfile.image = #imageLiteral(resourceName: "DefaultUserIcon")
//        }

        
    }
}

//MARK:- Call Webservice
extension EditProfileVC{
    func call_UpDateProfile(){
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
            return
        }
        objWebServiceManager.showIndicator()
        let dict = AppSharedData.getUserInfo()
        let title = "&name=\(tfFirstName.text!)"
        let msg = "&message=\(tfLastName.text!)"
        let url  = WsUrl.url_update_profile+"?user_id=\(dict["user_id"] ?? "")\(title)\(msg)"
        objWebServiceManager.requestGet(strURL: url, params: [:], queryParams: [:], strCustomValidation: "") { (response) in
            let json = response as NSDictionary
            let status = json.GetInt(forKey: "status")
            objWebServiceManager.hideIndicator()
            if status == 1 {
                
            }else{
                objAlert.showAlert(message: "Something went wrong!", title: "", controller: self)
            }
        } failure: { (Error) in
            objWebServiceManager.hideIndicator()
        }
    }
}

extension EditProfileVC{
    
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
        
        self.tfDob.inputAccessoryView = toolBar
        self.tfDob.inputView = datePicker
        
    }

      @objc func donedatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-YYYY"
        self.tfDob.text = formatter.string(from: datePicker.date)
        let age  = getAgeFromDOF(date: self.tfDob.text!)
        self.intYear = (age.0)
        self.intMonth = (age.1)
        self.intDay = (age.2)
        self.view.endEditing(true)
       
     }

     @objc func cancelDatePicker(){
        self.view.endEditing(true)
      }
    func getAgeFromDOF(date: String) -> (Int,Int,Int) {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "dd-MM-YYYY"
        let dateOfBirth = dateFormater.date(from: date)
        let calender = Calendar.current
        let dateComponent = calender.dateComponents([.year, .month, .day], from:
        dateOfBirth!, to: Date())
        return (dateComponent.year!, dateComponent.month!, dateComponent.day!)
    }
    
    func upload(image: Data, to url: URL, params: [String: Any]) {
        if !objWebServiceManager.isNetworkAvailable(){
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "No Internet Connection", title: "Alert", controller: self)
            return
        }
        
        objWebServiceManager.showIndicator()
        let block = { (multipart: MultipartFormData) in
            URLEncoding.default.queryParameters(params).forEach { (key, value) in
                if let data = value.data(using: .utf8) {
                    multipart.append(data, withName: key)
                }
            }
            multipart.append(image, withName: "user_image", fileName: "user_image.png", mimeType: "image/png")
        }

        AF.upload(multipartFormData: block, to: url)
            .uploadProgress(queue: .main, closure: { progress in
               
                print("Upload Progress: \(progress.fractionCompleted)")
            })
            .responseJSON(completionHandler: { data in
            objWebServiceManager.hideIndicator()
                // Data to Swift Dictionary
                do {
                    if let jsonData = data.data{
                        let parsedData = try JSONSerialization.jsonObject(with: jsonData) as! Dictionary<String, AnyObject>
                        print(parsedData)
                        let dictionary = parsedData as NSDictionary
                        print("dictionary>>>>>\(dictionary)")
                        let result = (dictionary["result"] as! NSDictionary)
                        if result.count > 0 {
                            AppSharedData.setUserInfo(dictInfo: result)
                        }
                    }
                    }catch{
                       
                    }
                
            objAlert.showAlert(message: "Profile Update Successfully", title: "", controller: self)
            self.navigationController?.popViewController(animated: true)
                //Do what ever you want to do with response
            })
    }
}

