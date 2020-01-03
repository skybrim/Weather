//
//  Store.swift
//  Weather
//
//  Created by wiley on 2020/1/3.
//  Copyright © 2020 wiley. All rights reserved.
//

import Foundation
import CoreLocation

final class Store {
    private static let storeCitiesPath: String = "cities.json"
    private static let currentlyCityPath: String = "cities.json"
    private static let documentDirectory = try? FileManager.default
        .url(for: .libraryDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    static let storeChanged = Notification.Name("StoreChanged")

    static let shared = Store(url: documentDirectory)
    
    let baseURL: URL?
    private(set) var storeCities: [City]
    private(set) var currentlyCity: City

    private init(url: URL?) {
        baseURL = url
        
        if let url = url,
            let data = try? Data(contentsOf: url.appendingPathComponent(Store.storeCitiesPath)),
            let cities = try? JSONDecoder().decode([City].self, from: data) {
            storeCities = cities
        } else {
            storeCities = []
        }
        
        if let url = url,
            let data = try? Data(contentsOf: url.appendingPathComponent(Store.currentlyCityPath)),
            let city = try? JSONDecoder().decode(City.self, from: data) {
            currentlyCity = city
        } else {
            currentlyCity = City.unknow
        }
    }
    
    func refreshCurrentlyCity(latitude: Double, longitude: Double) {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        
        CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) in
            if let error = error {
                self.currentlyCity = City.unknow
                dump(error)
                return
            }
            if let name = placemarks?.first?.locality,
                let district = placemarks?.first?.subLocality {
                let city = City(name: name,
                                district: district,
                                latitude: location.coordinate.latitude,
                                longitude: location.coordinate.longitude)
                self.currentlyCity = city
            } else {
                self.currentlyCity = City.unknow
            }
            self.save()
        }
    }
    
    func save() {
        if let url = baseURL,
            let storeCitiesData = try? JSONEncoder().encode(storeCities),
            let currentlyCityData = try? JSONEncoder().encode(currentlyCity) {
            do {
                try storeCitiesData.write(to: url.appendingPathComponent(Store.storeCitiesPath))
                try currentlyCityData.write(to: url.appendingPathComponent(Store.currentlyCityPath))
            } catch {
                dump(error)
            }
        }
        NotificationCenter.default.post(name: Store.storeChanged, object: nil)
    }
}
