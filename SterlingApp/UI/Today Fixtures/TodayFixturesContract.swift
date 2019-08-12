//
//  TodayFixturesContract.swift
//  SterlingApp
//
//  Created by Olar's Mac on 8/11/19.
//  Copyright © 2019 Adie Olalekan. All rights reserved.
//

import Foundation

struct TodayFixturesContract {
    typealias View = _TodayFixturesView
    typealias Presenter = _TodayFixturesPresenter
}

protocol _TodayFixturesView: BaseView {
    func showTodaysFixtures(data: [MatchesModel])
    func showProgress(visible: Bool)
}

protocol _TodayFixturesPresenter: BasePresenter {
    func getTodaysFixture()
}
