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
    let timer = UILabel() // display time left
    
    let intr = UIImageView() // intersection background image
    
    // traffic lights:
    let tlNS1 = UIImageView()
    let tlNS2 = UIImageView()
    let tlEW1 = UIImageView()
    let tlEW2 = UIImageView()
    
    let status = UILabel() // current status of animation
    
    let toggle = UIButton(type: .custom) // start/stop button
    
    //===
    
    lazy
    var state: StateCtrl<V_Root_View> =
        StateCtrl(for: self, V_Root_View.anim())
    
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
    
    //===
    
    static
    func anim() -> Transition<V_Root_View>
    {
        return { (v, m, c) in
            
            v.status.alpha = 0.0
            
            //===
            
            m()
            
            //===
            
            V.Default.anim({ v.status.alpha = 1.0 }, c)
        }
    }
}
