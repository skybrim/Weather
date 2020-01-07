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
    private static let storeCitiesPath: String = "Cities.json"
    private static let documentDirectory = try? FileManager.default
        .url(for: .libraryDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    static let storeChanged = Notification.Name("com.skybrim.StoreChanged")

    static let shared = Store(url: documentDirectory)
    
    let baseURL: URL?
    private(set) var storeCities: [City]
    var count: Int {
        return storeCities.count
    }
    
    private init(url: URL?) {
        baseURL = url
        
        if let url = url,
            let data = try? Data(contentsOf: url.appendingPathComponent(Store.storeCitiesPath)),
            let cities = try? JSONDecoder().decode([City].self, from: data) {
            storeCities = cities
        } else {
            storeCities = []
        }
    }
    
    func addCity(city: City) {
        if storeCities.contains(city) {
            return
        }
        storeCities.append(city)
        save()
    }
    
    func deleteCity(city: City) {
        guard let index = storeCities.firstIndex(of: city) else { return }
        storeCities.remove(at: index)
        save()
    }
    
    func save() {
        if let url = baseURL,
            let storeCitiesData = try? JSONEncoder().encode(storeCities) {
            do {
                try storeCitiesData.write(to: url.appendingPathComponent(Store.storeCitiesPath))
            } catch {
                dump(error)
            }
        }
        NotificationCenter.default.post(name: Store.storeChanged, object: nil)
    }
}
