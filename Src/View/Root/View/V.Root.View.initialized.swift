//
//  V.Root.View.initialized.swift
//  Main
//
//  Created by Maxim Khatskevich on 5/7/17.
//
//

import Foundation

import Stevia

//===

extension V_Root_View
{
    static
    func initialized() -> St
    {
        return state {
            
            // $0.translatesAutoresizingMaskIntoConstraints = false
            
            //===
            
            // hierarchy
            
            $0.sv(
                
                $0.status,
                $0.toggle
            )
            
            //===
            
            // layout
            
            $0.layout(
            
                100,
                |-$0.status-| ~ 80,
                8,
                |-$0.toggle-| ~ 80,
                ""
            )
            
            //===
            
            // configure UI controls
            
            $0.toggle.text("Start/Stop")
            $0.toggle.setTitleColor(.black, for: .normal)
        }
    }
}
