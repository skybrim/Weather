//
//  CurrentlyViewModel.swift
//  Weather
//
//  Created by wiley on 2020/1/2.
//  Copyright © 2020 wiley. All rights reserved.
//

import Foundation

struct CurrentlyViewModel {
    
    let weather: BehaviorRelay<Weather>
    let city: BehaviorRelay<City>
    private let currentlyWeather: Observable<Weather>
    private let currentlyCity: Observable<City>
        
    init(initialCity: City = City.unknow, initialWeather: Weather = Weather.empty) {
        city = BehaviorRelay(value: initialCity)
        currentlyCity = city.asObservable()
        weather = BehaviorRelay(value: initialWeather)
        currentlyWeather = weather.asObservable()
    }
    
    var name: Observable<String> {
        return currentlyCity.map {
            return $0.name + ($0.district ?? "")
        }
    }
    
    var iconImage: Observable<UIImage> {
        return currentlyWeather.map { weather in
            let iconDictionary = self.iconDictionry()
            let iconName = iconDictionary[weather.currently.icon] ?? "smiley"
            return UIImage(systemName: iconName)!
        }
    }
}

extension CurrentlyViewModel {
    func iconDictionry() -> [String: String] {
        if let path = Bundle.main.path(forResource: "WeatherIcon", ofType: "plist"),
            let dict = NSDictionary(contentsOfFile: path) as? [String: String] {
                return dict
        }
        return [:]
    }
}
