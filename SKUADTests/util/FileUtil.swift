//
//  FileUtil.swift
//  SKUADTests
//
//  Created by Virender Dall on 31/10/20.
//  Copyright © 2020 Virender Dall. All rights reserved.
//

import Foundation
import Alamofire

class FileUtil {
     func readJsonFile(name: String) -> Data? {
        let testBundle = Bundle(for: type(of: self))
        if let path = testBundle.path(forResource: name, ofType: "json") {
            return try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        }
        return nil
    }
}

extension JSONDecoder {
    func decodeResponse<T: Decodable>(from data: Data) -> Result<T, Error> {
        do {
            return try .success(decode(T.self, from: data))
        } catch {
            return .failure(error)
        }
    }
}
