//
//  Utils.swift
//  MKHState
//
//  Created by Maxim Khatskevich on 1/17/17.
//  Copyright © 2017 Maxim Khatskevich. All rights reserved.
//

import Foundation

//===

enum Utils
{
    static
    func apply<Target: AnyObject>(
        _ state: State<Target>,
        on target: Target,
        via transition: Transition<Target>? = nil,
        completion: Completion? = nil
        )
    {
        let mutation = { state.mutation(target) }
        
        let completion = completion ?? { _ in }
        
        let transition = transition ?? { $1(); $2(true) }
        
        //===
        
        // actually apply state mutation now:
        
        transition(target, mutation, completion)
    }
}
