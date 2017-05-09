//
//  Tst.M.Intersection.swift
//  Tests
//

import XCTest

@testable
import TrafficLights

import XCEUniFlow
import XCETesting

//===

class Tst_M_Intersection: XCTestCase
{
    var dispatcher: Dispatcher!
    var proxy: DispatcherProxy!
    
    let params = M.Intersection.Params(
        tick: 0.5.seconds,
        yellow: 2.0.seconds,
        change: 4.0.seconds
    )
    
    //===
    
    override
    func setUp()
    {
        super.setUp()
        
        //===
        
        dispatcher = Dispatcher()
        proxy = dispatcher.proxy
    }
    
    override
    func tearDown()
    {
        proxy = nil
        dispatcher = nil
        
        //===
        
        super.tearDown()
    }
    
    func testSetup()
    {
        let expect = expectation(
            description: "Intersection.setup transition")
        
        //===
        
        proxy
            .submit{ M.Intersection.setup() }
        
        proxy
            .subscribeLater(self)
            .onUpdate { m in
                
                RXC.isNotNil("Intersection IS in Ready state") {
                    
                    m ==> M.Intersection.Ready.self
                }
                
                //===
                
                self.proxy.unsubscribe(self)
                expect.fulfill()
            }
        
        //===
        
        waitForExpectations(timeout: 3.0)
    }
    
    func testHappyPath()
    {
        let isReady = expectation(
            description: "Intersection IS in Ready state"
        )
        
        let isOperating = expectation(
            description: "Intersection IS in Operating state"
        )
        
        let initialLights = expectation(
            description: "Start with North-South green and East-West red"
        )
        
        var initialized = false
        
        let isGreenNorthSouth = expectation(
            description: "North-South is green and red East-West"
        )
        
        let isYellowNorthSouth = expectation(
            description: "North-South is yellow"
        )
        
        let isGreenEastWest = expectation(
            description: "North-South is red and green East-West"
        )
        
        let isYellowEastWest = expectation(
            description: "East-West is yellow"
        )
        
        //===
        
        proxy
            .submit{ M.Intersection.setup() }
        
        proxy
            .submit{ M.Intersection.start(with: self.params) }
        
        //===
        
        proxy
            .subscribeLater(self)
            .onUpdate { m in
                
                if
                    let _ = m ==> M.Intersection.Ready.self
                {
                    isReady.fulfill()
                }
                
                //===
                
                if
                    !initialized,
                    let op = m ==> M.Intersection.Operating.self
                {
                    initialized = true
                    
                    //===
                    
                    isOperating.fulfill()
                    
                    //===
                    
                    if
                        (op.northSouth == .green) &&
                        (op.eastWest == .red) &&
                        (op.timeLeft == self.params.change)
                    {
                        initialLights.fulfill()
                    }
                }
                
                //===
                
                if
                    let op = m ==> M.Intersection.Operating.self
                {
                    if
                        (op.northSouth == .green) &&
                        (op.eastWest == .red) &&
                        (op.timeLeft == self.params.change)
                    {
                        isGreenNorthSouth.fulfill()
                    }
                    
                    //===
                    
                    if
                        (op.northSouth == .yellow) &&
                        (op.timeLeft == self.params.green)
                    {
                        isYellowNorthSouth.fulfill()
                    }
                    
                    //===
                    
                    if
                        (op.northSouth == .red) &&
                        (op.eastWest == .green) &&
                        (op.timeLeft == self.params.change)
                    {
                        isGreenEastWest.fulfill()
                    }
                    
                    //===
                    
                    if
                        (op.eastWest == .yellow) &&
                        (op.timeLeft == self.params.green)
                    {
                        isYellowEastWest.fulfill()
                    }
                }
            }
        
        //===
        
        waitForExpectations(timeout: self.params.cycle + 1.0)
    }
}
