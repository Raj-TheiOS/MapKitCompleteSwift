//
//  ArtworkViews.swift
//  MapKitCompleteSwift
//
//  Created by Raj on 22/06/17.
//  Copyright © 2017 Raj. All rights reserved.
//

import Foundation
import MapKit

class ArtworkMarkerView: MKMarkerAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            
            // These lines do the same thing as your mapView(_:viewFor:), configuring the callout.
            guard let artwork = newValue as? Artwork else { return }
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            // Then you set the marker’s tint color, and also replace its pin icon (glyph) with the first letter of the annotation’s discipline.
            markerTintColor = artwork.markerTintColor
            // glyphText = String(artwork.discipline.first!)
            if let imageName = artwork.imageName {
                glyphImage = UIImage(named: imageName)
            } else {
                glyphImage = nil
            }
            
        }
    }
}

class ArtworkView: MKAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            guard let artwork = newValue as? Artwork else {return}
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            // the above code replaced by the below one & imagew to the annotation end
            let mapsButton = UIButton(frame: CGRect(origin: CGPoint.zero,
                                                    size: CGSize(width: 30, height: 30)))
            mapsButton.setBackgroundImage(UIImage(named: "Maps-icon"), for: UIControlState())
            rightCalloutAccessoryView = mapsButton
            
            // imagew to the annotation end
            if let imageName = artwork.imageName {
                image = UIImage(named: imageName)
            } else {
                image = nil
            }
            
            // to show multiple line for the title and subtitle
            let detailLabel = UILabel()
            detailLabel.numberOfLines = 0
            detailLabel.font = detailLabel.font.withSize(12)
            detailLabel.text = artwork.subtitle
            detailCalloutAccessoryView = detailLabel
            // ends here
        }
    }
}



















