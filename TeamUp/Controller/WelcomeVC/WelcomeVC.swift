//
//  ViewController.swift
//  TeamUp
//
//  Created by Apple on 03/09/21.
//

import UIKit

class WelcomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func btnNext(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "LoginVC") as! LoginVC
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

