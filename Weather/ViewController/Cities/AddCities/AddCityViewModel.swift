//
//  AddCityViewModel.swift
//  Weather
//
//  Created by wiley on 2020/1/7.
//  Copyright © 2020 wiley. All rights reserved.
//

import Foundation
import CoreLocation

class AddCityViewModel {

    let cities: BehaviorRelay<[City]>
    private let searchCities: Observable<[City]>
    private lazy var geocoder = CLGeocoder()
    var queryText: String? = "" {
        didSet {
            geocode(address: queryText)
        }
    }
    
    var titles: Observable<[String]> {
        return searchCities.map {
            return $0.map { $0.name }
        }
    }
    
    init() {
        cities = BehaviorRelay(value: [])
        searchCities = cities.asObservable().share(replay: 1)
    }
    
    func addCity(_ index: Int) {
        Store.shared.addCity(city: cities.value[index])
    }
    
    private func geocode(address: String?) {
        guard let address = address, !address.isEmpty else {
            cities.accept([])
            return
        }
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            if let error = error {
                dump("error \(error)")
                return
            }
            guard let placemarks = placemarks else {
                return
            }
            var temp = [City]()
            for place in placemarks {
                var name = ""
                if let province = place.administrativeArea,
                    let subLocality = place.subLocality {
                    name = province + subLocality
                }
                if let locality = place.locality {
                    name = locality
                }
                if let locality = place.locality,
                    let subLocality = place.subLocality {
                    name = locality + subLocality
                }
                if name.count > 0 {
                    if let lat = place.location?.coordinate.latitude,
                        let lon = place.location?.coordinate.longitude {
                        let newCity = City(name: name,
                                           latitude: lat,
                                           longitude: lon)
                        temp.append(newCity)
                    }
                }
            }
            self.cities.accept(temp)
        }
    }
}
