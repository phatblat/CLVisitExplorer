//
//  ViewController.swift
//  CLVisitExplorer
//
//  Created by Ben Chatelain on 6/22/16.
//  Copyright © 2016 Ben Chatelain. All rights reserved.
//

import MapKit
import UIKit

// MARK: - Storage
class ViewController: UIViewController {
    @IBOutlet private var mapView: MKMapView!
    @IBOutlet private var locationButton: UIButton!
    @IBOutlet private var visitsButton: UIButton!

    /// Indicates whether location updates are currently being delivered.
    private var monitoringLocation: Bool { return LocationManager.shared.monitoringLocation }

    /// Indicates whether visits are currently being delivered.
    private var monitoringVisits: Bool { return LocationManager.shared.monitoringVisits }
}

// MARK: - IBAction
extension ViewController {
    @IBAction func didTapLocationButton(_ button: UIButton) {
        debugPrint("didTapLocationButton, monitoringLocation", monitoringLocation)
//        toggleLocationMonitoring()
//        updateTitle(button)
        PlaceManager().add(CLVisit())
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
private extension ViewController {
    /// Starts or stops location updates depending on the current monitoringLocation value.
    private func toggleLocationMonitoring() {
        !monitoringLocation
            ? LocationManager.shared.startLocationUpdates()
            : LocationManager.shared.stopLocationUpdates()
    }

    private func toggleVisitMonitoring() {
        !monitoringVisits
            ? LocationManager.shared.startVisitUpdates()
            : LocationManager.shared.stopVisitUpdates()
    }

    /// Updates the button title based on the state of the relevant service.
    ///
    /// - parameter button: Button to update.
    private func updateTitle(_ button: UIButton) {
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

    private func configureMapView() {
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
    }
}
