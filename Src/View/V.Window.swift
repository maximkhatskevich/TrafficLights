//
//  V.Window.swift
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
    final
    class Window: UIWindow, DispatcherInitializable
    {
        required
        convenience
        init(with proxy: DispatcherProxy)
        {
            self.init(frame: UIScreen.main.bounds)
            
            //===
            
            become{ $0.initialized(with: proxy) }.instantly()
        }
    }
}

//===

extension V.Window: DiscreteSystem { }

//===

fileprivate
extension V.Window
{
    static
        func initialized(with proxy: DispatcherProxy) -> State<V.Window>
    {
        return state {
            
            $0.backgroundColor = .white
            $0.rootViewController = V.Root.Ctrl(with: proxy)
            $0.makeKeyAndVisible()
        }
    }
}
