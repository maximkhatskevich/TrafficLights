//
//  StateCtrl.swift
//  MKHState
//
//  Created by Maxim Khatskevich on 12/25/16.
//  Copyright © 2016 Maxim Khatskevich. All rights reserved.
//

import Foundation

//===

public
final
class StateCtrl<Target: AnyObject>
{
    weak
    var target: Target?
    
    var queue: [(StateGetter<Target>, Transition<Target>?, Completion?)] = []
    
    //===
    
    public fileprivate(set)
    var current: State<Target>? = nil
    
    public fileprivate(set)
    var next: State<Target>? = nil
    
    //===
    
    public
    var defaultTransition: Transition<Target>? = nil
    
    public
    var isReadyForTransition: Bool { return next == nil }
    
    //===
    
    public
    init(for view: Target,
         _ defaultTransition: Transition<Target>? = nil)
    {
        self.target = view
        self.defaultTransition = defaultTransition
    }
}

//=== MARK: Internal members

extension StateCtrl
{
    func process(
        _ getState: (_: Target.Type) -> State<Target>,
        via transition: Transition<Target>? = nil,
        completion: Completion? = nil
        )
    {
        guard
            let target = target
        else
        {
            return
        }
        
        //===
        
        let newState = getState(Target.self)
        
        //===
        
        guard
            current != newState
        else
        {
            return // just return without doing anything
        }
        
        //===
        
        guard
            next.map({ $0 != newState }) ?? true
        else
        {
            return // just return without doing anything
        }
        
        //===
        
        /*
         
         Q: What we've checked so far?
         
         A: If we are already in the target state,
         or if we are currently transitioning into that state, then
         no need to do anything at all, and no need to throw an exception.
         
         */
        
        //===
        
        next = newState
        
        //===
        
        Utils
            .apply(
                newState,
                on: target,
                via: transition,
                completion: {
                    
                    if
                        $0 // transition finished?
                    {
                        // YES
                        
                        self.current = newState
                        self.next = nil
                        
                        //===
                        
                        completion?($0)
                        
                        //===
                        
                        self.processNext()
                    }
                    else
                    {
                        // NO
                        
                        // most likely transition has been
                        // interupted by applying another state
                        
                        //===
                        
                        completion?($0)
                        
                        //===
                        
                        self.resetQueue()
                    }
                })
    }
    
    func processNext()
    {
        if
            isReadyForTransition,
            queue.count > 0
        {
            let (sG, t, c) = queue.removeFirst()
            
            process(sG, via: t, completion: c)
        }
    }
    
    func resetQueue()
    {
        queue.removeAll()
    }
}

//=== MARK: Apply

public
extension StateCtrl
{
    func apply(
        _ getState: @escaping (_: Target.Type) -> State<Target>
        ) -> PendingManagedTransition<Target>
    {
        return
            PendingManagedTransition(
                state: self,
                defaultTransition: defaultTransition,
                getState: getState)
    }
}
