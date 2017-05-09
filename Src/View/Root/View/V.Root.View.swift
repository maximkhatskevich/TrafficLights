//
//  V.Dashboard.View.swift
//  Main
//
//  Created by Maxim Khatskevich on 5/1/17.
//
//

import Foundation

import XCEUniFlow
import MKHState

//===

final
class V_Root_View: UIView, DispatcherInitializable
{
    let status = UILabel()
    
    let toggle = UIButton(type: .custom)
    
    //===
    
    lazy
    var state: StateCtrl<V_Root_View> =
        StateCtrl(for: self, V.Default.viewAnim())
    
    //===
    
    private(set)
    var proxy: DispatcherProxy?
    
    //===
    
    required
    convenience
    init(with proxy: DispatcherProxy)
    {
        self.init(frame: CGRect.zero)
        
        //===
        
        self.proxy = proxy
        
        //===
        
        state
            .apply{ $0.initialized() }.instantly()
            .apply{ $0.binded() }.instantly()

        //===
        
        proxy
            .subscribe(self)
            .onUpdate(configure)
    }
}

//=== MARK: UniFlow

extension V_Root_View
{
    func configure(m: GlobalModel)
    {
        switch m ==> M.Intersection.self
        {
            case is M.Intersection.Ready:
                state.apply{ $0.awaiting() }.viaTransition()
            
            case let op as M.Intersection.Operating:
                state.apply{ $0.running() }.viaTransition()
                update(with: op)
            
            default:
                break
        }
    }
}

//=== MARK: States

extension V_Root_View: DiscreteSystem
{
    typealias St = State<V_Root_View>
}
