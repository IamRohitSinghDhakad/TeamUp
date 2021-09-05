//
//  SignUPVC.swift
//  TeamUp
//
//  Created by Apple on 03/09/21.
//

import UIKit

class SignUPVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func btnSignUp(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "GuardinInfoVC") as! GuardinInfoVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnLogIn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
