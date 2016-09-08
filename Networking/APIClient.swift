//
//  APIClient.swift
//  Networking
//
//  Created by race on 9/8/16.
//  Copyright © 2016 race. All rights reserved.
//

import Foundation

import Alamofire

class APIClient {
    
    static func events(perPage: Int, page: Int, completionHandler: Result<Repos> -> Void) {
        _request(Endpoint.Events(perPage: perPage, page: page), completionHandler: completionHandler)
    }
}

// MARK: - Private Methods

/**
 request 请求方法
 
 - parameter endpoint:          请求方法的 endpoint
 - parameter completionHandler: 请求完成回调
 
 - returns: 返回 Request 自身
 */
private func _request<T: JSONAbleType>(
    endpoint: Endpoint,
    completionHandler:(Result<T>) -> Void) -> Request {
    
    let request = Manager.sharedInstance.request(
        endpoint.method,
        endpoint.baseURLString + endpoint.path,
        parameters: endpoint.parameters,
        encoding: .URL, headers: nil
        ).responseJSON { response in
            
            if response.result.isSuccess {
                if let result = T.fromJSON(response.result.value) {
                    completionHandler(.Success(result))
                }
            } else {
                completionHandler(.Failure(status: response.response?.statusCode ?? -1, description: response.description))
            }
    }
    
    debugPrint(request)
    return request
}
