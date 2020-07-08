//
//  NavigationPrimary.swift
//  MacLandmarks
//
//  Created by Upadhyay, Anil (623) on 08/07/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import SwiftUI

struct NavigationPrimary: View {
    @Binding var selectedLandmark: Landmark?
    @State private var filter: FilterType = .all
    var body: some View {
        VStack {
            Filter(filter: $filter)
                .controlSize(.small)
                .padding([.top, .leading], 8)
                .padding(.trailing,  4)
            
            LandmarkList(selectedLandmark: $selectedLandmark, filter: $filter)
            .listStyle(SidebarListStyle())
        }
        .frame(minWidth: 225, maxWidth: 300)
    }
}

struct NavigationPrimary_Previews: PreviewProvider {
    static var previews: some View {
        NavigationPrimary(selectedLandmark: .constant(landmarkData[1]))
        .environmentObject(UserData())
    }
}
