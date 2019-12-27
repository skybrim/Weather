//
//  Request.swift
//  Weather
//
//  Created by wiley on 2019/12/27.
//  Copyright © 2019 wiley. All rights reserved.
//

import Foundation

let key = "34eec3e24636a4064dfe21d389892d10"

struct WeatherRequest<T: Codable & Parsable>: CodableRequestProtocol {

    typealias Location = (latitude: Double, longitude: Double)

    var host: String = "https://api.darksky.net/forecast/"
    var path: String {
        return key + "/" + "\(location.latitude),\(location.longitude)"
    }
    var location: Location
    var method: HTTPMethod = .GET
    var parameters: [String: Any]?
    var headers: [String: String]?

    typealias Response = T

}
