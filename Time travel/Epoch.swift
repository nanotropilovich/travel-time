//
//  Epoch.swift
//  Time travel
//
//  Created by Ilya on 14.04.2023.
//

import Foundation
import CoreLocation
struct Epoch: Identifiable {
let id = UUID()
let name: String
let events: [Event]
}
struct Event: Identifiable {
let id = UUID()
let name: String
let description: String
let coordinate: CLLocationCoordinate2D
}

