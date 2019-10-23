//
//  Dispatch+helpers.swift
//  iTranslateSample01
//
//  Created by Elwan on 10/22/19.
//  Copyright © 2019 iTranslate. All rights reserved.
//

import Foundation

class Dispatch: NSObject {
    
    /**
     Wrapper around asyncAfter
     
     - parameter time:    The time, in seconds, to delay
     - parameter closure: The closure to call after `delay` has passed
     */
    class func after(_ seconds: Double, closure: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds( Int(seconds * 1000) ), execute: {
            closure()
        })
    }
    
    /**
     Wrapper for dispatching onto the main thread.
     
     - parameter closure: The closure to run on the main thread.
     */
    class func onMainThread(_ closure: @escaping () -> ()) {
        if Thread.isMainThread {
            closure()
            return
        }
        
        DispatchQueue.main.async(execute: {
            closure()
        })
    }
    
}
