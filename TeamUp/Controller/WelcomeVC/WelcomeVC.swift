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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    @IBAction func btnNext(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "LanguageViewController") as! LanguageViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

