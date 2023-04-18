//
//  ContentView.swift
//  Time travel
//
//  Created by Ilya on 14.04.2023.
//

import SwiftUI
import MapKit
import SwiftUI
import CoreML
import CoreData
import CoreLocation
struct ContentView: View {
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            TravelView()
                .tabItem {
                    Image(systemName: "clock.arrow.circlepath")
                    Text("Путешествие")
                }
                .tag(0)

            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Настройки")
                }
                .tag(1)
        }
        .onAppear {
            addSampleData(context: PersistenceController.shared.container.viewContext)
        }
    }

    private func addSampleData(context: NSManagedObjectContext) {
        let epochsCount = 3
        let eventsCount = 5

        for epochIndex in 1...epochsCount {
            let epoch = EpochEntity(context: context)
            epoch.name = "Epoch \(epochIndex)"

            for eventIndex in 1...eventsCount {
                let event = EventEntity(context: context)
                event.name = generateSampleEvent()
                event.latitude = Double.random(in: -90...90)
                event.longitude = Double.random(in: -180...180)

                epoch.addToEvents(event)
            }
        }

        do {
            try context.save()
        } catch {
            print("Error adding sample data: \(error)")
        }
    }

    private func generateSampleEvent() -> String {
        let prefixes = ["Ancient", "Medieval", "Modern", "Future"]
        let suffixes = ["Battle", "Discovery", "Invention", "Revolution"]
        return "\(prefixes.randomElement()!) \(suffixes.randomElement()!)"
    }
}

