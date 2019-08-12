//
//  SterlingAPI.swift
//  SterlingApp
//
//  Created by Olar's Mac on 8/8/19.
//  Copyright © 2019 Adie Olalekan. All rights reserved.
//

extension Encodable {
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}

import UIKit
import Moya
import Alamofire

enum SterlingAPI {
    case getCompetitions
    case getCompetitionTeams(Int)
    case getCompetitionStandings(Int)
    case getCompetitionMatches(Int)
    case getTeamsResource(Int)
    case getMatches
}

extension SterlingAPI: TargetType {
    
    var baseURL: URL {
        return URL(string: Config.environment.baseURL)!
    }
    
    var path: String {
        switch self {
        case .getCompetitions: return "competitions"
        case .getCompetitionTeams(let id): return "competitions/\(id)/teams"
        case .getCompetitionStandings(let id): return "competitions/\(id)/standings"
        case .getCompetitionMatches(let id): return "competitions/\(id)/matches"
        case .getTeamsResource(let id): return "teams/\(id)"
        case .getMatches: return "matches"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getCompetitions, .getCompetitionTeams, .getCompetitionStandings, .getCompetitionMatches, .getTeamsResource, .getMatches: return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        switch self {
        case .getCompetitions, .getCompetitionTeams, .getCompetitionMatches, .getTeamsResource, .getMatches: return .requestPlain
        case .getCompetitionStandings: return .requestParameters(parameters: ["standingType": "HOME"], encoding: URLEncoding.default)
        }
    }
    
    public var headers: [String: String]? {
        return [
            "X-Auth-Token": "16d3feb77c0d44f69a095493948178a7"
        ]
    }
}

func stubbedResponse(_ filename: String) -> Data! {
    @objc class TestClass: NSObject {}
    
    let bundle = Bundle(for: TestClass.self)
    let path = bundle.path(forResource: filename, ofType: "json")
    return (try? Data(contentsOf: URL(fileURLWithPath: path!)))
    
}
