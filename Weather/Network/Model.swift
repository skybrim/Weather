//
//  Model.swift
//  Weather
//
//  Created by wiley on 2019/12/27.
//  Copyright © 2019 wiley. All rights reserved.
//

import Foundation


struct Weather: Parsable, Codable  {

    var latitude: Double
    var longitude: Double
    var timezone: String
    
}
