//
//  SearchHistoryViewController.swift
//  SKUAD
//
//  Created by Virender Dall on 31/10/20.
//  Copyright © 2020 Virender Dall. All rights reserved.
//

import UIKit

protocol HistoryTableViewDelegate: class {
    func didSelect(query: String)
}

class SearchHistoryViewController: UITableViewController {
    
    weak var viewModel: SearchImagesViewModel!
    weak var historyTableViewDelegate: HistoryTableViewDelegate?
    
    private lazy  var  disposeBag: DisposeBag? = {
        return DisposeBag()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.searchHistory.bind {[weak self] (_) in
            self?.tableView.reloadData()
        }.disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.totalSearchQuery()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        cell.textLabel?.text = viewModel.queryFor(index: indexPath.row)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let delegate = self.historyTableViewDelegate {
            delegate.didSelect(query: viewModel.queryFor(index: indexPath.row))
        }
    }
    
    deinit {
        disposeBag = nil
    }
}
