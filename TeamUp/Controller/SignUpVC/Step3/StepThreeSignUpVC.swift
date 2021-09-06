//
//  StepThreeSignUpVC.swift
//  TeamUp
//
//  Created by Rohit Singh Dhakad on 07/09/21.
//

import UIKit

class StepThreeSignUpVC: UIViewController {

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
    
    @IBAction func btnNext(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "StepFourSignUpVC") as! StepFourSignUpVC
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
