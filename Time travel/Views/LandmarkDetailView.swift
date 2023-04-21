//
//  LandmarkDetailView.swift
//  Time travel
//
//  Created by Ilya on 18.04.2023.
//

import Foundation
import SwiftUI
struct LandmarkDetailView: View {
    let landmark: Landmark

    var body: some View {
        VStack {
            Text(landmark.name)
                .font(.largeTitle)
                .padding(.top)
            MapView(landmarks: .constant([Landmark(name: landmark.name, coordinate: landmark.coordinate)]))
                .edgesIgnoringSafeArea(.all)
                .frame(height: 300)
            Spacer()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
