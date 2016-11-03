//
//  ViewController.swift
//  CLVisitExplorer
//
//  Created by Ben Chatelain on 6/22/16.
//  Copyright © 2016 Ben Chatelain. All rights reserved.
//

import MapKit
import RealmMapView
import UIKit

// MARK: - Storage
class ViewController: UIViewController {
    @IBOutlet fileprivate var mapView: MKMapView!
    @IBOutlet fileprivate var locationButton: UIButton!
    @IBOutlet fileprivate var visitsButton: UIButton!

    /// Indicates whether location updates are currently being delivered.
    fileprivate var monitoringLocation: Bool { return LocationManager.shared.monitoringLocation }

    /// Indicates whether visits are currently being delivered.
    fileprivate var monitoringVisits: Bool { return LocationManager.shared.monitoringVisits }
}

// MARK: - IBAction
extension ViewController {
    @IBAction func didTapLocationButton(_ button: UIButton) {
        debugPrint("didTapLocationButton, monitoringLocation", monitoringLocation)
//        toggleLocationMonitoring()
//        updateTitle(button)
//        PlaceManager().add(CLVisit())
    }

    @IBAction func didTapVisitsButton(_ button: UIButton) {
        debugPrint("didTapVisitsButton, monitoringVisits", monitoringVisits)
        toggleVisitMonitoring()
        updateTitle(button)
    }
}

// MARK: - UIViewController
extension ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        [locationButton, visitsButton].forEach { button in updateTitle(button) }
        configureMapView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        LocationManager.shared.requestPermission()
    }
}

// MARK: - MKMapViewDelegate
extension ViewController: MKMapViewDelegate {
    func mapViewWillStartLoadingMap(_ mapView: MKMapView) { debugPrint("mapViewWillStartLoadingMap") }

    func mapViewWillStartRenderingMap(_ mapView: MKMapView) { debugPrint("mapViewWillStartRenderingMap") }

    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) { debugPrint("mapViewDidFinishLoadingMap") }

    func mapViewWillStartLocatingUser(_ mapView: MKMapView) { debugPrint("mapViewWillStartLocatingUser") }

    func mapViewDidStopLocatingUser(_ mapView: MKMapView) { debugPrint("mapViewDidStopLocatingUser") }
}

// MARK: - Private
fileprivate extension ViewController {
    /// Starts or stops location updates depending on the current monitoringLocation value.
    fileprivate func toggleLocationMonitoring() {
        !monitoringLocation
            ? LocationManager.shared.startLocationUpdates()
            : LocationManager.shared.stopLocationUpdates()
    }

    fileprivate func toggleVisitMonitoring() {
        !monitoringVisits
            ? LocationManager.shared.startVisitUpdates()
            : LocationManager.shared.stopVisitUpdates()
    }

    /// Updates the button title based on the state of the relevant service.
    ///
    /// - parameter button: Button to update.
    fileprivate func updateTitle(_ button: UIButton) {
        var title: String

        switch button {
        case locationButton:
            title = monitoringLocation
                ? "Stop Monitoring Location"
                : "Start Monitoring Location"
        case visitsButton:
            title = monitoringVisits
                ? "Stop Monitoring Visits"
                : "Start Monitoring Visits"
        default:
            fatalError("Unknown button: \(button)")
        }

        button.setTitle(title, for: [])
    }

    fileprivate func configureMapView() {
        mapView.showsUserLocation = true
//        mapView.userTrackingMode = .follow

        if let realmMapView = mapView as? RealmMapView {
            realmMapView.autoRefresh = false
        }
    }
}
