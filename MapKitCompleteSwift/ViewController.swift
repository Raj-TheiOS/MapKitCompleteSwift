//
//  ViewController.swift
//  MapKitCompleteSwift
//
//  Created by Raj on 22/06/17.
//  Copyright © 2017 Raj. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    var artworks: [Artwork] = []
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
        centerMapOnLocation(location: initialLocation)
        mapView.delegate = self
        mapView.register(ArtworkView.self,
                         forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        loadInitialData()
        mapView.addAnnotations(artworks)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkLocationAuthorizationStatus()
    }
    
    // MARK: - CLLocationManager
    let locationManager = CLLocationManager()
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedAlways {
            mapView.showsUserLocation = true
        } else {
            locationManager.requestAlwaysAuthorization()
        }
    }
    let regionRadius: CLLocationDistance = 1500
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }

    func loadInitialData() {
        guard let fileName = Bundle.main.path(forResource: "PublicArt", ofType: "json")
            else { return }
        let optionalData = try? Data(contentsOf: URL(fileURLWithPath: fileName))
        guard
            let data = optionalData,
            // You use JSONSerialization to obtain a JSON object.
            let json = try? JSONSerialization.jsonObject(with: data),
            // You check that the JSON object is a dictionary with String keys and Any values.
            let dictionary = json as? [String: Any],
            // You’re only interested in the JSON object whose key is "data".
            let works = dictionary["data"] as? [[Any]]
            else { return }
        // You flatmap this array of arrays, using the failable initializer that you just added to the Artwork class, and append the resulting validWorks to the artworks array.
        let validWorks = works.flatMap { Artwork(json: $0) }
        artworks.append(contentsOf: validWorks)
    }
}

// MARK: - MKMapViewDelegate
extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        let location = view.annotation as! Artwork
        let launchOptions = [MKLaunchOptionsDirectionsModeKey:
            MKLaunchOptionsDirectionsModeDriving]
        location.mapItem().openInMaps(launchOptions: launchOptions)
    }
    
}


