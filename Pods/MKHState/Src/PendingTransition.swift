//
//  PendingTransition.swift
//  MKHState
//
//  Created by Maxim Khatskevich on 2/11/17.
//  Copyright © 2017 Maxim Khatskevich. All rights reserved.
//

import Foundation

//===

public
struct PendingTransition<Target: AnyObject>
{
    let target: Target
    
    let getState: (_: Target.Type) -> State<Target>
}

//===

public
extension PendingTransition
{
    @discardableResult
    func instantly() -> Target
    {
        Utils
            .apply(getState(type(of: target)),
                   on: target,
                   via: nil,
                   completion: nil)
        
        //===
        
        return target
    }
    
    @discardableResult
    func via(
        _ transition: @escaping Transition<Target>,
        _ completion: Completion? = nil
        ) -> Target
    {
        Utils
            .apply(getState(type(of: target)),
                   on: target,
                   via: transition,
                   completion: completion)
        
        //===
        
        return target
    }
}
