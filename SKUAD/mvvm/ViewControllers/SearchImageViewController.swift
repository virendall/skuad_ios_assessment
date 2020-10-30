//
//  SearchImageViewController.swift
//  SKUAD
//
//  Created by Virender Dall on 30/10/20.
//  Copyright © 2020 Virender Dall. All rights reserved.
//

import UIKit
import Kingfisher

class SearchImageViewController: UIViewController {
    
    weak var coordinator: MainCoordinator!
    
    private lazy  var  disposeBag: DisposeBag? = {
        return DisposeBag()
    }()
    
    private lazy var viewModel: SearchImagesViewModel = {
        return SearchImagesViewModel(api: client, endPoint: SearchEndPoint.searchImage)
    }()
    
    private lazy var client: Requestable = {
        return ServiceAPI()
    }()
    
    private lazy var searchController: UISearchController = { UISearchController(searchResultsController: nil) }()
    
    private let KCellReuseIdentifier = "ImageTableViewCell"
    
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView! 
    
    @IBOutlet var tableview: UITableView! {
        didSet {
            self.tableview.register(UINib(nibName: KCellReuseIdentifier, bundle: nil), forCellReuseIdentifier: KCellReuseIdentifier)
            self.tableview?.tableFooterView = UIView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.searchBar.placeholder = "Search Images"
        searchController.searchBar.delegate = self
        searchController.dimsBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        self.viewModel.imageResult.bind {[weak self] (_) in
            self?.tableview.reloadData()
        }.disposed(by: disposeBag)
        
        self.viewModel.loading.bind(listener: {[weak self] (isLoading) in
            self?.activityIndicatorView.isHidden = !isLoading
        }).disposed(by: disposeBag)
        
        self.viewModel.error.bind {[weak self] (error) in
            guard let _error = error else {
                return;
            }
            self?.showAlert(msg: _error)
        }.disposed(by: disposeBag)
    }
    
    deinit {
        disposeBag = nil
    }
}

extension SearchImageViewController {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard (scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height,
              !viewModel.isLoading(), viewModel.totalImages() > 0 else {
            return
        }
        viewModel.searchImagesBy(name: searchController.searchBar.text, loadNextPage: true)
    }
}

extension SearchImageViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        self.viewModel.clearResult()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.searchImagesBy(name: searchBar.text)
    }
}

extension SearchImageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.totalImages()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: KCellReuseIdentifier) as! ImageTableViewCell
        let url = self.viewModel.imageURlFor(index: indexPath.row)
        cell.searchImage.kf.setImage(with: url)
        cell.searchImageHeight.constant = self.viewModel.imageViewHeightFor(index: indexPath.row, width: tableView.frame.width)
        return cell;
    }
}

extension SearchImageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.coordinator.fullImage(viewModel: self.viewModel, index: indexPath.row)
    }
}
