//
//  Tst.M.Core.swift
//  Main
//
//  Created by Maxim Khatskevich on 5/9/17.
//
//

import XCTest

@testable
import TrafficLights

import XCEUniFlow
import XCETesting

//===

class Tst_M_Core: XCTestCase
{
    var dispatcher: Dispatcher!
    var proxy: DispatcherProxy!
    
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
        let expect = expectation(description: "Core.setup transition")
        
        //===
        
        proxy
            .submit{ M.Core.setup() }
        
        proxy
            .subscribeLater(self)
            .onUpdate { m in
                
                RXC.isNotNil("Core IS in Ready state") {
                    
                    m ==> M.Core.Ready.self
                }
                
                //===
                
                self.proxy.unsubscribe(self)
                expect.fulfill()
            }
        
        //===
        
        waitForExpectations(timeout: 3.0)
    }
}
