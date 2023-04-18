//
//  MapPickerView.swift
//  Time travel
//
//  Created by Ilya on 18.04.2023.
//

import Foundation
import SwiftUI
import MapKit

struct MapPickerView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var coordinate: CLLocationCoordinate2D

    @State private var mapView = MKMapView()

    var body: some View {
        ZStack {
            MapPickerRepresentable(mapView: $mapView)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    let touchPoint = mapView.center
                    let touchMapCoordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
                    coordinate = touchMapCoordinate
                }
            Circle()
                .fill(Color.blue)
                .opacity(0.3)
                .frame(width: 32, height: 32)
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 30))
                            .padding()
                            .background(Color.white.opacity(0.75))
                            .clipShape(Circle())
                            .padding(.trailing)
                    }
                }
            }
        }
    }
}

struct MapPickerRepresentable: UIViewRepresentable {
    @Binding var mapView: MKMapView

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> MKMapView {
        mapView.delegate = context.coordinator
        return mapView
    }

    func updateUIView(_ view: MKMapView, context: Context) {
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapPickerRepresentable

        init(_ parent: MapPickerRepresentable) {
            self.parent = parent
        }
    }
}
