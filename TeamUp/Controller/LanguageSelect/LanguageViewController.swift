//
//  LanguageViewController.swift
//  TeamUp
//
//  Created by Rohit Singh Dhakad on 26/10/21.
//

import UIKit

class LanguageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


    
    @IBAction func btnActionLanguageSelect(_ sender: UIButton) {
        
        switch sender.tag {
        case 100:
            print("English")
        case 101:
            print("Spanish")
        default:
            print("French")
        }
        
        let vc = storyboard?.instantiateViewController(identifier: "LoginVC") as! LoginVC
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
