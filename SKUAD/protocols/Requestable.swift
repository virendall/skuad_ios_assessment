//
//  Requestable.swift
//  SKUAD
//
//  Created by Virender Dall on 30/10/20.
//  Copyright © 2020 Virender Dall. All rights reserved.
//

import Foundation
import Alamofire

public typealias Parameters = [String : Any]

protocol Requestable {
    @discardableResult
    func responseData<T>(endPoint: EndPointType, params: Parameters?, response: T.Type, completion: @escaping (Result<T, Error>) -> Void) -> DataRequest? where T : Decodable
}
