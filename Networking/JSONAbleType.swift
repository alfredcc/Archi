//
//  JSONAbleType.swift
//  Networking
//
//  Created by race on 9/8/16.
//  Copyright © 2016 race. All rights reserved.
//

import Foundation

public typealias JSONDictionary = [String: AnyObject]

protocol JSONAbleType {
    
    static func fromJSON(rawValue: AnyObject?) -> Self?
}
