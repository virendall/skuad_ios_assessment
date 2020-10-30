//
//  Storyboarded.swift
//  SKUAD
//
//  Created by Virender Dall on 30/10/20.
//  Copyright © 2020 Virender Dall. All rights reserved.
//

import UIKit

extension UIViewController {
    
    static func loadNib() -> Self {
        let fullName = NSStringFromClass(self)
        
        guard let className = fullName.components(separatedBy: ".").last else {
            fatalError("Class name not found")
        }
        return Self(nibName: className, bundle: nil)
    }
    
    func showAlert(_ title: String? = nil, msg: String?, buttonText: String = "OK") {
        let alert = UIAlertController(
            title: title,
            message: msg,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: buttonText, style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
}
