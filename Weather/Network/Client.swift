//
//  Client.swift
//  Weather
//
//  Created by wiley on 2019/12/27.
//  Copyright © 2019 wiley. All rights reserved.
//

import Foundation
import Alamofire

struct WeatherClient: ClientProtocol {
    /// # Singleton
    static let shared = WeatherClient()
    private init() {}
    
    func send<T: RequestProtocol>(_ request: T, handler: @escaping (Swift.Result<T.Response, Error>) -> Void) {
        guard let url = URL(string: request.host + request.path) else {
            return
        }
        let method = Alamofire.HTTPMethod(rawValue: request.method.rawValue)
        let headers =  Alamofire.HTTPHeaders(request.headers ?? [:])
        let dataRequest: Alamofire.DataRequest
        dataRequest = AF.request(url,
                                 method: method,
                                 parameters: request.parameters,
                                 headers: headers)
        dataRequest.responseData { (response) in
            // 判断请求结果
            switch response.result {
            case .success(let data):
                // parse data
                let parseResult = T.Response.parse(data: data)
                // 判断解析结果
                switch parseResult {
                case .success(let model):
                    handler(.success(model))
                case .failure(let parseError):
                    handler(.failure(parseError))
                }
            case .failure(let afError):
                handler(.failure(afError))
            }
        }
    }
}
