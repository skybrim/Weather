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
        currentlyCity = city.asObservable().share(replay: 1)
                
        if let path = Bundle.main.path(forResource: "WeatherIcon", ofType: "plist"),
            let dict = NSDictionary(contentsOfFile: path) as? [String: String] {
                iconDictionary = dict
        } else {
            iconDictionary = [:]
        }
    }
    
    var name: Observable<String> {
        return currentlyCity.map {
            return $0.name
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
    
    var temperature: Observable<String> {
        return currentlyWeather.map {
            return String($0.currently.temperature.toCelsius()) + "℃"
        }
    }
    
    var location: Observable<CLLocation?> {
        return currentlyCity.map {
            return CLLocation(latitude: $0.latitude, longitude: $0.longitude)
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
            var name = ""
            if let province = placemarks?.first?.administrativeArea,
                let subLocality = placemarks?.first?.subLocality {
                name = province + subLocality
            }
            if let locality = placemarks?.first?.locality {
                name = locality
            }
            if let locality = placemarks?.first?.locality,
                let subLocality = placemarks?.first?.subLocality {
                name = locality + subLocality
            }
            if name.count > 0 {
                let newValue = City(name: name,
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
