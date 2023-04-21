//
//  Landmark.swift
//  Time travel
//
//  Created by Ilya on 14.04.2023.
//


import MapKit
import SwiftUI
import CoreML
import CoreData
import CoreLocation
struct Landmark: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

class LandmarkAnnotation: NSObject, MKAnnotation {
    let title: String?
    let coordinate: CLLocationCoordinate2D

    init(landmark: Landmark) {
        self.title = landmark.name
        self.coordinate = landmark.coordinate
    }
}
