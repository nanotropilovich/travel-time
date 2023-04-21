//
//  AllLandmarksView.swift
//  Time travel
//
//  Created by Ilya on 18.04.2023.
//

import Foundation
import SwiftUI
struct AllLandmarksView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: LandmarkEntity.entity(), sortDescriptors: []) private var landmarks: FetchedResults<LandmarkEntity>
    @State private var isAddLandmarkViewPresented: Bool = false

    var body: some View {
        NavigationView {
            List {
                ForEach(landmarks) { landmark in
                    NavigationLink(destination: LandmarkDetailView(landmark: Landmark(name: landmark.name ?? "", coordinate: landmark.coordinate))) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(landmark.name ?? "")
                                    .font(.headline)
                            }
                            Spacer()
                        }
                    }
                }
                .onDelete(perform: deleteLandmark)
            }
            .navigationBarTitle("Все достопримечательности", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: { isAddLandmarkViewPresented = true }) {
                Image(systemName: "plus")
            })
            .sheet(isPresented: $isAddLandmarkViewPresented) {
                AddLandmarkView()
            }
        }
    }

    private func deleteLandmark(at offsets: IndexSet) {
        for index in offsets {
            let landmark = landmarks[index]
            viewContext.delete(landmark)
        }

        do {
            try viewContext.save()
        } catch {
            print("Error deleting landmarks: \(error.localizedDescription)")
        }
    }
}


