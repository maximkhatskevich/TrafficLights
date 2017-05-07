//
//  M.Intersection.swift
//  Main
//
//  Created by Maxim Khatskevich on 5/8/17.
//
//

import Foundation

import XCEUniFlow

//===

extension M
{
    struct Intersection: Feature
    {
        // supposed to be a 2 road intersection
        // oriented North-South and East-West
        
        //===
        
        struct Ready: SimpleState { typealias UFLFeature = Intersection
            
        }
        
        //===
        
        struct Operating: FeatureState { typealias UFLFeature = Intersection
            
            var northSouth: TrafficLight
            
            var eastWest: TrafficLight
        }
    }
}

//=== Actions

extension M.Intersection
{
    // setup() // nil -> Ready
    // start() // Ready -> Operating
    // stop()  // Operating -> Ready
}
