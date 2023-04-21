//
//  LandmarkEntity.swift
//  Time travel
//
//  Created by Ilya on 17.04.2023.
//


import Foundation
import CoreData
import CoreLocation

extension LandmarkEntity {
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
    }
    
    static func create(name: String, latitude: Double, longitude: Double, landmarkDescription: String, in context: NSManagedObjectContext) -> LandmarkEntity {
        let landmark = LandmarkEntity(context: context)
        landmark.name = name
        landmark.latitude = latitude
        landmark.longitude = longitude
        landmark.landmarkDescription = landmarkDescription
        return landmark
    }
}
