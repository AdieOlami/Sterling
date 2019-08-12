//
//  NetworkAdapter.swift
//  SterlingApp
//
//  Created by Olar's Mac on 8/8/19.
//  Copyright © 2019 Adie Olalekan. All rights reserved.
//

import Foundation
import Moya
import RxSwift

//Plugin to get Url endpoints incase of deepLinking. added for Sterling *winks*
class CompleteUrlLoggerPlugin: PluginType {
    func willSend(_ request: RequestType, target: TargetType) {
        
    }
}

class NetworkAdapter: DataSource {
    
    private var provider = MoyaProvider<SterlingAPI>(manager: ApiClient.session, plugins: [NetworkLoggerPlugin(verbose: true), CompleteUrlLoggerPlugin()], trackInflights: true)

    // This is for Unit Testing
//    let stubbingProvider = MoyaProvider<SterlingAPI>(endpointClosure: { (target) -> Endpoint in
//        Endpoint(url: URL(target: target).absoluteString,
//                 sampleResponseClosure: { .networkResponse(200, target.sampleData) },
//                 method: target.method,
//                 task: target.task,
//                 httpHeaderFields: target.headers)
//    }, stubClosure: MoyaProvider.immediatelyStub, manager: ApiClient.session, plugins: [NetworkLoggerPlugin(verbose: true), CompleteUrlLoggerPlugin()], trackInflights: true)

    
    static let instance = NetworkAdapter()
    
    func getCompetitions() -> Observable<CompetitionsModel> {
        return provider.rx.request(.getCompetitions)
            .mapObject(CompetitionsModel.self)
            .asObservable()
    }
    
    func getCompetitionTeams(id: Int) -> Observable<CompetitionsModel> {
        return provider.rx.request(.getCompetitionTeams(id))
            .mapObject(CompetitionsModel.self)
            .asObservable()
    }
    
    func getCompetitionStandings(id: Int) -> Observable<CompetitionsModel> {
        return provider.rx.request(.getCompetitionStandings(id))
            .mapObject(CompetitionsModel.self)
            .asObservable()
    }
    
    func getCompetitionMatches(id: Int) -> Observable<CompetitionsModel> {
        return provider.rx.request(.getCompetitionMatches(id))
            .mapObject(CompetitionsModel.self)
            .asObservable()
    }
    
    func getTeamsResource(id: Int) -> Observable<TeamsModel> {
        return provider.rx.request(.getTeamsResource(id))
            .mapObject(TeamsModel.self)
            .asObservable()
    }
    
    func getMatches() -> Observable<CompetitionsModel> {
        return provider.rx.request(.getMatches)
            .mapObject(CompetitionsModel.self)
            .asObservable()
    }
}
