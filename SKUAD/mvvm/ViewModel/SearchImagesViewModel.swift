//
//  SearchImagesViewModel.swift
//  SKUAD
//
//  Created by Virender Dall on 30/10/20.
//  Copyright © 2020 Virender Dall. All rights reserved.
//

import UIKit
import Alamofire

class SearchImagesViewModel: NSObject {
    
    private let api: Requestable
    private let endPoint: EndPointType
    private var dataRequest: DataRequest?
    
    var imageResult: Box<SearchImageModel> = Box(SearchImageModel())
    var error: Box<String?> = Box(nil)
    var isLoading: Box<Bool> = Box(false)
    var haveMoreImages: Bool = true
    var page = 1
    
    init(api: Requestable, endPoint: EndPointType) {
        self.api = api
        self.endPoint = endPoint
    }
    
    func searchImagesBy(name: String?, loadNextPage: Bool = false) {
        guard let _name = name else {
            self.error.value = APIErrors.emptySearch.localizedDescription
            return
        }
        
        page = loadNextPage ? page + 1 : 1
        
        if !haveMoreImages && page != 1 {
            self.error.value = APIErrors.noMoreImagesFound.localizedDescription
            return
        }
        
        isLoading.value = true
        dataRequest = self.api.responseData(endPoint: endPoint, params: ["q" : _name, "page" : page], response: SearchImageModel.self) { [weak self](response) in
            guard let `self` = self else {
                return
            }
            switch response.result {
            case .success(let model):
                if(self.page == 1) {
                    self.imageResult.value = model
                } else {
                    self.imageResult.value.hits.append(contentsOf: model.hits)
                }
                
                if (self.totalImages() == 0) {
                    self.error.value = APIErrors.noImageFound.localizedDescription
                }
                self.haveMoreImages = self.totalImages() < model.totalHits
            case .failure(let error):
                self.error.value = error.localizedDescription
            }
            self.isLoading.value = false
        }
    }
    
    
    func totalImages() -> Int {
        return self.imageResult.value.hits.count
    }
    
    func imageFor(index: Int) -> Hit {
        return self.imageResult.value.hits[index]
    }
    
    func imageViewHeightFor(hit: Hit, width: CGFloat) -> CGFloat {
        return (hit.webformatHeightCgFloat / hit.webformatWidthCgFloat) * width
    }
}
