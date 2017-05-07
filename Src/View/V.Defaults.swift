//
//  V.Defaults.swift
//  Main
//
//  Created by Maxim Khatskevich on 5/7/17.
//
//

import Foundation

import MKHState

//===

extension V
{
    enum Default
    {
        static
        let anim: GenericTransition = {
            
            UIView.animate(withDuration: 1.0,
                           animations: $0,
                           completion: $1)
        }

        static
        func viewAnim<View: UIView>() -> Transition<View>
        {
            return { (v, m, c) in
                
                v.alpha = 0.0
                
                //===
                
                m()
                
                //===
                
                V.Default.anim({ v.alpha = 1.0 }, c)
            }
        }
    }
}
