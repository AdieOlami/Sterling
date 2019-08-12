//
//  TeamModel.swift
//  SterlingApp
//
//  Created by Olar's Mac on 8/10/19.
//  Copyright © 2019 Adie Olalekan. All rights reserved.
//

import Foundation

struct TeamsModel: Codable {
    var id: Int?
    var area: AreaModel?
    var name: String?
    var shortName: String?
    var crestUrl: String?
    var squad: [SquadModel]?
}

struct SquadModel: Codable {
    var id: Int?
    var name: String?
    var position: String?
}
