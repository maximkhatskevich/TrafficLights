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
                
                $0.intr.sv(
                    $0.timer,
                    $0.tlNS1,
                    $0.tlNS2,
                    $0.tlEW1,
                    $0.tlEW2
                ),
                $0.status,
                $0.toggle
            )
            
            //===
            
            // layout
            
            $0.intr
                .size(320)
                .centerInContainer()
            
            $0.timer
                .size(80)
                .centerInContainer()
            
            $0.tlNS1
                .size(80)
                .centerHorizontally()
                .top(0)
            
            $0.tlNS2
                .size(80)
                .centerHorizontally()
                .bottom(0)
            
            $0.tlEW1
                .size(80)
                .centerVertically()
                .left(0)
            
            $0.tlEW2
                .size(80)
                .centerVertically()
                .right(0)
            
            $0.layout(
            
                "",
                
                |-$0.status-""-$0.toggle.width(180)-| ~ 80,
                
                20
            )
            
            //===
            
            // configure UI controls
            
            $0.timer.textAlignment = .center
            $0.timer.font = UIFont.systemFont(ofSize: 40)
            
            $0.intr.image = R.image.intersection()
            
            $0.tlNS1.contentMode = .scaleAspectFit
            $0.tlNS2.contentMode = .scaleAspectFit
            $0.tlEW1.contentMode = .scaleAspectFit
            $0.tlEW2.contentMode = .scaleAspectFit
            
            $0.toggle.text("Start/Stop")
            $0.toggle.setTitleColor(.black, for: .normal)
        }
    }
}
