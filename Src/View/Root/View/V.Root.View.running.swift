//
//  V.Root.View.running.swift
//  Main
//
//  Created by Maxim Khatskevich on 5/8/17.
//
//

import UIKit

//===

extension V_Root_View
{
    static
    func running() -> St
    {
        return state {
            
            $0.status.text = "Status: RUNNING"
        }
    }
    
    //===
    
    func update(with op: M.Intersection.Operating)
    {
        // actualize displayed data
        
        timer.text = String(format: "%.0f", op.timeLeft)
        
        //===
        
        func image(for tl: M.TrafficLight) -> UIImage?
        {
            switch tl
            {
                case .green:
                    return R.image.green()
                
                case .yellow:
                    return R.image.yellow()
                    
                case .red:
                    return R.image.red()
            }
        }
        
        //===
        
        tlNS1.image = image(for: op.northSouth)
        tlNS2.image = image(for: op.northSouth)
        tlEW1.image = image(for: op.eastWest)
        tlEW2.image = image(for: op.eastWest)
    }
}
