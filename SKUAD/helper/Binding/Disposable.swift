//
//  Disposable.swift
//  SignInWithAppleDemo
//
//  Created by Virender Dall on 30/10/20.
//  Copyright © 2020 Developer Insider. All rights reserved.
//

import Foundation

class Disposable {
    let dispose: () -> Void
    init(_ dispose: @escaping () -> Void) { self.dispose = dispose }
    deinit { dispose() }
}

extension Disposable {
    func disposed(by bag: DisposeBag?) {
        bag?.append(self)
    }
}
