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

@testable
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
        RXC.isNil("M.Core is NOT presented in GlobalModel yet") {
            
            self.dispatcher.model ==> M.Core.self
        }
        
        //===
        
        self.dispatcher.process(M.Core.setup())
        
        //===
        
        RXC.isNotNil("M.Core IS presented in GlobalModel now") {
            
            self.dispatcher.model ==> M.Core.self
        }
    }
}
