// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct ProfileData: Codable {
    let result: Result
    let message: String
    let status: Int
}

// MARK: - Result
struct Result: Codable {
    let userID, type, code, profession: String
    let firstName, lastName, name, mobile: String
    let email, password, dob, age: String
    let address: String
    let userImage: String
    let otp, lat, lng, categoryID: String
    let subCategoryID, clubName, clubAddress, ageGroup: String
    let price, gFname, gLname, gMobile: String
    let gEmail, relationship, gAddress, gLatitude: String
    let gLongitude, socialID, socialType, language: String
    let registerID, status, entryby, entrydt: String
    let categoryName, rating: String

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case type, code, profession
        case firstName = "first_name"
        case lastName = "last_name"
        case name, mobile, email, password, dob, age, address
        case userImage = "user_image"
        case otp, lat, lng
        case categoryID = "category_id"
        case subCategoryID = "sub_category_id"
        case clubName = "club_name"
        case clubAddress = "club_address"
        case ageGroup = "age_group"
        case price
        case gFname = "g_fname"
        case gLname = "g_lname"
        case gMobile = "g_mobile"
        case gEmail = "g_email"
        case relationship
        case gAddress = "g_address"
        case gLatitude = "g_latitude"
        case gLongitude = "g_longitude"
        case socialID = "social_id"
        case socialType = "social_type"
        case language
        case registerID = "register_id"
        case status, entryby, entrydt
        case categoryName = "category_name"
        case rating
    }
}
