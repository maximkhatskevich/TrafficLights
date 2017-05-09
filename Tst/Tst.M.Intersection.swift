//
//  Tst.M.Intersection.swift
//  Tests
//

import XCTest

@testable
import TrafficLights

@testable
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
        RXC.isNil("M.Intersection is NOT presented in GlobalModel yet") {
            
            self.dispatcher.model ==> M.Intersection.self
        }
        
        //===
        
        dispatcher.process(M.Intersection.setup())
        
        //===
        
        RXC.isNotNil("M.Intersection is in Ready state") {
            
            self.dispatcher.model ==> M.Intersection.Ready.self
        }
    }
    
    func testStart()
    {
        dispatcher.model <== M.Intersection.Ready()
        
        //===
        
        dispatcher.process(M.Intersection.start(with: params))
        
        //===
        
        let op = RXC.value("M.Intersection is in Operating state") {
            
            self.dispatcher.model ==> M.Intersection.Operating.self
        }
        
        RXC.isTrue("Operating state initial properties are coorect") {
            
            (op?.timeLeft == self.params.change) &&
            (op?.northSouth == .green) &&
            (op?.eastWest == .red)
        }
    }
    
    func testTick()
    {
        let randomTimeLeft = 184.92.seconds
        
        //===
        
        dispatcher.model <== M.Intersection.Operating(
            params: params,
            tick: Timer.new(after: 100, {}),
            timeLeft: randomTimeLeft + params.tick,
            northSouth: .green,
            eastWest: .red
        )
        
        //===
        
        dispatcher.process(M.Intersection.tick())
        
        //===
        
        let op = dispatcher.model ==> M.Intersection.Operating.self
        
        RXC.isTrue("Operating state updated time left is correct") {
            
            op?.timeLeft == randomTimeLeft
        }
    }
    
    func testGreenNorthSouth()
    {
        dispatcher.model <== M.Intersection.Operating(
            params: params,
            tick: Timer.new(after: 100, {}),
            timeLeft: 0,
            northSouth: .red,
            eastWest: .yellow
        )
        
        //===
        
        dispatcher.process(M.Intersection.greenNorthSouth())
        
        //===
        
        let op = RXC.value("M.Intersection is in Operating state") {
            
            self.dispatcher.model ==> M.Intersection.Operating.self
        }
        
        RXC.isTrue("Operating state updated properties are coorect") {
            
            (op?.timeLeft == self.params.change) &&
            (op?.northSouth == .green) &&
            (op?.eastWest == .red)
        }
    }
    
    func testYellowNorthSouth()
    {
        dispatcher.model <== M.Intersection.Operating(
            params: params,
            tick: Timer.new(after: 100, {}),
            timeLeft: self.params.green,
            northSouth: .green,
            eastWest: .red
        )
        
        //===
        
        dispatcher.process(M.Intersection.yellowNorthSouth())
        
        //===
        
        let op = RXC.value("M.Intersection is in Operating state") {
            
            self.dispatcher.model ==> M.Intersection.Operating.self
        }
        
        RXC.isTrue("Operating state updated properties are coorect") {
            
            (op?.timeLeft == self.params.green) &&
            (op?.northSouth == .yellow)
        }
    }
    
    func testGreenEastWest()
    {
        dispatcher.model <== M.Intersection.Operating(
            params: params,
            tick: Timer.new(after: 100, {}),
            timeLeft: 0,
            northSouth: .yellow,
            eastWest: .red
        )
        
        //===
        
        dispatcher.process(M.Intersection.greenEastWest())
        
        //===
        
        let op = RXC.value("M.Intersection is in Operating state") {
            
            self.dispatcher.model ==> M.Intersection.Operating.self
        }
        
        RXC.isTrue("Operating state updated properties are coorect") {
            
            (op?.timeLeft == self.params.change) &&
            (op?.northSouth == .red) &&
            (op?.eastWest == .green)
        }
    }
    
    func testYellowEastWest()
    {
        dispatcher.model <== M.Intersection.Operating(
            params: params,
            tick: Timer.new(after: 100, {}),
            timeLeft: self.params.green,
            northSouth: .red,
            eastWest: .green
        )
        
        //===
        
        dispatcher.process(M.Intersection.yellowEastWest())
        
        //===
        
        let op = RXC.value("M.Intersection is in Operating state") {
            
            self.dispatcher.model ==> M.Intersection.Operating.self
        }
        
        RXC.isTrue("Operating state updated properties are coorect") {
            
            (op?.timeLeft == self.params.green) &&
            (op?.eastWest == .yellow)
        }
    }
    
    func testStop()
    {
        dispatcher.model <== M.Intersection.Operating(
            params: params,
            tick: Timer.new(after: 100, {}),
            timeLeft: 3.54.seconds, // random value
            northSouth: .yellow, // random value
            eastWest: .yellow    // random value
        )
        
        // NOTE: We set incorrect combination of
        // current traffic lights states, because
        // the 'stop' transition must not check them
        // or depend on them at all.
        
        //===
        
        dispatcher.process(M.Intersection.stop())
        
        //===
        
        RXC.isNotNil("M.Intersection is in Ready state") {
            
            self.dispatcher.model ==> M.Intersection.Ready.self
        }
    }
    
    func testToggleStart()
    {
        dispatcher.model <== M.Intersection.Ready()
        
        //===
        
        let hasStarted = expectation(
            description: "Intersection is in Operating state now"
        )
        
        //===
        
        dispatcher.process(M.Intersection.toggle(with: params))
        
        //===
        
        proxy
            .subscribeLater(self)
            .onUpdate { m in
                
                if
                    let _ = m ==> M.Intersection.Operating.self
                {
                    hasStarted.fulfill()
                }
            }
        
        //===
        
        waitForExpectations(timeout: 1.0)
    }
    
    func testToggleStop()
    {
        dispatcher.model <== M.Intersection.Operating(
            params: params,
            tick: Timer.new(after: 100, {}),
            timeLeft: 3.54.seconds, // random value
            northSouth: .yellow, // random value
            eastWest: .yellow    // random value
        )
        
        // NOTE: We set incorrect combination of
        // current traffic lights states, because
        // the 'stop' transition must not check them
        // or depend on them at all.
        
        //===
        
        let hasStopped = expectation(
            description: "Intersection is in Ready state now"
        )
        
        //===
        
        dispatcher.process(M.Intersection.toggle())
        
        //===
        
        proxy
            .subscribeLater(self)
            .onUpdate { m in
                
                if
                    let _ = m ==> M.Intersection.Ready.self
                {
                    hasStopped.fulfill()
                }
        }
        
        //===
        
        waitForExpectations(timeout: 1.0)
    }
    
    func testHappyPath()
    {
        dispatcher.process(M.Intersection.setup())
        
        //===
        
        RXC.isNotNil("M.Intersection is in Ready state now") {
            
            self.dispatcher.model ==> M.Intersection.Ready.self
        }
        
        //===
        
        dispatcher.process(M.Intersection.start(with: self.params))
        
        //===
        
        RXC.isTrue("Operating state initial properties are correct") {
            
            let op = RXC.value("M.Intersection is in Operating state") {
                
                self.dispatcher.model ==> M.Intersection.Operating.self
            }
            
            //===
        
            return
                (op?.timeLeft == self.params.change) &&
                (op?.northSouth == .green) &&
                (op?.eastWest == .red)
        }
        
        //===
        
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
        
        func prepare(m: GlobalModel) -> M.Intersection.Operating?
        {
            return m ==> M.Intersection.Operating.self
        }
        
        //===
        
        proxy
            .subscribeLater(self)
            .onConvert(prepare)
            .onUpdate { op in
                
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
        
        //===
        
        waitForExpectations(timeout: self.params.cycle + 1.0)
    }
}
