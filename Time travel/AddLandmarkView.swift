//
//  AddLandmarkView.swift
//  Time travel
//
//  Created by Ilya on 17.04.2023.
//


import SwiftUI
import MapKit
import CoreData
import CoreLocation
import SwiftUI
import MapKit

import SwiftUI
import MapKit

import SwiftUI
import MapKit

struct AddLandmarkView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) private var presentationMode

    @State private var name: String = ""
        @State private var location: CLLocationCoordinate2D?

        var onSave: ((LandmarkEntity) -> Void)?

    @State private var descriptionText = ""
    @State private var coordinate = CLLocationCoordinate2D()
    @State private var showingMapPicker = false

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Название")) {
                    TextField("Введите название", text: $name)
                }
                Section(header: Text("Описание")) {
                    TextEditor(text: $descriptionText)
                }
                Section(header: Text("Местоположение")) {
                    Button(action: {
                        self.showingMapPicker = true
                    }, label: {
                        Text("Выберите местоположение на карте")
                            .foregroundColor(.blue)
                    })
                    .sheet(isPresented: $showingMapPicker, content: {
                        MapPickerView(coordinate: $coordinate)
                    })
                    Text("Координаты: \(coordinate.latitude), \(coordinate.longitude)")
                }
                Section {
                    Button("Save") {
                               let newLandmark = LandmarkEntity(context: viewContext)
                              // newLandmark.id = UUID()
                               newLandmark.name = name
                               newLandmark.latitude = location?.latitude ?? 0
                               newLandmark.longitude = location?.longitude ?? 0

                               onSave?(newLandmark)
                               presentationMode.wrappedValue.dismiss()
                           }
                }
            }
            .navigationBarTitle("Добавить достопримечательность", displayMode: .inline)
        }
    }
}
