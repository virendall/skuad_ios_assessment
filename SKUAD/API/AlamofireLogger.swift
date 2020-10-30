//
//  AlamofireLogger.swift
//  SKUAD
//
//  Created by Virender Dall on 30/10/20.
//  Copyright © 2020 Virender Dall. All rights reserved.
//

import UIKit

import Alamofire

final class AlamofireLogger: EventMonitor {
    func request(_ request: Request, didCompleteTask task: URLSessionTask, with error: AFError?) {
        
        #if DEBUG
        let headers = """
        ⚡️⚡️⚡️⚡️ URL: \(request)
        ⚡️⚡️⚡️⚡️ Error: \(error?.localizedDescription ?? "No error found")
        """
        NSLog(headers)
        #endif
    }
    func requestDidResume(_ request: Request) {
        
        #if DEBUG
        let body = request.request.flatMap { $0.httpBody.map { String(decoding: $0, as: UTF8.self) } } ?? "None"
        
        let headers = """
        ⚡️⚡️⚡️⚡️ Request Started: \(request)
        ⚡️⚡️⚡️⚡️ Body Data: \(body)
        """
        NSLog(headers)
        #endif
    }
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        #if DEBUG
        print("⚡️URL: \(dataTask.currentRequest?.url?.absoluteString ?? "")")
        print("⚡️Response: \(String(describing: String(data: data, encoding: .utf8)))")
        #endif
    }
}
