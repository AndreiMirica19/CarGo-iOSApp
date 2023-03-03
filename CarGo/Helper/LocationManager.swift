//
//  LocationManager.swift
//  CarGo
//
//  Created by Andrei Mirica on 02.03.2023.
//

import UIKit
import MapKit
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    private let manager = CLLocationManager()
    @Published var region: MKCoordinateRegion
    @Published var updateRegionError: Error?
    var places: [IdentifiablePlace] = []
    
    override init() {
        region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 45.0, longitude: 25.0),
            span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        )
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locations.last.map {
            region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: $0.coordinate.latitude, longitude: $0.coordinate.longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
            )
        }
    }
    
    func updateLocation(address: String) {
        manager.stopUpdatingLocation()
        let geoCoder = CLGeocoder()
        
        geoCoder.geocodeAddressString(address) { (placemarks, error) in
            guard
                let placemarks = placemarks,
                let location = placemarks.first?.location
            else {
                self.updateRegionError = error
                return
            }
            
            let coordinateRegion = MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                    latitude: location.coordinate.latitude,
                    longitude: location.coordinate.longitude
                ),
                span: MKCoordinateSpan(
                    latitudeDelta: 0.01,
                    longitudeDelta: 0.01
                )
            )
            
            self.places = [IdentifiablePlace(lat: location.coordinate.latitude, long: location.coordinate.longitude)]
            self.region = coordinateRegion
        }
    }
}
