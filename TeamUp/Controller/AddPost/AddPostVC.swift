//
//  AddPostVC.swift
//  TeamUp
//
//  Created by Apple on 03/09/21.
//

import UIKit
import Alamofire

class AddPostVC: UIViewController {
    
    
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var imgProfile: UIImageView!
    
    let imagePicker = UIImagePickerController()
    var image = UIImage()
    var imageData:Data? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add Post"
       
        self.imagePicker.delegate = self
        self.imgProfile.layer.cornerRadius = self.imgProfile.frame.height/2
        self.imgProfile.clipsToBounds = true
    }
    
    @IBAction func btnSelectImage(_ sender: Any) {
        self.ImagePickerOptions()
    }

    @IBAction func btnSave(_ sender: Any) {
        if txtTitle.text == "" {
            objAlert.showAlert(message: MessageConstant.entermessageTitle, title: "", controller: self)
        }else if imageData == nil {
            objAlert.showAlert(message: MessageConstant.selectImage, title: "", controller: self)
        }else {
            let dict = AppSharedData.getUserInfo()
            let url = WsUrl.url_add_post
            let convetUrl = URL(string: url)
            self.upload(image: imageData!, to: convetUrl!, params: ["user_id":dict.GetString(forKey: "user_id"),"type":"image","title":txtTitle.text!,"message":"image"])
        }
    }
 
}

extension AddPostVC:UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
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
    
    //MARK:- Image Picker Delegate Methods
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
            multipart.append(image, withName: "file", fileName: "file.png", mimeType: "image/png")
        }


        AF.upload(multipartFormData: block, to: url)
            .uploadProgress(queue: .main, closure: { progress in
                //Current upload progress of file
                print("Upload Progress: \(progress.fractionCompleted)")
            })
            .responseJSON(completionHandler: { data in
            objWebServiceManager.hideIndicator()
            objAlert.showAlert(message: "Post added Successfully", title: "", controller: self)
            self.navigationController?.popViewController(animated: true)
                //Do what ever you want to do with response
            })
    }
}
extension URLEncoding {
    public func queryParameters(_ parameters: [String: Any]) -> [(String, String)] {
        var components: [(String, String)] = []
        
        for key in parameters.keys.sorted(by: <) {
            let value = parameters[key]!
            components += queryComponents(fromKey: key, value: value)
        }
        return components
    }
}

