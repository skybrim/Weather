//
//  CurrentlyViewModel.swift
//  Weather
//
//  Created by wiley on 2019/12/30.
//  Copyright © 2019 wiley. All rights reserved.
//

import Foundation

struct CurrentlyWeatherViewModel {
    var weather: Weather
    
    static let empty = CurrentlyWeatherViewModel(weather: .empty)
}
