//
//  FindMeVC.swift
//  TeamUp
//
//  Created by Apple on 04/09/21.
//

import UIKit

class FindMeVC: UIViewController {

    @IBOutlet weak var btnCategory: UIButton!
    @IBOutlet weak var btnSports: UIButton!
    @IBOutlet weak var btnLocation: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = "Find My"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnSelectCategory(_ sender: Any) {
        
    }
    
    @IBAction func btnLocation(_ sender: Any) {
        
    }
    
    
    @IBAction func btnSports(_ sender: Any) {
    }
    
    
    @IBAction func btnFindMe(_ sender: Any) {
    let vc = storyboard?.instantiateViewController(identifier: "SearchResultVC") as! SearchResultVC
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
