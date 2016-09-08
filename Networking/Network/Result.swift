//
//  Result.swift
//  Networking
//
//  Created by race on 9/8/16.
//  Copyright © 2016 race. All rights reserved.
//

import Foundation

public enum Result<T> {
    case Success(T)
    case Failure(status:Int, description: String)
    
    /// Returns the associated value if the result is a success, `nil` otherwise.
    public var value: T? {
        switch self {
        case .Success(let value):
            return value
        case .Failure:
            return nil
        }
    }
    
    /// Returns `200` if the result is a success, status otherwise.
    public var status: Int {
        switch self {
        case .Success:
            return 200
        case .Failure(let status, _):
            return status
        }
    }
    
    /// Returns "" if the result is a success, message otherwise.
    public var description: String {
        switch self {
        case .Success:
            return ""
        case .Failure(_, let description):
            return description
        }
    }
}
