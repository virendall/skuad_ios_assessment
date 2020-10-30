//
//  ServiceAPI.swift
//  SKUAD
//
//  Created by Virender Dall on 30/10/20.
//  Copyright © 2020 Virender Dall. All rights reserved.
//

import Foundation
import Alamofire
class ServiceAPI: Requestable {
    
    private let session: Session = {
        let config = URLSessionConfiguration.af.default
        config.timeoutIntervalForRequest = 30
        return Session(configuration: config, eventMonitors: [ AlamofireLogger() ])
    }()
    
    @discardableResult
    func responseData<T>(endPoint: EndPointType, params: Parameters?, response: T.Type, completion: @escaping (DataResponse<T, AFError>) -> Void) -> DataRequest where T : Decodable {
        print(endPoint.url)
        print(params ?? [:])
        print(endPoint.headers)
        return session.request(
            endPoint.url,
            method: endPoint.httpMethod,
            parameters: params,
            encoding: URLEncoding.default,
            headers: HTTPHeaders(endPoint.headers)
        )
        .responseDecodable(of: T.self, completionHandler: completion)
        
    }
}
