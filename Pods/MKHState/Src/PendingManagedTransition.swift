//
//  PendingManagedTransition.swift
//  MKHState
//
//  Created by Maxim Khatskevich on 2/11/17.
//  Copyright © 2017 Maxim Khatskevich. All rights reserved.
//

import Foundation

//===

public
struct PendingManagedTransition<Target: AnyObject>
{
    let state: StateCtrl<Target>
    
    let defaultTransition: Transition<Target>?
    
    let getState: (_: Target.Type) -> State<Target>
}

//===

public
extension PendingManagedTransition
{
    @discardableResult
    func instantly() -> StateCtrl<Target>
    {
        if
            state.isReadyForTransition
        {
            state.process(getState,
                          via: nil,
                          completion: nil)
        }
        else
        {
            state
                .queue
                .append((getState, nil, nil))
        }
        
        //===
        
        return state
    }
    
    @discardableResult
    func viaTransition(
        _ completion: Completion? = nil
        ) -> StateCtrl<Target>
    {
        if
            state.isReadyForTransition
        {
            state.process(getState,
                          via: defaultTransition,
                          completion: completion)
        }
        else
        {
            state
                .queue
                .append((getState, defaultTransition, completion))
        }
        
        //===
        
        return state
    }
    
    @discardableResult
    func via(
        _ transition: @escaping Transition<Target>,
        _ completion: Completion? = nil
        ) -> StateCtrl<Target>
    {
        if
            state.isReadyForTransition
        {
            state.process(getState,
                          via: transition,
                          completion: completion)
        }
        else
        {
            state
                .queue
                .append((getState, transition, completion))
        }
        
        //===
        
        return state
    }
}
