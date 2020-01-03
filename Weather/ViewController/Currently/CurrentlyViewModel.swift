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
    
    let bag = DisposeBag()
    let iconDictionary: [String: String]
    
    init(initialCity: City = Store.shared.currentlyCity, initialWeather: Weather = Weather.empty) {
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
        
        obserStoreCurrentlyCity()
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

extension CurrentlyViewModel {
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
    
    func obserStoreCurrentlyCity() {
        NotificationCenter.default
            .rx
            .notification(Store.storeChanged)
            .subscribe(onNext: { _ in
                self.city.accept(Store.shared.currentlyCity)
            })
            .disposed(by: bag)
    }
}
