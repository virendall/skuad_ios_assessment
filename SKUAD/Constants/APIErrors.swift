//
//  APIErrors.swift
//  SKUAD
//
//  Created by Virender Dall on 30/10/20.
//  Copyright © 2020 Virender Dall. All rights reserved.
//

import UIKit

enum APIErrors: Error {
    case emptySearch
    case noImageFound
    case noMoreImagesFound
}

extension APIErrors {
     var localizedDescription: String {
        switch self {
        case  .emptySearch:
            return "Please let's know what kind of images you want to search"
        case .noImageFound:
            return "No result found"
        case .noMoreImagesFound:
            return "No more images for the search"
        }
        
    }
}
