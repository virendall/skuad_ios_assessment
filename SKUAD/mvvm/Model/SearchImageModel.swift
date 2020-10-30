//
//  SearchImageModel.swift
//  SKUAD
//
//  Created by Virender Dall on 30/10/20.
//  Copyright © 2020 Virender Dall. All rights reserved.
//

import UIKit

import Foundation

struct SearchImageModel: Codable {
    var total, totalHits: Int
    var hits: [Hit]
    init() {
        total = 0
        totalHits = 0
        hits = []
    }
}

struct Hit: Codable {
    let id: Int
    let pageURL: String
    let type: TypeEnum
    let tags: String
    let previewURL: String
    let previewWidth, previewHeight: Int
    let webformatURL: String
    let webformatWidth, webformatHeight: Int
    let largeImageURL: String
    let imageWidth, imageHeight, imageSize, views: Int
    let downloads, favorites, likes, comments: Int
    let userID: Int64
    let user: String
    let userImageURL: String
    
    var webformatWidthCgFloat: CGFloat {
        get {
            return CGFloat(webformatWidth)
        }
    }
    
    var webformatHeightCgFloat: CGFloat {
        get {
            return CGFloat(webformatHeight)
        }
    }

    enum CodingKeys: String, CodingKey {
        case id, pageURL, type, tags, previewURL, previewWidth, previewHeight, webformatURL, webformatWidth, webformatHeight, largeImageURL, imageWidth, imageHeight, imageSize, views, downloads, favorites, likes, comments
        case userID = "user_id"
        case user, userImageURL
    }
}

enum TypeEnum: String, Codable {
    case photo = "photo"
}
