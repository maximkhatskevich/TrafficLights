//
//  V.Root.View.awaiting.swift
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
    func awaiting() -> St
    {
        return state {
            
            $0.timer.text = ""
            
            $0.tlNS1.image = nil
            $0.tlNS2.image = nil
            $0.tlEW1.image = nil
            $0.tlEW2.image = nil
            
            $0.status.text = "Status: awaiting"
        }
    }
}
