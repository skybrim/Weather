//
//  CurrentlyViewModel.swift
//  Weather
//
//  Created by wiley on 2019/12/30.
//  Copyright © 2019 wiley. All rights reserved.
//

import Foundation

struct CurrentlyWeatherViewModel {
    let weather: BehaviorRelay<Weather>
    private let currentlyWeather: Observable<Weather>
    
    init(initialWeather: Weather = Weather.empty) {
        weather = BehaviorRelay(value: initialWeather)
        currentlyWeather = weather.asObservable().share(replay: 1)
    }
}
