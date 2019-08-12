//
//  HTTPStatus.swift
//  SterlingApp
//
//  Created by Olar's Mac on 8/8/19.
//  Copyright © 2019 Adie Olalekan. All rights reserved.
//

import Foundation

enum HTTPStatus: Int {
    
    case ok = 200
    
    case created = 201
    
    case accepted = 202
    
    case notAuthoritative = 203
    
    case noContent = 204
    
    case reset = 205
    
    case partial = 206
    
    /* 3XX: relocation/redirect */
    case multChoice = 300
    
    case movedPerm = 301
    
    case movedTemp = 302
    
    case seeOther = 303
    
    case notModified = 304
    
    case useProxy = 305
    
    /* 4XX: client error */
    case badRequest = 400
    
    case unauthorized = 401
    
    case paymentRequired = 402
    
    case forbidden = 403
    
    case notFound = 404
    
    case badMethod = 405
    
    case notAcceptable = 406
    
    case proxyAuth = 407
    
    case clientTimeout = 408
    
    case conflict = 409
    
    case gone = 410
    
    case lengthRequired = 411
    
    case preconFailed = 412
    
    case entityTooLarge = 413
    
    case reqTooLong = 414
    
    case unsupportedType = 415
    
    /* 5XX: server error */
    case internalError = 500
    
    case notImplemented = 501
    
    case badGateway = 502
    
    case unavailable = 503
    
    case gatewayTimeout = 504
    
    case version = 505
    
}
