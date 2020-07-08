//
//  NavigationDetail.swift
//  MacLandmarks
//
//  Created by Upadhyay, Anil (623) on 08/07/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import SwiftUI
import MapKit

struct NavigationDetail: View {
    @EnvironmentObject var userdata: UserData
    var landmark: Landmark
    
    var landmarkIndex: Int  {
        userdata.landmarks.firstIndex(where: { $0.id == landmark.id})!
    }
    var body: some View {
        ScrollView {
            MapView(coordinate: landmark.locationCoordinate)
                .frame(height: 250)
            Button("Opne in Maps") {
                let destination = MKMapItem(placemark: MKPlacemark(coordinate: self.landmark.locationCoordinate))
                destination.name = self.landmark.name
                destination.openInMaps()
            }
            VStack(alignment: .leading, spacing: 12) {
                HStack(alignment: .center, spacing: 24) {
                    CircleImage(image: landmark.image.resizable(), shadowRadius: 4)
                        .frame(width: 160, height: 160)
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text(landmark.name).font(.title)
                            Button(action: {
                                self.userdata.landmarks[self.landmarkIndex]
                                    .isFavorite.toggle()
                            }) {
                                if userdata.landmarks[self.landmarkIndex].isFavorite {
                                    Image("star-filled")
                                    .resizable()
                                        .renderingMode(.template)
                                        .foregroundColor(.yellow)
                                    .accessibility(label: Text("Remove from favorites"))
                                } else {
                                    Image("star-empty")
                                    .resizable()
                                        .renderingMode(.template)
                                        .foregroundColor(.gray)
                                    .accessibility(label: Text("Add to favorites"))
                                }
                            }
                            .frame(width: 20, height: 20)
                            .buttonStyle(PlainButtonStyle())
                        }
                        Text(landmark.park)
                        Text(landmark.state)
                    }
                    .font(.caption)
                }
                Divider()
                Text("About \(landmark.name)")
                    .font(.headline)
                Text(landmark.description)
                .lineLimit(nil)
            }
        .padding()
            .frame(maxWidth: 700)
            .offset(x: 0, y: -50)
        }
    }
}

struct NavigationDetail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationDetail(landmark: landmarkData[0])
        .environmentObject(UserData())
    }
}
