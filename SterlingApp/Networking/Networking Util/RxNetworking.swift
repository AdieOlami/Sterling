//
//  RxNetworking.swift
//  SterlingNetworking
//
//  Created by Olar's Mac on 8/8/19.
//  Copyright © 2019 Adie Olalekan. All rights reserved.
//

import Foundation
import RxSwiftExt

let networkRetryPredicate: RetryPredicate = { error in
    if let err = error as? NetworkingError, let response = err.httpResponse {
        let code = response.statusCode
        if code >= 400 && code < 600 {
            return false
        }
    }
    
    return true
}

// Use this struct to pass the response and data along with
// the error as alamofire does not do this automatically
public struct NetworkingError: Error {
    let httpResponse: HTTPURLResponse?
    let networkData: Data?
    let baseError: Error
}
