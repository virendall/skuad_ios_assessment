//
//  TestSearchEndPoint.swift
//  SKUADTests
//
//  Created by Virender Dall on 31/10/20.
//  Copyright © 2020 Virender Dall. All rights reserved.
//

import Foundation
@testable import Alamofire
@testable import SKUAD

enum TestSearchEndPoint {
    case searchImageSuccess
    case searchImageNoResult
    case searchHaveLimitedRecords
}

extension TestSearchEndPoint: EndPointType {
    var baseURL: String {
        return APIConstants.base_url.rawValue
    }
    
    var url: String {
        switch self {
        case .searchImageSuccess:
            return "search_image_result"
        case .searchImageNoResult:
            return "search_image_no_result"
        case .searchHaveLimitedRecords:
            return "search_image_limited"
        }
    }
    
    var httpMethod: HTTPMethod {
        return HTTPMethod.get
    }
    
    var headers: Headers {
        return [:]
    }
}
