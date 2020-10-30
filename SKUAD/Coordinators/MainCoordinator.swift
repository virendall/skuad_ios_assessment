//
//  MainCoordinator.swift
//  SKUAD
//
//  Created by Virender Dall on 30/10/20.
//  Copyright © 2020 Virender Dall. All rights reserved.
//

import UIKit

class MainCoordinator: NSObject, Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
    }

    func start() {
        let vc = SearchImageViewController.loadNib()
        vc.title = "SKUAD"
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func fullImage(viewModel: SearchImagesViewModel, index : Int) {
        let vc = ImageDetailsViewController.loadNib()
        vc.viewModel = viewModel
        vc.selectedImage = index
        navigationController.pushViewController(vc, animated: false)
    }
}


