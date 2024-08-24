//
//  ContentView.swift
//  GetNearbyActivity
//
//  Created by manvendu pathak  on 20/08/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var locationManager = LocationManager()
    @StateObject private var networkManager = NetworkManager()
    
    var body: some View {
        VStack {
            if let response = networkManager.response {
                List(response.features) { feature in
                    Text(feature.properties.formatted)
                }
            } else {
                Text("Loading nearby facilities...")
            }
        }
        .onAppear{
            locationManager.checkLocationAuthorization()
            fetchNearbyFacilities()
        }
//        .onChange(of: locationManager.lastKnownLocation) { newLocation in
//            
//        }
    }
    
    private func fetchNearbyFacilities() {
           if let location = locationManager.lastKnownLocation {
               networkManager.fetchNearbyToilets(latitude: 12.971599, longitude: 77.594566)
           }
       }
}

#Preview {
    ContentView()
}
