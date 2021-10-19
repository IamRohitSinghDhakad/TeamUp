//
//  FilterVC.swift
//  TeamUp
//
//  Created by Apple on 05/09/21.
//

import UIKit

class FilterVC: UIViewController {

    @IBOutlet weak var btnNearByMe: UIButton!
    
    @IBOutlet weak var btnPriceHighToLow: UIButton!
    
    @IBOutlet weak var btnPriceLowtoHigh: UIButton!
    
    @IBOutlet weak var btnStar5: UIButton!
    @IBOutlet weak var brnStar4: UIButton!
    @IBOutlet weak var btnStar2: UIButton!
    @IBOutlet weak var btnStaR1: UIButton!
    @IBOutlet weak var btnStar3: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Filter"
        // Do any additional setup after loading the view.
        
        self.btnNearByMe.setImage(UIImage(named: "box"), for: .normal)
        self.btnPriceHighToLow.setImage(UIImage(named: "box"), for: .normal)
        self.btnPriceLowtoHigh.setImage(UIImage(named: "box"), for: .normal)
    }
    
    @IBAction func btnPriceLowtoHigh(_ sender: Any) {
        if btnPriceLowtoHigh.currentImage == UIImage(named: "box") {
            self.btnPriceLowtoHigh.setImage(UIImage(named: "check"), for: .normal)
            self.btnPriceHighToLow.setImage(UIImage(named: "box"), for: .normal)
        }else if btnPriceLowtoHigh.currentImage == UIImage(named: "check"){
            self.btnPriceLowtoHigh.setImage(UIImage(named: "box"), for: .normal)
        }
    }
    
    @IBAction func btnPriceHighToLow(_ sender: Any) {
        if btnPriceHighToLow.currentImage == UIImage(named: "box") {
            self.btnPriceHighToLow.setImage(UIImage(named: "check"), for: .normal)
            self.btnPriceLowtoHigh.setImage(UIImage(named: "box"), for: .normal)
        }else if btnPriceHighToLow.currentImage == UIImage(named: "check"){
            self.btnPriceHighToLow.setImage(UIImage(named: "box"), for: .normal)
        }
    }
    
    
    @IBAction func btnNearBy(_ sender: Any) {
        if btnNearByMe.currentImage == UIImage(named: "box") {
            self.btnNearByMe.setImage(UIImage(named: "check"), for: .normal)
        }else if btnNearByMe.currentImage == UIImage(named: "check"){
            self.btnNearByMe.setImage(UIImage(named: "box"), for: .normal)
        }
    }
    
    @IBAction func btnApply(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    @IBAction func btnTagStar(_ sender: Any) {
        if (sender as AnyObject).tag == 1 {
            self.btnStaR1.setImage(UIImage(named: "check"), for: .normal)
            self.btnStar2.setImage(UIImage(named: "box"), for: .normal)
            self.btnStar3.setImage(UIImage(named: "box"), for: .normal)
            self.brnStar4.setImage(UIImage(named: "box"), for: .normal)
            self.btnStar5.setImage(UIImage(named: "box"), for: .normal)
        }else if (sender as AnyObject).tag == 2 {
            self.btnStaR1.setImage(UIImage(named: "check"), for: .normal)
            self.btnStar2.setImage(UIImage(named: "check"), for: .normal)
            self.btnStar3.setImage(UIImage(named: "box"), for: .normal)
            self.brnStar4.setImage(UIImage(named: "box"), for: .normal)
            self.btnStar5.setImage(UIImage(named: "box"), for: .normal)
        }else if (sender as AnyObject).tag == 3 {
            self.btnStaR1.setImage(UIImage(named: "check"), for: .normal)
            self.btnStar2.setImage(UIImage(named: "check"), for: .normal)
            self.btnStar3.setImage(UIImage(named: "check"), for: .normal)
            self.brnStar4.setImage(UIImage(named: "box"), for: .normal)
            self.btnStar5.setImage(UIImage(named: "box"), for: .normal)
        }else if (sender as AnyObject).tag == 4 {
            self.btnStaR1.setImage(UIImage(named: "check"), for: .normal)
            self.btnStar2.setImage(UIImage(named: "check"), for: .normal)
            self.btnStar3.setImage(UIImage(named: "check"), for: .normal)
            self.brnStar4.setImage(UIImage(named: "check"), for: .normal)
            self.btnStar5.setImage(UIImage(named: "box"), for: .normal)
        }else if (sender as AnyObject).tag == 5 {
            self.btnStaR1.setImage(UIImage(named: "check"), for: .normal)
            self.btnStar2.setImage(UIImage(named: "check"), for: .normal)
            self.btnStar3.setImage(UIImage(named: "check"), for: .normal)
            self.brnStar4.setImage(UIImage(named: "check"), for: .normal)
            self.btnStar5.setImage(UIImage(named: "check"), for: .normal)
        }
        
    }
    
    
    
}
