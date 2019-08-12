//
//  DataSource.swift
//  SterlingApp
//
//  Created by Olar's Mac on 8/8/19.
//  Copyright © 2019 Adie Olalekan. All rights reserved.
//

import Foundation
import RxSwift

protocol DataSource {
    func getCompetitions() -> Observable<CompetitionsModel>
    func getCompetitionTeams(id: Int) -> Observable<CompetitionsModel>
    func getCompetitionStandings(id: Int) -> Observable<CompetitionsModel>
    func getCompetitionMatches(id: Int) -> Observable<CompetitionsModel>
    func getTeamsResource(id: Int) -> Observable<TeamsModel>
    func getMatches() -> Observable<CompetitionsModel>
}
