//
//  V.Root.View.IBSupport.swift
//  Main
//
//  Created by Maxim Khatskevich on 5/8/17.
//
//

import Foundation

//===

@IBDesignable
extension V_Root_View
{
    override
    func prepareForInterfaceBuilder()
    {
        state
            .apply{ $0.initialized() }.instantly()
            .apply{ $0.awaiting() }.instantly()
    }
}
