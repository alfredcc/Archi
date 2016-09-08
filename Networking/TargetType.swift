//
//  TargetType.swift
//  Networking
//
//  Created by race on 9/8/16.
//  Copyright © 2016 race. All rights reserved.
//


import Foundation
import Alamofire

/// Protocol to define the base URL, path, method, parameters and sample data for a target.
public protocol TargetType {
    
    var baseURLString: String { get }
    
    var path: String { get }
    
    var method: Alamofire.Method { get }
    
    var parameters: [String: AnyObject]? { get }
}

