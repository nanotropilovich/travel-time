//
//  EventDetailView.swift
//  Time travel
//
//  Created by Ilya on 14.04.2023.
//

import SwiftUI
import MapKit

struct EventDetailView: View {
    let event: EventViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(event.name)
                .font(.title)

            Text(event.description)
            Text("\((event.coordinate).latitude)")
            MapView(landmarks: .constant([Landmark(name: event.name, coordinate: event.coordinate)]))
                .frame(height: 300)
                .cornerRadius(10)
        }
        .padding()
        .navigationBarTitle("Событие", displayMode: .inline)
    }
}
