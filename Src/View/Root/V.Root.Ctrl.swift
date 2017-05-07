//
//  ViewController.swift
//  Traffic Lights
//

import UIKit

import XCEUniFlow

//===

extension V.Root
{
    final
    class Ctrl: UIViewController, DispatcherInitializable
    {
        private(set)
        var proxy: DispatcherProxy!
        
        //===
        
        required
        convenience
        init(with p: DispatcherProxy)
        {
            self.init(nibName: nil, bundle: nil)
            
            //==
            
            proxy = p
        }
    }
}

//=== MARK: Overrided

extension V.Root.Ctrl
{
    override
    func loadView()
    {
        view = V_Root_View(with: proxy)
    }
}
