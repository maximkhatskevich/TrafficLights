//
//  V.Root.View.running.swift
//  Main
//
//  Created by Maxim Khatskevich on 5/8/17.
//
//

import Foundation

//===

extension V_Root_View
{
    static
    func running() -> St
    {
        return state {
            
            $0.status.text = "Running"
        }
    }
    
    //===
    
    func update(with m: M.Intersection.Operating)
    {
        // actualize displayed data
    }
}
