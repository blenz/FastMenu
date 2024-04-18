//
//  MenuViewModel.swift
//  FastMenu
//
//  Created by Brett Lenz on 4/5/24.
//

import CoreLocation
import Foundation
import URLImage

class MenuViewModel: ObservableObject {
    @Published var menuItems: [MenuItem]

    private let locationService: LocationService
    private let yelpService: YelpService

    init(locationService: LocationService, yelpService: YelpService) {
        self.menuItems = []

        self.yelpService = yelpService

        self.locationService = locationService
        self.locationService.delegate = self
        self.locationService.startUpdatingLocation()
    }
}

extension MenuViewModel: LocationServiceDelegate {
    func didUpdateLocation(latitude: Double, longitude: Double) {
        self.yelpService.searchBusinesses(lat: 32.729142, long: -117.163794) { resp, err in
            if let err {
                print("Error searching businesses: \(err.localizedDescription)")
                return
            }

            let targetLocation = CLLocation(latitude: latitude, longitude: longitude)
            var closestDistance: CLLocationDistance = Double.infinity
            var closestBusiness: [String: Any]?

            for business in resp!["businesses"] as! [[String: Any]] {
                let coord = business["coordinates"] as! [String: Double]

                let location = CLLocation(latitude: coord["latitude"]!, longitude: coord["longitude"]!)
                let distance = location.distance(from: targetLocation)

                if distance < closestDistance {
                    closestDistance = distance
                    closestBusiness = business
                }
            }

            self.yelpService.getBusiness(id: closestBusiness!["id"] as! String) { bus, err in
                if let err {
                    print("Error searching businesses: \(err.localizedDescription)")
                    return
                }

                print(bus!)
            }
        }
    }

    func didFailWithError(error: Error) {
        print("Failed to get location: \(error.localizedDescription)")
    }
}
