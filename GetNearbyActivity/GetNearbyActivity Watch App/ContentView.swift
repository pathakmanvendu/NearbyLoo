//
//  ContentView.swift
//  GetNearbyActivity Watch App
//
//  Created by manvendu pathak  on 20/08/24.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @StateObject private var locationManager = LocationManager()
    @StateObject private var networkManager = NetworkManager()
    @ObservedObject var viewModel: LottieViewModel = .init()
    @State private var isTimeUp = false
    
    var body: some View {
        VStack {
            if !isTimeUp{
                VStack(alignment: .center){
                    Image(uiImage: viewModel.image)
                        .resizable()
                        .scaledToFit()
                        .onAppear {
                            self.viewModel.loadAnimation(url: URL(string: "https://lottie.host/82586540-bb04-4d65-adb6-de8e16f4f759/KOvbgb7jdn.json")!)
                        }
                    Text("Just a sec loading a loo for you....")
                        .multilineTextAlignment(.center)
                        .font(.callout)
                        .bold()
                }
            }
            else{
                if let response = networkManager.response {
                    List(response.features) { feature in
                        Text(feature.properties?.street ?? "")
                            .onTapGesture {
                                openMaps(for: feature)
                            }
                    }
                }
            }
        }
        .onAppear{
            startTimer()
            locationManager.checkLocationAuthorization()
            fetchNearbyFacilities()
        }
        .onChange(of: locationManager.lastKnownLocation) { newLocation in
            fetchNearbyFacilities()
        }
    }
    
    private func fetchNearbyFacilities() {
        if let location = locationManager.lastKnownLocation {
            networkManager.fetchNearbyToilets(latitude: location.latitude, longitude: location.longitude)
        }
    }
    
    private func startTimer(){
        DispatchQueue.main.asyncAfter(deadline: .now()+5){
            isTimeUp = true
        }
    }
    
    private func openMaps(for feature: Feature) {
        guard let latitude = feature.properties?.lat,
              let longitude = feature.properties?.lon else {
            return
        }
        
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let placemark = MKPlacemark(coordinate: coordinate)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = feature.properties?.formatted
        mapItem.openInMaps(launchOptions: [
            MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking
        ])
    }
}

#Preview {
    ContentView()
}

struct EquatableLocation: Equatable {
    let latitude: Double
    let longitude: Double
    
    init(coordinate: CLLocationCoordinate2D) {
        self.latitude = coordinate.latitude
        self.longitude = coordinate.longitude
    }
    
    static func == (lhs: EquatableLocation, rhs: EquatableLocation) -> Bool {
        lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}

