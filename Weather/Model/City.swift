//
//  City.swift
//  Weather
//
//  Created by wiley on 2019/12/27.
//  Copyright © 2019 wiley. All rights reserved.
//

import Foundation

struct City: Codable {
    
    var name: String
    var district: String?
    var latitude: Double
    var longitude: Double

    static let unknow = City(name: " _ ", district: " _ ", latitude: 0, longitude: 0)
    
    static let test = City(name: "test", district: " _ ", latitude: 0, longitude: 0)

}

extension City: Equatable {
    public static func == (lhs: City, rhs: City) -> Bool {
        return lhs.name == rhs.name
    }
}
