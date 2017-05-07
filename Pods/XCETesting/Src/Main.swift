//
//  Main.swift
//  MKHTesting
//
//  Created by Maxim Khatskevich on 12/20/16.
//  Copyright © 2016 Maxim Khatskevich. All rights rrxreserved.
//

import XCTest

import XCERequirement

//===

public
enum RXC {}

//===

public
extension RXC
{
    static
    func value<Output>(
        _ description: String,
        file: StaticString = #file,
        line: UInt = #line,
        _ body: () -> Output?
        ) -> Output?
    {
        do
        {
            return try REQ.value(description, body)
        }
        catch
            let error as VerificationFailed
        {
            XCTFail(
                "[\(error.description)]",
                file: file,
                line: line)
            
            //===
            
            return nil
        }
        catch
        {
            XCTFail(
                error.localizedDescription,
                file: file,
                line: line)
            
            //===
            
            return nil
        }
    }
    
    static
    func isTrue(
        _ description: String,
        file: StaticString = #file,
        line: UInt = #line,
        _ body: () -> Bool
        )
    {
        do
        {
            try REQ.isTrue(description, body)
        }
        catch
            let error as VerificationFailed
        {
            XCTFail(
                "[\(error.description)]",
                file: file,
                line: line)
        }
        catch
        {
            XCTFail(
                error.localizedDescription,
                file: file,
                line: line)
        }
    }
    
    static
    func isNil(
        _ description: String,
        file: StaticString = #file,
        line: UInt = #line,
        _ body: () -> Any?
        )
    {
        do
        {
            try REQ.isNil(description, body)
        }
        catch
            let error as VerificationFailed
        {
            XCTFail(
                "[\(error.description)]",
                file: file,
                line: line)
        }
        catch
        {
            XCTFail(
                error.localizedDescription,
                file: file,
                line: line)
        }
    }
    
    static
    func isNotNil(
        _ description: String,
        file: StaticString = #file,
        line: UInt = #line,
        _ body: () -> Any?
        )
    {
        do
        {
            try REQ.isNotNil(description, body)
        }
        catch
            let error as VerificationFailed
        {
            XCTFail(
                "[\(error.description)]",
                file: file,
                line: line)
        }
        catch
        {
            XCTFail(
                error.localizedDescription,
                file: file,
                line: line)
        }
    }
}
