//
//  ViewController.swift
//  LocationTest
//
//  Created by Steffen on 19.06.14.
//  Copyright (c) 2014 Steffen. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate{

    @IBOutlet var locationLabel: UILabel
    @IBOutlet var errorLabel: UILabel

    var locationManager : CLLocationManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        locationLabel.text = ""
        errorLabel.text = ""

        if !locationManager {
            locationManager = CLLocationManager()
        }

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        locationManager.startUpdatingLocation()
        locationManager.requestWhenInUseAuthorization()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: CLLocationManagerDelegate
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: AnyObject[]!) {
        let location = locations[0] as CLLocation
        locationLabel.text = "\(location.coordinate.latitude) : \(location.coordinate.longitude)"
    }

    func locationManager(manager: CLLocationManager!,
        didChangeAuthorizationStatus status: CLAuthorizationStatus) {

        var statusString : String!
        switch status {
            case .NotDetermined : statusString = "NotDetermined"
            case .Restricted : statusString = "Restricted"
            case .Denied : statusString = "Denied"
            case .Authorized : statusString = "Authorized"
            case .AuthorizedWhenInUse : statusString = "AuthorizedWhenInUse"
        }
        errorLabel.text = statusString
    }

    func locationManager(manager: CLLocationManager!,
        didFailWithError error: NSError!) {
        println("didFailWithError: " + error.localizedDescription)
//        errorLabel.text = error.localizedDescription
    }

    func locationManager(manager: CLLocationManager!,
        didFinishDeferredUpdatesWithError error: NSError!) {
        println("didFinishDeferredUpdatesWithError: " + error.localizedDescription)
    }

}

