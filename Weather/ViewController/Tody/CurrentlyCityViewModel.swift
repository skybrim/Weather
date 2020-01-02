//
//  CurrentlyCityViewModel.swift
//  Weather
//
//  Created by wiley on 2019/12/31.
//  Copyright © 2019 wiley. All rights reserved.
//

import Foundation

struct CurrentlyCityViewModel {
    let city: BehaviorRelay<City>
    private let currentlyCity: Observable<City>
        
    init(initialCity: City = City.unknow) {
        city = BehaviorRelay(value: initialCity)
        currentlyCity = city.asObservable().share(replay: 1)
    }
    
    var name: Observable<String> {
        return currentlyCity.map {
            return $0.name + ($0.district ?? "")
        }
    }
}
