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
            
            UIView.animate(withDuration: 0.3,
                           animations: $0,
                           completion: $1)
        }
    }
}
