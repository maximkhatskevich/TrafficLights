//
//  Typealiases.swift
//  MKHRequirement
//
//  Created by Maxim Khatskevich on 3/10/17.
//  Copyright © 2017 Maxim Khatskevich. All rights reserved.
//

import Foundation

//===

public
typealias RequirementBody<Input> = (_ input: Input) -> Bool

//===

public
typealias Require<Input> = Requirement<Input>
