//
//  EndPointType.swift
//  SKUAD
//
//  Created by Virender Dall on 30/10/20.
//  Copyright © 2020 Virender Dall. All rights reserved.
//

import Foundation
import Alamofire
public typealias Headers = [String : String]

public protocol EndPointType {
    var baseURL: String { get }
    var url: String { get }
    var httpMethod: HTTPMethod { get }
    var headers: Headers { get }
}
