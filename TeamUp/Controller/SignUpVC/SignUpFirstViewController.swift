//
//  SignUpFirstViewController.swift
//  TeamUp
//
//  Created by Rohit Singh on 17/09/21.
//

import UIKit

class SignUpFirstViewController: UIViewController {

   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func btnOnUser(_ sender: Any) {
        AppSharedData.sharedObject().isProvider = false
        AppSharedData.sharedObject().userType = "user"
        let vc = storyboard?.instantiateViewController(identifier: "StepTwoSignUpVC") as! StepTwoSignUpVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnOnProvider(_ sender: Any) {
        AppSharedData.sharedObject().isProvider = true
        AppSharedData.sharedObject().userType = "provider"
        let vc = storyboard?.instantiateViewController(identifier: "SignUPVC") as! SignUPVC
        self.navigationController?.pushViewController(vc, animated: true)
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
