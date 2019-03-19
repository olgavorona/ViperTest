//
//  DispatchHelper.swift
//  VIPERTest
//
//  Created by Olga Vorona on 19/03/2019.
//  Copyright © 2019 Olga Vorona. All rights reserved.
//

import Foundation

class DispatchHelper {
    
    typealias CancelableBlock = (Bool) -> Void
    
    @discardableResult
    class func dispathAfterDelay(_ delay: Float, dispatchBlock: (() -> Void)?) -> CancelableBlock? {
        guard let block = dispatchBlock else { return nil }
        
        var cancelableBlock: CancelableBlock? = nil
        var originalBlock: (() -> Void)? = block
        
        let delayBlock: CancelableBlock = { cancel in
            if cancel == false && originalBlock != nil {
                DispatchQueue.main.async(execute: originalBlock!)
            }
            originalBlock = nil
            cancelableBlock = nil
        }
        
        cancelableBlock = delayBlock
        
        let delayTime = DispatchTime.now() + Double(Int64(delay * Float(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: delayTime) {
            if cancelableBlock != nil {
                cancelableBlock!(false)
            }
        }
        
        return cancelableBlock
    }
    
    class func dispatchCancelBlock(_ block: CancelableBlock?) {
        if block != nil {
            block!(true)
        }
    }
}
