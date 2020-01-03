//
//  CitiesViewModel.swift
//  Weather
//
//  Created by wiley on 2020/1/3.
//  Copyright © 2020 wiley. All rights reserved.
//

import Foundation

struct CitiesViewModel {
    
    let cities: BehaviorRelay<[City]>
    private let storeCities: Observable<[City]>
    
    init(initialCities: [City] = Store.shared.storeCities) {
        cities = BehaviorRelay(value: initialCities)
        storeCities = cities.asObservable()
    }
    
    func addCity() {
        
    }
    
    func deleteCity() {
        
    }
}
