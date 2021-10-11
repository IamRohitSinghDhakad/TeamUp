//
//  MessageConstant.swift
//  Somi
//
//  Created by Rohit Singh Dhakad on 25/03/21.
//

import UIKit

class MessageConstant: NSObject {
    //pragma mark - Field validation
    static let ValidEmail: String = "Email Address is not valid, Please provide a valid Email"
    static let ValidPhone: String = "Phone number is not valid, Please provide a valid phone number"
    static let ValidEmailPhone: String = "Email Address / Phone number is not valid, Please provide a valid Email or phone number"
    static let BlankEmail: String = "Please enter your Email"
    static let BlankFname: String = "Please enter your first name"
    static let BlankLname: String = "Please enter your last name"
    static let BlankRelationship: String = "Please enter Relation"
    static let BlankEmailAndPhoneNumber: String = "Please enter your email or phone number"
    static let BlankEmailPass: String = "Please enter your email and password "
    static let BlankPhoneNo: String = "Please enter your Phone number "
    static let BlankLanguage: String = "Please Select Language "
    static let BlankUsername: String = "Please enter full name"
    static let Blankaddress: String = "Please enter address "
    static let BlankGender: String = "Please Select Gender"
    static let BlankDOB: String = "Please enter DOB"
    static let InvalidName: String = "Only alphabeticals allowed in Username"
    static let UploadImage: String = "Please upload image"
    static let InvalidDOB: String = "DOB is not valid, Please provide a valid DOB in formate dd/MMM/yyyy"
    static let BlankAge: String = "Please Select Age "
    static let UsernameLength: String = "Username must be atleast 4 characters long"
    static let BlankPassword: String = "Please enter your Password"
    static let PasswordNotMatched: String = "Retype password not matched"
    static let LengthPassword: String = "Password is too short (minimum 6 characters)"
    static let LengthName: String = "Username is too short (minimum 3 characters)"
    static let BlankConfirmPassword: String = "Please enter confirm password"
    static let NoNetwork: String = "No network connection"
    static let SameConfirmPassword: String = "password and confirm password does not match"
    static let VerifyCode: String = "Please enter the 4 digit code below to verify your mobile number and create your account"
    static let ErrorEmail: String = "Email does not exist in our database, please try alternative."
    static let SentEmail: String = "Email sent. Check your inbox"
    static let SMSSent: String = "SMS sent. Check your phone"

    static let Name_Title : String = "Please enter the Name/Title"
    static let NameValidation : String = "Name and title should be between 3 to 50 characters"
    static let Development: String = "Under Development"
    static let CountrySelection: String = "Please select the country"
    static let stateSelection: String = "Please select the state"
    static let citySelection: String = "Please select the city"
    
    
    static let enterProfession: String = "Please Enter Profession"
    static let entermessageTitle: String = "Please Enter title"
    static let enterDescription: String = "Please Enter title"
    static let selectImage: String = "Please Select Image"
    



    //Color constant
    static let colorTheame = UIColor(red: 14.0 / 255.0, green: 123.0 / 255.0, blue: 122.0 / 255.0, alpha: 1.0)
    static let colorTheameGreeen = UIColor(red: 70.0 / 255.0, green: 170.0 / 255.0, blue: 129.0 / 255.0, alpha: 1.0)
    static let colorTheameYellow = UIColor(red: 239.0 / 255.0, green: 187.0 / 255.0, blue: 107.0 / 255.0, alpha: 1.0)
    static let colorTheameRed = UIColor(red: 222.0 / 255.0, green: 113.0 / 255.0, blue: 127.0 / 255.0, alpha: 1.0)

    //pragma mark -Alert validation
    static let k_AlertMessage: String = "Message"
    static let k_AlertTitle: String = "Alert"
    static let k_ErrorMessage: String = "Something went wrong"
    static let k_success = "success"
   static let k_StatusCode = 1
    static let k_NoConnection: String = "No network connection"
}
