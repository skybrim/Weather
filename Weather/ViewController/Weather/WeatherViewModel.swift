//
//  WeatherViewModel.swift
//  Weather
//
//  Created by wiley on 2020/1/2.
//  Copyright © 2020 wiley. All rights reserved.
//

import Foundation
import CoreLocation

struct WeatherViewModel {
    
    let weather: BehaviorRelay<Weather>
    let city: BehaviorRelay<City>
    private let currentlyWeather: Observable<Weather>
    private let currentlyCity: Observable<City>
    
    let iconDictionary: [String: String]
    
    init(initialCity: City = City.unknow, initialWeather: Weather = Weather.empty) {
        weather = BehaviorRelay(value: initialWeather)
        city = BehaviorRelay(value: initialCity)
        currentlyWeather = weather.asObservable()
        currentlyCity = city.asObservable()
                
        if let path = Bundle.main.path(forResource: "WeatherIcon", ofType: "plist"),
            let dict = NSDictionary(contentsOfFile: path) as? [String: String] {
                iconDictionary = dict
        } else {
            iconDictionary = [:]
        }
    }
    
    var name: Observable<String> {
        return currentlyCity.map {
            return $0.name + ($0.district ?? "")
        }
    }
    
    var iconImage: Observable<UIImage> {
        return currentlyWeather.map { weather in
            let iconName = self.iconDictionary[weather.currently.icon] ?? "smiley"
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

extension WeatherViewModel {
    func refreshCurrentlyCity(latitude: Double, longitude: Double) {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        
        CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) in
            if let error = error {
                self.city.accept(City.unknow)
                dump(error)
                return
            }
            if let name = placemarks?.first?.locality,
                let district = placemarks?.first?.subLocality {
                let newValue = City(name: name,
                                    district: district,
                                    latitude: location.coordinate.latitude,
                                    longitude: location.coordinate.longitude)
                self.city.accept(newValue)
            } else {
                self.city.accept(City.unknow)
            }
        }
    }
    
    func requestWeatherData(latitude: Double, longitude: Double) {
        let request = WeatherRequest<Weather>(
            location: (latitude: latitude,
                       longitude: longitude)
        )
        WeatherClient.shared.send(request) { result in
            switch result {
            case .success(let weather):
                self.weather.accept(weather)
            case .failure(let error):
                dump(error)
            }
        }
    }
}
