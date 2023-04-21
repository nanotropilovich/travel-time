//
//  AddLandmarkView.swift
//  Time travel
//
//  Created by Ilya on 17.04.2023.
//





import SwiftUI
import MapKit

struct AddLandmarkView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) private var presentationMode

    @State private var name: String = ""
    @State private var descriptionText = ""
    @State private var coordinate = CLLocationCoordinate2D()
    @State private var showingMapPicker = false

    var onSave: ((LandmarkEntity) -> Void)?

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
                        newLandmark.name = name
                        newLandmark.latitude = coordinate.latitude
                        newLandmark.longitude = coordinate.longitude
                        //newLandmark.eventDescriptionAttribute = descriptionText

                        do {
                            try viewContext.save()
                            onSave?(newLandmark)
                            presentationMode.wrappedValue.dismiss()
                        } catch {
                            print("Error saving new landmark: \(error.localizedDescription)")
                        }
                    }
                }
            }
            .navigationBarTitle("Добавить достопримечательность", displayMode: .inline)
        }
    }
}
