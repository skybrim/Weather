//
//  Double+Additions.swift
//  Weather
//
//  Created by wiley on 2019/12/31.
//  Copyright © 2019 wiley. All rights reserved.
//

import Foundation

extension Double {
    func toCelsius() -> Double {
        return (self - 32.0) / 1.8
    }
}
