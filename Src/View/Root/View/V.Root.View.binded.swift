//
//  V.Root.View.binded.swift
//  Main
//
//  Created by Maxim Khatskevich on 5/7/17.
//
//

import Foundation

import MKHViewEvents

//===

extension V_Root_View
{
    static
    func binded() -> St
    {
        return state {
            
             $0.toggle
               .onTap(#selector(toggleHandler), at: $0)
        }
    }
    
    //===
    
    @objc
    func toggleHandler()
    {
        proxy?.submit{ M.Intersection.toggle() }
    }
}
