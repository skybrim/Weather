//
//  Double+Addition.swift
//  Util
//
//  Created by wiley on 2020/1/8.
//  Copyright © 2020 wiley. All rights reserved.
//

import Foundation

extension Double {
    public func roundTo(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
