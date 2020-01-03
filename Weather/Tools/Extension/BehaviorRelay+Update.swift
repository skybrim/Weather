//
//  BehaviorRelay+Update.swift
//  Weather
//
//  Created by wiley on 2020/1/3.
//  Copyright © 2020 wiley. All rights reserved.
//

import Foundation

extension BehaviorRelay {

    /// Accept update of current value
    /// - Parameter update: mutate current value in closure
    func acceptUpdate(byMutating update: (inout Element) -> Void) {
        var newValue = value
        update(&newValue)
        accept(newValue)
    }

    /// Accept new value generated from current value
    /// - Parameter update: generate new value from current, and return it
    func acceptUpdate(byNewValue update: (Element) -> Element) {
        accept(update(value))
    }
}
