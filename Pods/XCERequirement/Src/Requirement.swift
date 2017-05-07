//
//  Requirement.swift
//  MKHRequirement
//
//  Created by Maxim Khatskevich on 12/19/16.
//  Copyright © 2016 Maxim Khatskevich. All rights reserved.
//

import Foundation

//===

public
struct Requirement<Input>
{
    public
    let title: String
    
    let body: RequirementBody<Input>
    
    //===
    
    public
    init(_ title: String, _ body: @escaping RequirementBody<Input>)
    {
        self.title = title
        self.body = body
    }
}

//===

public
extension Requirement
{
    init()
    {
        self.init("Accept anything") { _ in return true }
    }
}

//===

public
extension Requirement
{
    func isFulfilled(with input: Input) -> Bool
    {
        return body(input)
    }
    
    func check(with input: Input) throws
    {
        if
            !body(input)
        {
            throw RequirementNotFulfilled(title, input: input)
        }
    }
}
