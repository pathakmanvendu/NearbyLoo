//
//  ListRowView.swift
//  GetNearbyActivity Watch App
//
//  Created by manvendu pathak  on 24/08/24.
//

import SwiftUI

struct ListRowView: View {
    let feature: Feature
    @ObservedObject var viewModel: LottieViewModel = .init()
    var body: some View {
        HStack {
                Image("image")
                .resizable()
                .frame(width: 60, height: 60)
            Text(feature.properties?.street ?? "")
                    .font(.footnote)
                    .foregroundColor(.black)
            .padding(.leading, 8)
        }
        .padding()
        .background(Color.accentColor)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}


