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
    private let KMaxNumberOfSuggestion = 10
    
    private var page = 1
    private var dataRequest: DataRequest?
    private var haveMoreImages: Bool = true

    var imageResult: Box<SearchImageModel> = Box(SearchImageModel())
    var error: Box<String?> = Box(nil)
    var loading: Box<Bool> = Box(false)
    var searchHistory: Box<[String]> = Box([])

    
    
    init(api: Requestable, endPoint: EndPointType) {
        self.api = api
        self.endPoint = endPoint
    }
    
    func cancelDataRequest() {
        self.dataRequest?.cancel()
    }
    
    func isLoading() -> Bool {
        return self.loading.value
    }
    
    func clearResult() {
        self.imageResult.value = SearchImageModel()
    }
}

extension SearchImagesViewModel {
    
    func totalImages() -> Int {
        return self.imageResult.value.hits.count
    }
    
    func imageURlFor(index: Int) -> URL? {
        if let url = URL(string: self.imageResult.value.hits[index].webformatURL)  {
            return url
        }
        return nil
    }
    
    func imageViewHeightFor(index: Int, width: CGFloat) -> CGFloat {
        let hit = self.imageResult.value.hits[index]
        return (hit.webformatHeightCgFloat / hit.webformatWidthCgFloat) * width
    }
    
}

extension SearchImagesViewModel {
    
    func totalSearchQuery() -> Int {
        return self.searchHistory.value.count > KMaxNumberOfSuggestion ? KMaxNumberOfSuggestion : self.searchHistory.value.count
    }
    
    func queryFor(index: Int) -> String {
        return self.searchHistory.value[index]
    }
}

extension SearchImagesViewModel {
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
        
        loading.value = true
        dataRequest = self.api.responseData(endPoint: endPoint, params: ["q" : _name, "page" : page], response: SearchImageModel.self) { [weak self](response) in
            guard let `self` = self else {
                return
            }
            switch response {
            case .success(let model):
                self.updateResult(model, _name)
            case .failure(let error):
                self.error.value = error.localizedDescription
            }
            self.loading.value = false
        }
    }
    
    func addSearchQuery(_ query: String) {
        if(!searchHistory.value.contains(query)) {
            searchHistory.value.append(query)
            searchHistory.notifyListeners()
        }
    }
    
    func updateResult(_ model: SearchImageModel, _ query: String) {
        if(self.page == 1) {
            self.imageResult.value = model
        } else {
            self.imageResult.value.hits.append(contentsOf: model.hits)
        }
        if (self.totalImages() == 0) {
            self.error.value = APIErrors.noImageFound.localizedDescription
        } else {
            self.addSearchQuery(query)
        }
        self.haveMoreImages = self.totalImages() < model.totalHits
    }
}
