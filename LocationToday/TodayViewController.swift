//
//  TodayViewController.swift
//  LocationToday
//
//  Created by Steffen on 19.06.14.
//  Copyright (c) 2014 Steffen. All rights reserved.
//

import UIKit
import NotificationCenter
import CoreLocation

class TodayViewController: UIViewController, CLLocationManagerDelegate {
//    
//    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
//        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//        // Custom initialization
//    }

    @IBOutlet var locationLabel: UILabel
    @IBOutlet var errorLabel: UILabel
    @IBOutlet var statusLabel: UILabel

    var locationManager : CLLocationManager!

    override func viewDidLoad() {
        super.viewDidLoad()

        locationLabel.text = ""
        errorLabel.text = ""
        statusLabel.text = ""

        if !locationManager {
            locationManager = CLLocationManager()
        }

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        locationManager.requestWhenInUseAuthorization()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        locationManager.startUpdatingLocation()
    }

    override func viewDidDisappear(animated: Bool)  {
        super.viewDidDisappear(animated)

        locationManager.stopUpdatingLocation()
    }

    func widgetMarginInsetsForProposedMarginInsets(defaultMarginInsets: UIEdgeInsets) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
        // Perform any setup necessary in order to update the view.

        // If an error is encoutered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData

        completionHandler(NCUpdateResult.NewData)
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

            statusLabel.text = statusString
    }

    func locationManager(manager: CLLocationManager!,
        didFailWithError error: NSError!) {
            errorLabel.text = error.localizedDescription
    }
    
}
