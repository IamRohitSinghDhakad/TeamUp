//
//  BookAppointMentVC.swift
//  TeamUp
//
//  Created by Apple on 05/09/21.
//

import UIKit

class BookAppointMentVC: UIViewController {
    
    
    @IBOutlet weak var btnSelectTime: UIButton!
    
    @IBOutlet weak var tvDescription: UITextView!
    
    @IBOutlet weak var btnSelectDate: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    @IBAction func btnSelectDate(_ sender: Any) {
    }
    
    @IBAction func btnSelectTime(_ sender: Any) {
    }
    
    @IBAction func btnBook(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnCross(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
