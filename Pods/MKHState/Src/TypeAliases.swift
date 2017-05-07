//
//  TypeAliases.swift
//  MKHState
//
//  Created by Maxim Khatskevich on 1/17/17.
//  Copyright © 2017 Maxim Khatskevich. All rights reserved.
//

import Foundation

//===

public
typealias StateGetter<Target: AnyObject> = (_: Target.Type) -> State<Target>

//===

public
typealias Completion = (_ finished: Bool) -> Void

//===

public
typealias GenericTransition =
    (
    _ mutation: @escaping () -> Void,
    _ completion: @escaping  Completion
    ) -> Void

//===

public
typealias Transition<Target: AnyObject> =
    (
    _ target: Target,
    _ mutation: @escaping () -> Void,
    _ completion: @escaping Completion
    ) -> Void
