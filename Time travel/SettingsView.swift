//
//  SettingsView.swift
//  Time travel
//
//  Created by Ilya on 14.04.2023.
//

import Foundation
import SwiftUI
struct SettingsView: View {
    @State private var showingAddLandmark = false
    
    var body: some View {
        NavigationView {
            VStack {
                Button(action: {
                    showingAddLandmark = true
                }) {
                    Text("Добавить достопримечательность")
                }
                
                Spacer()
            }
            .navigationBarTitle("Настройки", displayMode: .inline)
            .sheet(isPresented: $showingAddLandmark) {
                AddLandmarkView()
            }
        }
    }
}
