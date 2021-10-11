//
//  LocationVC.swift
//  TeamUp
//
//  Created by Apple on 04/09/21.
//

import UIKit
import MapKit
import CoreLocation

class LocationVC: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate {

    @IBOutlet weak var vwSearch: UIView!
    @IBOutlet weak var mapKit: MKMapView!
    let locationManager = CLLocationManager()
    var arrAnnotation = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.vwSearch.layer.cornerRadius = self.vwSearch.frame.height/2
        self.vwSearch.layer.borderColor = UIColor.black.cgColor
        self.vwSearch.layer.borderWidth = 1
        self.title = "Location"
        self.setLocation()
        
        
        
        
        var annotations = [MKAnnotation]()

        for i in 0..<arrAnnotation.count {
            let dict = arrAnnotation[i] as! NSDictionary
            let annotation = MKPointAnnotation()
            let long = dict.GetString(forKey: "lng")
            let lat = dict.GetString(forKey: "lat")
            
            let doubleLat = Double(lat)
            let doubleLong = Double(long)
            
            annotation.coordinate = CLLocationCoordinate2D(latitude: doubleLat ?? 0.00, longitude: doubleLong ?? 0.00)

            annotations.append(annotation)

        }
        
        
        mapKit.addAnnotations(annotations)
        
    }
    
    func setLocation() {
        self.locationManager.requestAlwaysAuthorization()

            // For use in foreground
            self.locationManager.requestWhenInUseAuthorization()

            if CLLocationManager.locationServicesEnabled() {
                locationManager.delegate = self
                locationManager.desiredAccuracy = kCLLocationAccuracyBest
                locationManager.startUpdatingLocation()
            }

            mapKit.delegate = self
        mapKit.mapType = .standard
        mapKit.isZoomEnabled = true
        mapKit.isScrollEnabled = true

            if let coor = mapKit.userLocation.location?.coordinate{
                mapKit.setCenter(coor, animated: true)
            }

    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations
        locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate

        mapKit.mapType = MKMapType.standard

        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: locValue, span: span)
        mapKit.setRegion(region, animated: true)

        let annotation = MKPointAnnotation()
        annotation.coordinate = locValue
        annotation.title = "You are Here"
        mapKit.addAnnotation(annotation)
    }

    
    
    
    @IBAction func btnViewInList(_ sender: Any) {
        
        
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
