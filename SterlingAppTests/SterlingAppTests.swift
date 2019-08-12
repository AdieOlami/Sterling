//
//  SterlingAppTests.swift
//  SterlingAppTests
//
//  Created by Olar's Mac on 8/8/19.
//  Copyright © 2019 Adie Olalekan. All rights reserved.
//

import XCTest
import Moya
import Alamofire
import Result
@testable import SterlingApp

class SterlingAppTests: XCTestCase {

    var provider: MoyaProvider<SterlingAPI>!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        provider = MoyaProvider<SterlingAPI>(endpointClosure: customEndpointClosure, stubClosure: MoyaProvider.immediatelyStub, manager: ApiClient.session, plugins: [NetworkLoggerPlugin(verbose: true), CompleteUrlLoggerPlugin()], trackInflights: true)
    }
    
    func customEndpointClosure(_ target: SterlingAPI) -> Endpoint {
        return Endpoint(url: URL(target: target).absoluteString,
                        sampleResponseClosure: { .networkResponse(200, target.testSampleData) },
                        method: target.method,
                        task: target.task,
                        httpHeaderFields: target.headers)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func getCompetitions() {
        
        let expectation = self.expectation(description: "request")
        _ = provider?.request(.getCompetitions) { res in
            // pass or fail depending on your test needs
            switch res {
                
            case .success(let data):
                log(data, .json)
            case .failure(let error):
                log(error, .fuck)
            }
            
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 5.0, handler: nil)
    }

}

extension SterlingAPI {
    var testSampleData: Data {
        switch self {
        case .getCompetitions:
            return stubbedResponse("Competitions")
        case .getCompetitionTeams:
            return stubbedResponse("Matches")
        case .getCompetitionStandings:
            return stubbedResponse("Standings")
        case .getCompetitionMatches:
            return Data()
        case .getTeamsResource:
            return Data()
        case .getMatches:
            return Data()
            
        }
    }
}
