//
//  EpochViewModel.swift
//  Time travel
//
//  Created by Ilya on 14.04.2023.
//
import Foundation
import CoreData
import CoreLocation

struct EpochViewModel: Identifiable {
    let id: NSManagedObjectID
    let name: String
    lazy var events: [EventViewModel] = []

    init(epoch: EpochEntity, context: NSManagedObjectContext) {
        self.id = epoch.objectID
        self.name = epoch.name ?? ""

        let eventViewModels = self.createEventViewModels(from: epoch.events,  context: context)
        self.events = eventViewModels
    }

    func createEventViewModels(from events: NSSet?, context: NSManagedObjectContext) -> [EventViewModel] {
        return (events?.allObjects as? [EventEntity] ?? []).map { event in
            EventViewModel(event: event, context: context)
        }
    }
}

struct EventViewModel: Identifiable {
    let id: NSManagedObjectID
    let name: String
    let description: String
    let coordinate: CLLocationCoordinate2D

    init(event: EventEntity, context: NSManagedObjectContext) {
        self.id = event.objectID
        self.name = event.name ?? ""
        self.description = event.eventDescriptionAttribute ?? ""
        self.coordinate = CLLocationCoordinate2D(latitude: event.latitude, longitude: event.longitude)
    }
}
