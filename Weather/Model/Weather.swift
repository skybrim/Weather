//
//  Model.swift
//  Weather
//
//  Created by wiley on 2019/12/27.
//  Copyright © 2019 wiley. All rights reserved.
//

import Foundation

struct Weather: Parsable, Codable {
    
    var latitude: Double
    var longitude: Double
    
//    var daily: Daily
//    var hourly: Hourly
    var currently: Currently
    
    static let empty = Weather(latitude: City.unknow.latitude,
                               longitude: City.unknow.longitude,
                               currently: Currently.empty)
    
    static func parse(data: Data) -> Result<Self, Error> {
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970
            let model = try decoder.decode(Self.self, from: data)
            return .success(model)
        } catch {
            return .failure(error)
        }
    }
}

struct Currently: Codable {
    
    var icon: String
    var time: Date
    var summary: String
    var humidity: Double
    var pressure: Double
    var windSpeed: Double
    var visibility: Double
    var cloudCover: Double
    var temperature: Double
    var precipProbability: Double
    var apparentTemperature: Double
    
    static let empty = Currently(icon: "smiley",
                                 time: Date(),
                                 summary: "Fine",
                                 humidity: 0,
                                 pressure: 0,
                                 windSpeed: 0,
                                 visibility: 0,
                                 cloudCover: 0,
                                 temperature: 0,
                                 precipProbability: 0,
                                 apparentTemperature: 0)
}

struct Hourly: Codable {
    
}

struct Daily: Codable {
    
}
