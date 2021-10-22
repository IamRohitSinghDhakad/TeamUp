//
//  FilterVC.swift
//  TeamUp
//
//  Created by Apple on 05/09/21.
//

import UIKit
import MapKit
import CoreLocation


protocol MyFilterDelegate {
    func filterData(strLat:String,strLong:String,strRating:String,strSortBy:String)
}

class FilterVC: UIViewController,CLLocationManagerDelegate {

    @IBOutlet weak var btnNearByMe: UIButton!
    @IBOutlet weak var btnPriceHighToLow: UIButton!
    @IBOutlet weak var btnPriceLowtoHigh: UIButton!
    
    var delegate:MyFilterDelegate?
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var btnStar5: UIButton!
    @IBOutlet weak var brnStar4: UIButton!
    @IBOutlet weak var btnStar2: UIButton!
    @IBOutlet weak var btnStaR1: UIButton!
    @IBOutlet weak var btnStar3: UIButton!
    
    
    var strLat = String()
    var strLong = String()
    var strRating = String()
    var strSortBy = String()
    var isNearBy = Bool()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Filter"
        // Do any additional setup after loading the view.
        self.btnNearByMe.setImage(UIImage(named: "box"), for: .normal)
        self.btnPriceHighToLow.setImage(UIImage(named: "box"), for: .normal)
        self.btnPriceLowtoHigh.setImage(UIImage(named: "box"), for: .normal)
        
        self.locationManager.requestAlwaysAuthorization()
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        self.isNearBy = true
        self.btnNearByMe.setImage(UIImage(named: "check"), for: .normal)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        self.strLat = "\(locValue.latitude)"
        self.strLong = "\(locValue.longitude)"
    }
    
    @IBAction func btnPriceLowtoHigh(_ sender: Any) {
        if btnPriceLowtoHigh.currentImage == UIImage(named: "box") {
            self.strSortBy = "low to high"
            self.btnPriceLowtoHigh.setImage(UIImage(named: "check"), for: .normal)
            self.btnPriceHighToLow.setImage(UIImage(named: "box"), for: .normal)
        }else if btnPriceLowtoHigh.currentImage == UIImage(named: "check"){
            self.strSortBy = ""
            self.btnPriceLowtoHigh.setImage(UIImage(named: "box"), for: .normal)
        }
    }
    
    @IBAction func btnPriceHighToLow(_ sender: Any) {
        if btnPriceHighToLow.currentImage == UIImage(named: "box") {
            self.strSortBy = "high to low"
            self.btnPriceHighToLow.setImage(UIImage(named: "check"), for: .normal)
            self.btnPriceLowtoHigh.setImage(UIImage(named: "box"), for: .normal)
        }else if btnPriceHighToLow.currentImage == UIImage(named: "check"){
            self.strSortBy = ""
            self.btnPriceHighToLow.setImage(UIImage(named: "box"), for: .normal)
        }
    }
    
    
    @IBAction func btnNearBy(_ sender: Any) {
        if btnNearByMe.currentImage == UIImage(named: "box") {
            self.btnNearByMe.setImage(UIImage(named: "check"), for: .normal)
            self.isNearBy = true
        }else if btnNearByMe.currentImage == UIImage(named: "check"){
            self.isNearBy = false
            self.btnNearByMe.setImage(UIImage(named: "box"), for: .normal)
        }
    }
    
    @IBAction func btnApply(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        if (isNearBy) {
        self.delegate?.filterData(strLat: strLat, strLong: strLong, strRating: strRating, strSortBy: strSortBy)
        }else{
        self.delegate?.filterData(strLat: "", strLong: "", strRating: strRating, strSortBy: strSortBy)
        }
    }
    
    
    
    @IBAction func btnTagStar(_ sender: Any) {
        if (sender as AnyObject).tag == 1 {
            self.btnStaR1.setImage(UIImage(named: "check"), for: .normal)
            self.btnStar2.setImage(UIImage(named: "box"), for: .normal)
            self.btnStar3.setImage(UIImage(named: "box"), for: .normal)
            self.brnStar4.setImage(UIImage(named: "box"), for: .normal)
            self.btnStar5.setImage(UIImage(named: "box"), for: .normal)
            self.strRating = "1"
        }else if (sender as AnyObject).tag == 2 {
            self.btnStaR1.setImage(UIImage(named: "check"), for: .normal)
            self.btnStar2.setImage(UIImage(named: "check"), for: .normal)
            self.btnStar3.setImage(UIImage(named: "box"), for: .normal)
            self.brnStar4.setImage(UIImage(named: "box"), for: .normal)
            self.btnStar5.setImage(UIImage(named: "box"), for: .normal)
            self.strRating = "2"
        }else if (sender as AnyObject).tag == 3 {
            self.btnStaR1.setImage(UIImage(named: "check"), for: .normal)
            self.btnStar2.setImage(UIImage(named: "check"), for: .normal)
            self.btnStar3.setImage(UIImage(named: "check"), for: .normal)
            self.brnStar4.setImage(UIImage(named: "box"), for: .normal)
            self.btnStar5.setImage(UIImage(named: "box"), for: .normal)
            self.strRating = "3"
        }else if (sender as AnyObject).tag == 4 {
            self.btnStaR1.setImage(UIImage(named: "check"), for: .normal)
            self.btnStar2.setImage(UIImage(named: "check"), for: .normal)
            self.btnStar3.setImage(UIImage(named: "check"), for: .normal)
            self.brnStar4.setImage(UIImage(named: "check"), for: .normal)
            self.btnStar5.setImage(UIImage(named: "box"), for: .normal)
            self.strRating = "4"
        }else if (sender as AnyObject).tag == 5 {
            self.btnStaR1.setImage(UIImage(named: "check"), for: .normal)
            self.btnStar2.setImage(UIImage(named: "check"), for: .normal)
            self.btnStar3.setImage(UIImage(named: "check"), for: .normal)
            self.brnStar4.setImage(UIImage(named: "check"), for: .normal)
            self.btnStar5.setImage(UIImage(named: "check"), for: .normal)
            self.strRating = "5"
        }
        
    }
    
    
    
}
