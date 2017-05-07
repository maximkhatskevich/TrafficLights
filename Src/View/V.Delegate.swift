//
//  V.Delegate.swift
//  Main
//
//  Created by Maxim Khatskevich on 5/7/17.
//
//

import Foundation

import XCEUniFlow
import MKHState

//===

extension V
{
    @UIApplicationMain
    class Delegate: UIResponder
    {
        var window: UIWindow? // req. by UIApplicationDelegate
        
        //===
        
        let dispatcher = Dispatcher()
    }
}

//===

extension V.Delegate: DiscreteSystem
{
    static
    func initialized() -> State<V.Delegate>
    {
        return state {
            
            $0.window = V.Window(with: $0.dispatcher.proxy)
            
            //===
            
            $0.dispatcher.enableDefaultReporting()
            $0.dispatcher.submit(M.Core.setup)
        }
    }
}
