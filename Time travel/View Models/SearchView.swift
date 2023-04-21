//
//  SearchView.swift
//  Time travel
//
//  Created by Ilya on 21.04.2023.
//

import Foundation
import SwiftUI
import CoreData
import CoreLocation
struct SearchView: View {
    @State private var cityName: String = ""
    @State private var landmarks: [Landmark] = []

    var body: some View {
        VStack {
            TextField("Введите название города", text: $cityName)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button(action: searchLandmarks) {
                Text("Найти достопримечательности")
            }
            .padding()

            List(landmarks) { landmark in
                NavigationLink(destination: LandmarkDetailView(landmark: landmark)) {
                    Text(landmark.name)
                }
            }
        }
        .navigationTitle("Поиск")
    }

    private func searchLandmarks() {
        let apiKey = "API_KEY"
        let urlString = "https://maps.googleapis.com/maps/api/place/textsearch/json?query=достопримечательности+в+\(cityName)&key=\(apiKey)"

        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(PlacesAPIResponse.self, from: data)
                    DispatchQueue.main.async {
                        landmarks = result.results.map { Landmark(name: $0.name, coordinate: CLLocationCoordinate2D(latitude: $0.geometry.location.lat, longitude: $0.geometry.location.lng)) }
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            } else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
            }
        }.resume()
    }
}

struct PlacesAPIResponse: Codable {
    let results: [Place]

    struct Place: Codable {
        let name: String
        let geometry: Geometry

        struct Geometry: Codable {
            let location: Location

            struct Location: Codable {
                let lat: Double
                let lng: Double
            }
        }
    }
}
