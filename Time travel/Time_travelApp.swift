//
//  Time_travelApp.swift
//  Time travel
//
//  Created by Ilya on 14.04.2023.
//

import SwiftUI
import CoreData
@main
struct Time_travelApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }


}
