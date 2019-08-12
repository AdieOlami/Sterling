//
//  CompetitionsModel.swift
//  SterlingApp
//
//  Created by Olar's Mac on 8/10/19.
//  Copyright © 2019 Adie Olalekan. All rights reserved.
//

import Foundation

// I intentionally Wrote all the Model in this file to reduce file creation and to maintain orderliness since we are using the same base model

struct CompetitionsModel: Codable {
    var count: Int?
    var competitions: [CompetitionsData]?
    var season: CurrentSeasonModel?
    var teams: [TeamsData]?
    var standings: [StandingModel]?
    var matches: [MatchesModel]?
}

struct CompetitionsData: Codable {
    var id: Int?
    var area: AreaModel?
    var name: String?
    var code: String?
    var emblemUrl: String?
    var plan: String?
    var currentSeason: CurrentSeasonModel?
    var numberOfAvailableSeasons: Int?
    var lastUpdated: String?
}

struct AreaModel: Codable {
    var id: Int?
    var name: String?
}

struct CurrentSeasonModel: Codable {
    var id: Int?
    var startDate: String?
    var endDate: String?
    var currentMatchday: Int?
    var winner: WinnerModel?
}

struct WinnerModel: Codable {
    var id: Int?
    var name: String?
    var shortName: String?
    var tla: String?
    var crestUrl: String?
}

struct TeamsData: Codable {
    var id: Int?
    var area: AreaModel?
    var name: String?
    var shortName: String?
    var crestUrl: String?
}

struct StandingModel: Codable {
    var stage: String?
    var type: String?
    var table: [TableModel]?
}

struct TableModel: Codable {
    var position: Int?
    var team: TeamsData?
    var playedGames: Int?
    var won: Int?
    var draw: Int?
    var lost: Int?
    var points: Int?
    var goalDifference: Int?
}

struct MatchesModel: Codable {
    var id: Int?
    var season: CurrentSeasonModel?
    var status: String?
    var homeTeam: TeamModel?
    var awayTeam: TeamModel?
    var score: ScoreModel?
}

struct TeamModel: Codable {
    var id: Int?
    var name: String?
}

struct ScoreModel: Codable {
    var fullTime: FullTimeModel?
    var halfTime: FullTimeModel?
}

struct FullTimeModel: Codable {
    var homeTeam: Int?
    var awayTeam: Int?
}
