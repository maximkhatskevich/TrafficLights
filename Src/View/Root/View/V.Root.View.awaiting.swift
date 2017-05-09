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
            
            $0.status.text = "Awaiting"
        }
    }
}
