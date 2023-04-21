//
//  EventEntity+CustomProperties.swift
//  Time travel
//
//  Created by Ilya on 14.04.2023.
//

import Foundation
import CoreData
import CoreLocation

extension EventEntity {
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
    }
}
