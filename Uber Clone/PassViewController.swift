//
//  PassViewController.swift
//  Uber Clone
//
//  Created by Teacher on 2019/6/6.
//  Copyright © 2019年 Teacher. All rights reserved.
//

import UIKit
import FirebaseAuth
import MapKit
import CoreLocation

class PassViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    
    var userLocation = CLLocationCoordinate2D()
    
    var uberBeenCalled = false
    
    
    @IBAction func logOut(_ sender: UIBarButtonItem) {
        
        do {
            
            try Auth.auth().signOut()
            navigationController?.dismiss(animated: true, completion: nil)
            
        } catch {
            
            print("User Sign out Failed!")
        }
        
        
        
    }
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    @IBAction func callUber(_ sender: UIButton) {
        
        if uberBeenCalled {
            
            //cancelUber()
            
        } else {
            
            //callUber()
        }
        
        
        
        
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        mapView.delegate = self
        locationManager.delegate = self
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.notDetermined {
            
            locationManager.requestAlwaysAuthorization()
        }
        
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let coordinate : CLLocationCoordinate2D = manager.location?.coordinate{
            
            userLocation = coordinate
            
            let region = MKCoordinateRegion(center: userLocation, latitudinalMeters: 0.0018, longitudinalMeters: 0.0018)
            
            mapView.setRegion(region, animated: true)
            
            
            mapView.removeAnnotations(mapView.annotations)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = userLocation
            annotation.title = "Your Location"
            mapView.addAnnotation(annotation)
        }
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
