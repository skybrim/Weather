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
        weather = BehaviorRelay(value: initialWeather)
        city = BehaviorRelay(value: initialCity)
        currentlyWeather = weather.asObservable()
        currentlyCity = city.asObservable()
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
    
    var time: Observable<String> {
        return currentlyWeather.map {
            let formatter = DateFormatter()
            formatter.dateFormat = "E, dd MMMM"
            return formatter.string(from: $0.currently.time)
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
