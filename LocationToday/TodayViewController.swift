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

class TodayViewController: UIViewController {

    @IBOutlet var locationLabel: UILabel
    @IBOutlet var errorLabel: UILabel
    @IBOutlet var statusLabel: UILabel

    var locationManager : CLLocationManager!
    var updateResult : NCUpdateResult!

    override func awakeFromNib()  {
        super.awakeFromNib()

        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        locationManager.requestWhenInUseAuthorization()

        updateResult = NCUpdateResult.NoData
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        locationLabel.text = ""
        errorLabel.text = ""
        statusLabel.text = ""
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        locationManager.startUpdatingLocation()
    }

    override func viewDidDisappear(animated: Bool)  {
        super.viewDidDisappear(animated)

        locationManager.stopUpdatingLocation()
    }
}

extension TodayViewController : NCWidgetProviding {

    func widgetMarginInsetsForProposedMarginInsets(defaultMarginInsets: UIEdgeInsets) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
        completionHandler(updateResult)
        updateResult = NCUpdateResult.NoData
    }

}

extension TodayViewController : CLLocationManagerDelegate {

    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        let location = locations[0] as CLLocation
        locationLabel.text = "\(location.coordinate.latitude) : \(location.coordinate.longitude)"
        updateResult = NCUpdateResult.NewData
    }

    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {

        var statusString : String!
        switch status {
            case .NotDetermined : statusString = "NotDetermined"
            case .Restricted : statusString = "Restricted"
            case .Denied : statusString = "Denied"
            case .Authorized : statusString = "Authorized"
            case .AuthorizedWhenInUse : statusString = "AuthorizedWhenInUse"
        }

        statusLabel.text = statusString
        updateResult = NCUpdateResult.NewData
    }

    func locationManager(manager: CLLocationManager!,
        didFailWithError error: NSError!) {
            errorLabel.text = error.localizedDescription
            updateResult = NCUpdateResult.Failed
    }

}
