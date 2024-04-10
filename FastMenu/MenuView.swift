//
//  ContentView.swift
//  FastMenu
//
//  Created by Brett Lenz on 4/5/24.
//

import SwiftUI
import URLImage

struct MenuView: View {
    @ObservedObject var viewModel = MenuViewModel(locationService: LocationService())

    var body: some View {
        Text("FastMenu")
            .font(.largeTitle)
            .fontWeight(.medium)
            .foregroundColor(.blue)

        ScrollView {
            LazyVGrid(columns: Array(repeating: GridItem(), count: 2)) {
                ForEach(viewModel.menuItems, id: \.url) { item in
                    URLImage(item.url) { $0 }
                }
            }
        }
    }
}

#Preview {
    MenuView()
}
