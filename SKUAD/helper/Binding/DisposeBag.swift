//
//  DisposeBag.swift
//  SignInWithAppleDemo
//
//  Created by Virender Dall on 30/10/20.
//  Copyright © 2020 Developer Insider. All rights reserved.
//

import Foundation

class DisposeBag {
    private var disposables: [Disposable] = []
    func append(_ disposable: Disposable) { disposables.append(disposable) }
}
