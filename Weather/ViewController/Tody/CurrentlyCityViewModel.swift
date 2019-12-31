//
//  CurrentlyCityViewModel.swift
//  Weather
//
//  Created by wiley on 2019/12/31.
//  Copyright © 2019 wiley. All rights reserved.
//

import Foundation

struct CurrentlyCityViewModel {
    var city: City
    
    static let unkonw = CurrentlyCityViewModel(city: .unknow)
}
