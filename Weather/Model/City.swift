//
//  City.swift
//  Weather
//
//  Created by wiley on 2019/12/27.
//  Copyright © 2019 wiley. All rights reserved.
//

import Foundation

struct City {

    var city: String
    var district: String
    var latitude: Double
    var longitude: Double

    static let unknow = City(city: " _ ", district: " _ ", latitude: 0, longitude: 0)
}
