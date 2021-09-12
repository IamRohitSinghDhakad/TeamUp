

import UIKit

class ValidationFile: NSObject {
    
    static let emailAcceptableCharacter = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_.-@"
    static let AddressAcceptableCharacter = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890,/-@:;?.!'&@[]{}#%^*+=_$ "
    static  let NameAcceptableCharacter = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ. "
    static  let ZipCodeAcceptableCharacter = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890- "
    static  let numberAcceptableCharacter = "1234567890"
    static  let decimalAcceptableCharacter = "1234567890."
    static  let SpecialAcceptableCharacter = "1234567890.$"
    
    func isValidEmail(strEmail:String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}", options: .caseInsensitive)
            return regex.firstMatch(in: strEmail, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, strEmail.count)) != nil
        } catch {
            return false
        }
    }
    func checkEnterFloatInTextFiled(strValue : String,strPoint : Float) -> Bool{
        if let BudgetValue : Float  = Float(strValue){
            if BudgetValue <= Float(strPoint){
                let arrFloatBrack : [String] = strValue.components(separatedBy: ".")
                if arrFloatBrack.count >= 2{
                    let afterDot = arrFloatBrack[1]
                    if afterDot.count <= 2{
                        return true
                    }
                    return false
                }
                return true
            }
        }
        return false
    }
    
    func checkEnterFloatInTextFiled1(strValue : String) -> Bool{
        if let BudgetValue : Float  = Float(strValue){
            if BudgetValue <= Float(10000.00){
                let arrFloatBrack : [String] = strValue.components(separatedBy: ".")
                if arrFloatBrack.count >= 2{
                    let afterDot = arrFloatBrack[1]
                    if afterDot.count <= 2{
                        return true
                    }
                    return false
                }
                return true
            }
        }
        return false
    }
    
    func checkMail(strEmail : String) -> Bool{
        let arrEmail = strEmail.components(separatedBy: "@")
        if arrEmail.count > 1{
            let strHalfEmail : String = arrEmail[1]
            let arrDotEmail = strHalfEmail.components(separatedBy: ".")
            if arrDotEmail.count > 4{
                return false
            }
        }
        return true
    }

}
