//
//  Box.swift
//  SignInWithAppleDemo
//
//  Created by Virender Dall on 30/10/20.
//  Copyright © 2020 Developer Insider. All rights reserved.
//

import Foundation

class Box<T> {
    typealias Listener = (T) -> Void
    
    // Replace your array with a dictionary mapping
    // I also made the Observer method mandatory. I don't believe it makes
    // sense for it to be optional. I also made it private.
    private  var listeners: [UUID:  Listener] = [:]
    
    var value: T {
        didSet {
            notifyListeners()
        }
    }
    
    init(_ value: T){
        self.value = value
    }
    
    func notifyListeners(){
        listeners.values.forEach { $0(value) }
    }
    
    // Now return a Disposable. You'll get a warning if you fail
    // to retain it (and it will immediately be destroyed)
    func bind(listener: @escaping Listener) -> Disposable {
        
        // UUID is a nice way to create a unique identifier; that's what it's for
        let identifier = UUID()
        
        self.listeners[identifier] = listener
        
        listener(value)
        
        // And create a Disposable to clean it up later. The Disposable
        // doesn't have to know anything about T.
        // Note that Disposable has a strong referene to the Box
        // This means the Box can't go away until the last observer has been removed
        return Disposable { self.listeners.removeValue(forKey: identifier) }
    }
    
    deinit {
        print("I am going nil now")
    }
}
