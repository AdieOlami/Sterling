//
//  Config.swift
//  SterlingApp
//
//  Created by Olar's Mac on 8/8/19.
//  Copyright © 2019 Adie Olalekan. All rights reserved.
//

import Foundation

// I prefer to decalre out my Confg like this to prepare for Snadbox(staging and Production environment)
struct Config {
    static let environment: Environment = {
        #if STAGING
        return .staging
        #else
        return .production
        #endif
    }()
    
    static let buildType: BuildType = {
        #if DEBUG
        return .debug
        #else
        return .release
        #endif
    }()
    
    private init() {}
}

enum Environment: String {
    case staging, production
    
    var baseURL: String {
        switch self {
        case .staging: return "https://api.football-data.org/v2/"
        case .production: return "https://api.football-data.org/v2/"
        }
    }
}

public enum BuildType: String {
    case debug, release
}
