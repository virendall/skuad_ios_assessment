//
//  MockServiceAPI.swift
//  SKUADTests
//
//  Created by Virender Dall on 31/10/20.
//  Copyright © 2020 Virender Dall. All rights reserved.
//

import XCTest
@testable import SKUAD
@testable import Alamofire
class MockServiceAPI: Requestable {
    
    func responseData<T>(endPoint: EndPointType, params: Parameters?, response: T.Type, completion: @escaping (Result<T, Error>) -> Void) -> DataRequest? where T : Decodable {
        let decoder = JSONDecoder()
        guard let data = FileUtil().readJsonFile(name: endPoint.url) else {
            fatalError("No file found")
        }
        let result: Result<T, Error> = decoder.decodeResponse(from: data)
        completion(result)
        return nil
    }
}
