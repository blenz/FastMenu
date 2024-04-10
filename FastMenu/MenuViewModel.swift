//
//  MenuViewModel.swift
//  FastMenu
//
//  Created by Brett Lenz on 4/5/24.
//

import Foundation
import URLImage

class MenuViewModel: ObservableObject, LocationServiceDelegate {
    @Published var menuItems: [MenuItem]

    private let locationService: LocationService

    init(locationService: LocationService) {
        self.menuItems = [
            MenuItem(url: URL(string: "https://source.unsplash.com/200x200/?food")!),
            MenuItem(url: URL(string: "https://source.unsplash.com/200x200/?pizza")!),
            MenuItem(url: URL(string: "https://source.unsplash.com/200x200/?cheese")!),
            MenuItem(url: URL(string: "https://source.unsplash.com/200x200/?dog")!),
        ]

        self.locationService = locationService
        self.locationService.delegate = self
        self.locationService.startUpdatingLocation()
    }

    func didUpdateLocation(latitude: Double, longitude: Double) {
        print(latitude, longitude)
    }

    func didFailWithError(error: Error) {
        print("Failed to get location: \(error.localizedDescription)")
    }
}
