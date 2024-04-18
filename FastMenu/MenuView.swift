//
//  ContentView.swift
//  FastMenu
//
//  Created by Brett Lenz on 4/5/24.
//

import SwiftUI
import URLImage

struct MenuView: View {
    @ObservedObject var viewModel = MenuViewModel(
        locationService: LocationService(),
        yelpService: YelpService()
    )

    var body: some View {
        Text("FastMenu")
            .font(.largeTitle)
            .fontWeight(.medium)
            .foregroundColor(.blue)

        ScrollView {
            LazyVGrid(columns: Array(repeating: GridItem(), count: 2)) {
                ForEach(viewModel.menuItems, id: \.imageURL) { item in
                    URLImage(item.imageURL) { image in
                        image
                            .resizable()
                            .frame(width: 200, height: 200)
                            .overlay(alignment: .top) {
                                Text(item.businessName)
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            }
                    }
                }
            }
        }
    }
}

#Preview {
    MenuView()
}
