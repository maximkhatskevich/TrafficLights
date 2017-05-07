//
//  Extra.swift
//  MKHRequirement
//
//  Created by Maxim Khatskevich on 12/20/16.
//  Copyright © 2016 Maxim Khatskevich. All rights reserved.
//

public
enum REQ {}

//===

public
extension REQ
{
    static
    func value<Output>(
        _ description: String,
        _ body: () -> Output?
        ) throws -> Output
    {
        guard
            let result = body()
        else
        {
            throw VerificationFailed(description)
        }
        
        //===
        
        return result
    }
    
    static
    func isNotNil(
        _ description: String,
        _ body: () -> Any?
        ) throws
    {
        guard
            body() != nil
        else
        {
            throw VerificationFailed(description)
        }
    }
    
    static
    func isNil(
        _ description: String,
        _ body: () -> Any?
        ) throws
    {
        guard
            body() == nil
        else
        {
            throw VerificationFailed(description)
        }
    }
    
    static
    func isTrue(
        _ description: String,
        _ body: () -> Bool
        ) throws
    {
        guard
            body()
        else
        {
            throw VerificationFailed(description)
        }
    }
}
