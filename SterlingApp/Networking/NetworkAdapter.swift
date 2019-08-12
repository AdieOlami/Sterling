//
//  NetworkAdapter.swift
//  SterlingNetworking
//
//  Created by Olar's Mac on 8/8/19.
//  Copyright © 2019 Adie Olalekan. All rights reserved.
//

import Foundation
import Moya
import RxSwift

class CompleteUrlLoggerPlugin: PluginType {
    func willSend(_ request: RequestType, target: TargetType) {
        
    }
}

public class NetworkAdapter: DataSource {
    
    private var provider = MoyaProvider<SterlingAPI>(manager: ApiClient.session, plugins: [NetworkLoggerPlugin(verbose: true), CompleteUrlLoggerPlugin()], trackInflights: true)
    
    public static let instance = NetworkAdapter()
    
    public func getGoogle() -> Observable<String> {
        return provider.rx.request(.getGoogle)
            .mapObject(String.self)
            .asObservable()
    }
}
