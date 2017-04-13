//
//  DetailsVC.swift
//  nearStores
//
//  Created by Eric Sans Alvarez on 09/04/2017.
//  Copyright © 2017 Eric Sans Alvarez. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class DetailsVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var storeName: UILabel!
    @IBOutlet weak var storeMap: MKMapView!
    @IBOutlet weak var storeAddress: UILabel!
    @IBOutlet weak var storeCity: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var storeWeb: UILabel!
    
    var store: Tienda?
    var storeNotFound: StoreNotFound?
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (self.store != nil) {
            
            storeMap.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            
            loadStoreDetails()
        }
        else {
            removeStoreViews()
            displayNoStoreMessage()
            
        }
    }
    
    //if there is a store, set up the values
    func loadStoreDetails() {
        if let store = self.store {
            storeName.text = store.storeName
            setStoreLocation(distance: store.distance, latitude: store.latitude, longitude: store.longitude, name: store.storeName, address: store.storeAddress)
            storeAddress.text = store.storeAddress
            storeCity.text = "\(store.storeCity), \(store.storeZipCode)"
            phoneNumber.text = store.phoneNumber
            storeWeb.text = store.webURL
        }
    }
    
    //Set location of the store and create a pin on the map
    func setStoreLocation(distance: Double, latitude: Double, longitude: Double, name: String, address: String) {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        self.storeMap.setRegion(coordinateRegion, animated: true)
        
        let storePin = MKPointAnnotation()
        storePin.coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        storePin.title = name
        storePin.subtitle = address
        
        self.storeMap.addAnnotation(storePin)
        
    }
    
    //remove views if there is no store available
    func removeStoreViews() {
        storeName.removeFromSuperview()
        storeMap.removeFromSuperview()
        storeAddress.removeFromSuperview()
        storeCity.removeFromSuperview()
        phoneNumber.removeFromSuperview()
        storeWeb.removeFromSuperview()
    }
    
    //no store was found
    func displayNoStoreMessage() {
        
        self.storeNotFound = StoreNotFound()
        
        storeNotFound!.configureStoreNotFoundView(view: self.view)
        
        self.view.addSubview(storeNotFound!.imageView)
        self.view.addSubview(storeNotFound!.info)
        
    }
    
    //remove from superview and nil delegates
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        self.storeMap.removeAnnotations(self.storeMap.annotations)
        self.storeMap.delegate = nil
        self.storeMap.removeFromSuperview()
        self.storeMap = nil
        self.locationManager.delegate = nil
        self.view.removeFromSuperview()
        
    }

    //dismiss controller
    @IBAction func cerrarPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

}
