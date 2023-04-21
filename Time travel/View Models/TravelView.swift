//
//  TravelView.swift
//  Time travel
//
//  Created by Ilya on 14.04.2023.
//

import Foundation
import SwiftUI
import MapKit


import SwiftUI
import MapKit
import SwiftUI
import MapKit

struct TravelView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: EpochEntity.entity(), sortDescriptors: []) private var epochs: FetchedResults<EpochEntity>
    @State private var landmarks: [Landmark] = []
    @State private var isAddLandmarkViewPresented: Bool = false
    //@State private var isAllLandmarksViewActive: Bool = false

    var body: some View {
        NavigationView {
            List {
                ForEach(epochs) { epoch in
                    Section(header: Text(epoch.name ?? "no name")) {
                        if let events = epoch.events {
                            let eventsArray = events.allObjects as? [EventEntity] ?? []
                            ForEach(eventsArray, id: \.self) { event in
                                NavigationLink(destination: EventDetailView(event: EventViewModel(event: event, context: viewContext))) {
                                    Text(event.name ?? "")
                                }
                            }
                            .onDelete(perform: { indexSet in
                                deleteLandmarks(at: indexSet, from: eventsArray)
                            })
                        }
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("Путешествие", displayMode: .inline)
            .navigationBarItems(leading:
                HStack {
                    Button(action: deleteAllEpochs) {
                        Text("Очистить")
                    }
                   
                }
                                /*,
                trailing: Button(action: { isAddLandmarkViewPresented = true }) {
                    Image(systemName: "plus")
                }
                                 */
            )
           
            .onAppear {
                loadLandmarks()
            }
        }
    }
        
    

    private func loadLandmarks() {
        // Здесь загружаем местоположения и обновляем @State private var landmarks
    }

     func deleteLandmarks(at offsets: IndexSet, from eventsArray: [EventEntity]) {
        for index in offsets {
            let event = eventsArray[index]
            viewContext.delete(event)
        }

        do {
            try viewContext.save()
        } catch {
            print("Error deleting landmarks: \(error.localizedDescription)")
        }

        loadLandmarks()
    }

    private func deleteAllEpochs() {
        for epoch in epochs {
            viewContext.delete(epoch)
        }

        do {
            try viewContext.save()
        } catch {
            print("Error deleting all epochs: \(error.localizedDescription)")
        }
    }
}



struct MapView: UIViewRepresentable {
    @Binding var landmarks: [Landmark]

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        return mapView
    }

    func updateUIView(_ view: MKMapView, context: Context) {
        updateAnnotations(from: view)
        if let firstLandmark = landmarks.first {
            centerMapOnLocation(view: view, coordinate: firstLandmark.coordinate)
        }
    }

    private func updateAnnotations(from mapView: MKMapView) {
        mapView.removeAnnotations(mapView.annotations)
        let annotations = landmarks.map(LandmarkAnnotation.init)
        mapView.addAnnotations(annotations)
    }

    private func centerMapOnLocation(view: MKMapView, coordinate: CLLocationCoordinate2D) {
        let regionRadius: CLLocationDistance = 1000
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        view.setRegion(region, animated: true)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView

        init(_ parent: MapView) {
            self.parent = parent
        }
    }
}
