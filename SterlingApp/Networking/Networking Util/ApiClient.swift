//
//  ApiClient.swift
//  SterlingNetworking
//
//  Created by Olar's Mac on 8/8/19.
//  Copyright © 2019 Adie Olalekan. All rights reserved.
//

import Foundation
import Alamofire
import netfox

class ApiClient {
    static let session: SessionManager = {
        let config = URLSessionConfiguration.default
        if Config.buildType == .debug {
            config.protocolClasses?.insert(NFXProtocol.self, at: 0)
        }
        config.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        
        config.httpAdditionalHeaders?["User-Agent"] = "\(Bundle.main.bundleIdentifier!)/\("iOS")/\(Bundle.main.buildNumber!)"
        return Alamofire.SessionManager(configuration: config)
    }()
}
