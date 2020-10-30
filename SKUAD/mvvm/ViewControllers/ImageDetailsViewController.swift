//
//  ImageDetailsViewController.swift
//  SKUAD
//
//  Created by Virender Dall on 30/10/20.
//  Copyright © 2020 Virender Dall. All rights reserved.
//

import UIKit
import Kingfisher

class ImageDetailsViewController: UIViewController {
    
    private let KCellReuseIdentifier = "ImageCollectionViewCell"
    
    var viewModel: SearchImagesViewModel!
    var selectedImage: Int = 0
    
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    
    @IBOutlet var collectionView: UICollectionView! {
        didSet {
            self.collectionView.register(UINib(nibName: KCellReuseIdentifier, bundle: nil), forCellWithReuseIdentifier: KCellReuseIdentifier)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.collectionView.reloadData()
        self.collectionView.scrollToItem(at: IndexPath(row: selectedImage, section: 0), at: .centeredHorizontally, animated: false)
    }
}

extension ImageDetailsViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.totalImages()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: KCellReuseIdentifier, for: indexPath) as! ImageCollectionViewCell
        let url = self.viewModel.imageURlFor(index: indexPath.row)
        cell.searchImage.kf.setImage(with: url)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        selectedImage = indexPath.row
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
}
