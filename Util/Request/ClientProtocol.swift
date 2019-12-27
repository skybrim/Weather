//
//  ClientProtocol.swift
//  v2ex
//
//  Created by wiley on 2019/12/23.
//  Copyright © 2019 wiley. All rights reserved.
//

import Foundation

// MARK: - Client
public protocol ClientProtocol {
    func send<T: RequestProtocol>(_ request: T, handler: @escaping (Result<T.Response, Error>) -> Void)
    //func download()
    //...
}
