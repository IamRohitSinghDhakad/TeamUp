//
//  EditProfileVC.swift
//  TeamUp
//
//  Created by Apple on 03/09/21.
//

import UIKit

class EditProfileVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
   
    @IBOutlet weak var tvDescription: UITextView!
    @IBOutlet weak var tfFirstName: UITextField!
    @IBOutlet weak var tfAddress: UITextField!
    @IBOutlet weak var tfUserName: UITextField!
    @IBOutlet weak var tfLastName: UITextField!
    @IBOutlet weak var tfMobileNo: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    
    @IBOutlet weak var imgProfile: UIImageView!
    
    let imagePicker = UIImagePickerController()
    var image = UIImage()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Edit Profile"
        self.imagePicker.delegate = self
    }
    
    
    @IBAction func btnSave(_ sender: Any) {
       
        
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
    
    //MARK:- Image Picker Delegate Methods
    //MARK:UIImagePickerControllerDelegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]){
        picker .dismiss(animated: true, completion: nil)
        imgProfile.image=info[UIImagePickerController.InfoKey.originalImage.rawValue] as? UIImage
    }
   
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
