//
//  M.Intersection.swift
//  Main
//
//  Created by Maxim Khatskevich on 5/8/17.
//
//

import Foundation

import XCEUniFlow
import XCERequirement
import SwiftyTimer

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
            
            var tick: Timer
            
            var timeLeft: TimeInterval = 0.0 // until switch red <-> green
            
            var northSouth: TrafficLight
            
            var eastWest: TrafficLight
        }
    }
}

//===

extension M.Intersection
{
    enum Params // scope
    {
        static
        let tick = 1.0.second
        
        static
        var green: TimeInterval { return change - yellow }
        
        static
        let yellow = 5.0.seconds
        
        static
        let change = 30.0.seconds
    }
}

//=== Actions

extension M.Intersection
{
    static
    func setup() -> Action
    {
        return initialization(into: Ready.self)
    }
    
    static
    func start() -> Action
    {
        return transition(from: Ready.self, into: Operating.self) { _, become, next in
            
            // let's start with North-South green and East-West red
            
            //===
            
            become{
                
                Operating(
                    tick: Timer.every(Params.tick) { next{ tick() } },
                    timeLeft: Params.change,
                    northSouth: .green,
                    eastWest: .red
                )
            }
            
            //===
            
            Timer.after(Params.green) { next { yellowNorthSouth() } }
        }
    }
    
    static
    func tick() -> Action
    {
        return actualization(of: Operating.self) { op, mutate, _ in
            
            let delta = min(Params.tick, op.timeLeft)
            
            //===
            
            mutate{ $0.timeLeft -= delta }
        }
    }
    
    static
    func greenNorthSouth() -> Action // and red East-West
    {
        return actualization(of: Operating.self) { op, mutate, next in
            
            try REQ.isTrue("North-South is red") { op.northSouth == .red }
            
            try REQ.isTrue("East-West is yellow") { op.eastWest == .yellow }
            
            //===
            
            mutate {
                
                $0.northSouth = .green
                $0.eastWest = .red
            }
            
            //===
            
            Timer.after(Params.green) { next { yellowNorthSouth() } }
        }
    }
    
    static
    func yellowNorthSouth() -> Action
    {
        return actualization(of: Operating.self) { op, mutate, next in
            
            try REQ.isTrue("North-South is green") { op.northSouth == .green }
            
            //===
            
            mutate { $0.northSouth = .yellow }
            
            //===
            
            Timer.after(Params.yellow) { next { greenEastWest() } }
        }
    }
    
    static
    func greenEastWest() -> Action // and red North-South
    {
        return actualization(of: Operating.self) { op, mutate, next in
            
            try REQ.isTrue("North-South is yellow") { op.northSouth == .yellow }
            
            try REQ.isTrue("East-West is red") { op.eastWest == .red }
            
            //===
            
            mutate {
                
                $0.northSouth = .red
                $0.eastWest = .green
            }
            
            //===
            
            Timer.after(Params.green) { next { yellowEastWest() } }
        }
    }
    
    static
    func yellowEastWest() -> Action
    {
        return actualization(of: Operating.self) { op, mutate, next in
            
            try REQ.isTrue("East-West is green") { op.eastWest == .green }
            
            //===
            
            mutate { $0.eastWest = .yellow }
            
            //===
            
            Timer.after(Params.yellow) { next { greenNorthSouth() } }
        }
    }
    
    static
    func stop() -> Action
    {
        return transition(from: Operating.self, into: Ready.self) { op, become, _ in
            
            op.tick.invalidate()
            
            //===
            
            become{ Ready() }
        }
    }
}
