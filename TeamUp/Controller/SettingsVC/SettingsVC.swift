//
//  SettingsVC.swift
//  TeamUp
//
//  Created by Apple on 03/09/21.
//

import UIKit

class SettingsVC: BaseViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tblSettings: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.title = "Settings"
        self.navigationItem.setHidesBackButton(true, animated: true)
        
    }
    
    func rightNavButton(){

        let frameSize = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: 50, height: 30))
        let customSwitch = UISwitch(frame: frameSize)

        if AppSharedData.sharedObject().strToggleStatus == true{
            customSwitch.isOn = true
            customSwitch.setOn(true, animated: true)
        }else{
            customSwitch.isOn = false
            customSwitch.setOn(false, animated: true)
        }
       
        customSwitch.onTintColor = UIColor.lightGray
       

        customSwitch.addTarget(self, action: #selector(FindMeVC.switchTarget(sender:)), for: .valueChanged)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: customSwitch)
    }


    @objc func switchTarget(sender: UISwitch!)
    {
        if sender.isOn {
            AppSharedData.sharedObject().call_UpDateToggleStatus(strStatus: "1")
        } else{
            AppSharedData.sharedObject().call_UpDateToggleStatus(strStatus: "0")
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       // self.rightNavButton()
        let dict = AppSharedData.getUserInfo()
        let userInfo = dict["type"]as? String ?? ""
        if userInfo != "user"{
            self.rightNavButton()
        }else{
            
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell") as! SettingsCell
        if indexPath.row == 0 {
            cell.lblTitle.text! = "Contact Us"
        }else if indexPath.row == 1 {
            cell.lblTitle.text! = "Language"
        }else if indexPath.row == 2 {
            cell.lblTitle.text! = "Terms & Condition"
        }else if indexPath.row == 3 {
            cell.lblTitle.text! = "About the App"
        }else if indexPath.row == 4 {
            cell.lblTitle.text! = "Change password"
        }else if indexPath.row == 5 {
            cell.lblTitle.text! = "LogOut"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let vc = storyboard?.instantiateViewController(identifier: "ContactUsVc") as! ContactUsVc
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 2 {
            let vc = storyboard?.instantiateViewController(identifier: "WebkitVC") as! WebkitVC
            vc.strTitle = "Terms & Conditions"
            vc.intType = 2
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 3 {
            let vc = storyboard?.instantiateViewController(identifier: "WebkitVC") as! WebkitVC
            vc.strTitle = "About Us"
            vc.intType = 3
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 4 {
        let vc = storyboard?.instantiateViewController(identifier: "ChangePasswordVc") as! ChangePasswordVc
        self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 5 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "WelcomeVC") as! WelcomeVC
            self.navigationController?.pushViewController(vc, animated: true)
            AppSharedData.setUserInfo(dictInfo: nil)
        }
    }
    

   

}

class SettingsCell:UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
}
