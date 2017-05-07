//
//  Errors.swift
//  MKHRequirement
//
//  Created by Maxim Khatskevich on 12/19/16.
//  Copyright © 2016 Maxim Khatskevich. All rights reserved.
//

import Foundation

//===

public
protocol RequirementIssue: Error {}

//===

public
struct RequirementNotFulfilled: RequirementIssue
{
    public
    let requirement: String
    
    public
    let input: Any
    
    //===
    
    init(_ requirement: String, input: Any)
    {
        self.requirement = requirement
        self.input = input
    }
    
    //===
    
    public
    var localizedDescription: String
    {
        return
            "requirement [ " + requirement +
            " ] is not fulfilled with input <\(input)>"
    }
}

//===

public
struct VerificationFailed: RequirementIssue
{
    public
    let description: String
    
    //===
    
    init(_ description: String)
    {
        self.description = description
    }
    
    //===
    
    public
    var localizedDescription: String
    {
        return "verification [ " + description + " ] failed"
    }
}
