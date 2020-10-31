//
//  SearchImagesViewModel.swift
//  SKUADTests
//
//  Created by Virender Dall on 31/10/20.
//  Copyright © 2020 Virender Dall. All rights reserved.
//

import XCTest
@testable import SKUAD

class SearchImagesViewModelTests: XCTestCase {
    
    var viewModel: SearchImagesViewModel!
    
    override func setUpWithError() throws {
        viewModel = SearchImagesViewModel(api: MockServiceAPI(), endPoint: TestSearchEndPoint.searchImageSuccess)
    }


    func test_api_call_with_success_response() throws {
        viewModel.searchImagesBy(name: "flower", loadNextPage: false)
        XCTAssertEqual(viewModel.imageResult.value.hits.count, 20)
        XCTAssertEqual(viewModel.totalImages(), 20)
    }
    
    func test_call_success_next_page_response() throws {
        viewModel.searchImagesBy(name: "flower", loadNextPage: false)
        viewModel.searchImagesBy(name: "flower", loadNextPage: true)
        XCTAssertEqual(viewModel.imageResult.value.hits.count, 40)
    }
    
    func test_api_call_with_no_response() throws {
        viewModel = SearchImagesViewModel(api: MockServiceAPI(), endPoint: TestSearchEndPoint.searchImageNoResult)
        viewModel.searchImagesBy(name: "ABCJASASA", loadNextPage: false)
        XCTAssertEqual(viewModel.imageResult.value.hits.count, 0)
        XCTAssertEqual(viewModel.error.value, APIErrors.noImageFound.localizedDescription)
    }

    func test_images_when_search_nil_string() throws {
        viewModel.searchImagesBy(name: nil, loadNextPage: false)
        XCTAssertEqual(viewModel.error.value, APIErrors.emptySearch.localizedDescription)
    }
    
    func test_api_call_when_all_imagesLoaded() throws {
        viewModel = SearchImagesViewModel(api: MockServiceAPI(), endPoint: TestSearchEndPoint.searchHaveLimitedRecords)
        viewModel.searchImagesBy(name: "flower", loadNextPage: false)
        viewModel.searchImagesBy(name: "flower", loadNextPage: true)
        XCTAssertEqual(viewModel.error.value, APIErrors.noMoreImagesFound.localizedDescription)
    }

}
