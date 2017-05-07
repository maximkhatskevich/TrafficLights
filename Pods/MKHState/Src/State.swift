//
//  State.swift
//  MKHState
//
//  Created by Maxim Khatskevich on 12/25/16.
//  Copyright © 2016 Maxim Khatskevich. All rights reserved.
//

import Foundation

//===

public
struct State<Target: AnyObject>
{
    let id: String
    
    let mutation: (_: Target) -> Void
    
    //===
    
    init(
        _ id: String = NSUUID().uuidString,
        _ mutation: @escaping (_: Target) -> Void
        )
    {
        self.id = id
        self.mutation = mutation
    }
}

//=== MARK: Equatable

// https://www.andrewcbancroft.com/2015/07/01/every-swift-value-type-should-be-equatable/

extension State: Equatable { }

public
func ==<LTarget: AnyObject, RTarget: AnyObject>(
    lhs: State<LTarget>,
    rhs: State<RTarget>
    ) -> Bool
{
    return lhs.id == rhs.id
}
