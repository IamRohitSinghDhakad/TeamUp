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
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
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
            cell.lblTitle.text! = "LogOut"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 4 {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

class SettingsCell:UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
}
