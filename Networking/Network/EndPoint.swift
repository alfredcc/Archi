//
//  EndPoint.swift
//  Networking
//
//  Created by race on 9/8/16.
//  Copyright © 2016 race. All rights reserved.
//

import Foundation

import Alamofire

public enum Endpoint: TargetType {
    
    public var baseURLString: String {
        return "https://api.github.com/"
    }
    
    // MARK: - Endpoints
    case Events(perPage: Int, page: Int)
    
    case SignUp(user: String, passwd: String)

    
    // MARK: - Path
    
    public var path : String {
        switch self {
        case .Events:
            return "events"
        case .SignUp:
            return "sign_up"
        }
    }
    
    // MARK: - Method
    
    public var method: Alamofire.Method {
        switch self {
        case .SignUp:
            return Alamofire.Method.POST
        default:
            return Alamofire.Method.GET
        }
    }
    
    // MARK: - Parameters
    
    public var parameters: [String: AnyObject]? {
        switch self {
        case let .Events(perPage, page):
            return ["per_page": perPage, "page": page]
            
        case let .SignUp(user, passwd):
            return ["user": user, "password": passwd]
        }
    }
}

