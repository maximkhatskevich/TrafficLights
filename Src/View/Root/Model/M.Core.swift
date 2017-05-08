//
//  M.Core.swift
//  Main
//
//  Created by Maxim Khatskevich on 5/7/17.
//
//

import Foundation

import XCEUniFlow

//===

extension M
{
    enum Core: Feature
    {
        struct Ready: SimpleState { typealias UFLFeature = Core
            
        }
    }
}

//===

extension M.Core
{
    static
    func setup() -> Action
    {
        return initialization(into: Ready.self) { next in
            
//            next{ M.Intersection.setup() }
        }
    }
}
