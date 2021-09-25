
//
//  Artwork.swift
//  MapKitCompleteSwift
//
//  Created by Raj on 22/06/17.
//  Copyright © 2017 Raj. All rights reserved.
//

import Foundation
import Contacts
import MapKit

class Artwork: NSObject, MKAnnotation {
    let title: String?
    let locationName: String
    let discipline: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate
        
        super.init()
    }
    // Annotation right callout accessory opens this mapItem in Maps app
    func mapItem() -> MKMapItem {
        let addressDict = [CNPostalAddressStreetKey: subtitle!]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        return mapItem
    }
    
    init?(json: [Any]) {
        // The json argument is one of the arrays that represent an artwork – an array of Any objects. If you count through an array’s elements, you’ll see that the title, locationName etc. are at the indexes specified in this method. The title field for some of the artworks is null, so you provide a default value for the title value.
        
        self.title = json[16] as? String ?? "No Title"
       // self.locationName = json[12] as! String
        self.locationName = json[11] as! String
        self.discipline = json[15] as! String
        
        // The latitude and longitude values in the json array are strings: if you can create Double objects from them, you create a CLLocationCoordinate2D.
        
        if let latitude = Double(json[18] as! String),
            let longitude = Double(json[19] as! String) {
            self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        } else {
            self.coordinate = CLLocationCoordinate2D()
        }
    }
    
    var subtitle: String? {
        return locationName
    }
    // markerTintColor for disciplines: Sculpture, Plaque, Mural, Monument, other
    var markerTintColor: UIColor  {
        switch discipline {
        case "Monument":
            return .red
        case "Mural":
            return .cyan
        case "Plaque":
            return .blue
        case "Sculpture":
            return .purple
        default:
            return .green
        }
    }

    var imageName: String? {
        if discipline == "Sculpture" { return "Statue" }
        return "Flag"
    }
}

