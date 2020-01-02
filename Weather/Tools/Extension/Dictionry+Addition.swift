//
//  Dictionry+Addition.swift
//  Weather
//
//  Created by wiley on 2020/1/2.
//  Copyright © 2020 wiley. All rights reserved.
//

import Foundation

extension Dictionary {
    static func iconDictionry() -> [String: String] {
        if let path = Bundle.main.path(forResource: "WeatherIcon", ofType: "plist"),
            let dict = NSDictionary(contentsOfFile: path) as? [String: String] {
                return dict
        }
        return [:]
    }
}
