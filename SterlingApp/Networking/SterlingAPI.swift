//
//  SterlingAPI.swift
//  SterlingNetworking
//
//  Created by Olar's Mac on 8/8/19.
//  Copyright © 2019 Adie Olalekan. All rights reserved.
//

import UIKit
import Moya
import Alamofire

enum SterlingAPI {
    case getGoogle
}

extension SterlingAPI: TargetType {
    
    var baseURL: URL {
        return URL(string: Config.environment.baseURL)!
    }
    
    var path: String {
        switch self {
        
        case .getGoogle: return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getGoogle: return .get
        }
    }
    
    // Leave for Unit Test
    var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        switch self {
        case .getGoogle: return .requestPlain
        }
    }
    
    public var headers: [String: String]? {
        return [
            "Content-Type": "application/json"
        ]
    }
}

func stubbedResponse(_ filename: String) -> Data! {
    @objc class TestClass: NSObject {}
    
    let bundle = Bundle(for: TestClass.self)
    let path = bundle.path(forResource: filename, ofType: "json")
    return (try? Data(contentsOf: URL(fileURLWithPath: path!)))
    
}

extension Encodable {
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}
