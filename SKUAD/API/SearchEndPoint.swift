//
//  SearchEndPoint.swift
//  SKUAD
//
//  Created by Virender Dall on 30/10/20.
//  Copyright © 2020 Virender Dall. All rights reserved.
//

import UIKit
import Alamofire

enum SearchEndPoint {
    case searchImage
}

extension SearchEndPoint: EndPointType {
    var baseURL: String {
        return APIConstants.base_url.rawValue
    }
    
    var url: String {
        switch self {
        case .searchImage:
            return "\(baseURL)api/?key=\(APIConstants.api_key.rawValue)&image_type=photo&pretty=true"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .searchImage:
            return HTTPMethod.get
        }
    }
    
    var headers: Headers {
        switch self {
        case .searchImage:
            return [:]
        }
    }    
}
