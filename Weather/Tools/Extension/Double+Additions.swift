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
        return ((self - 32.0).rounded() / 1.8).roundTo(places: 2)
    }
}

extension Double {
    func roundTo(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
