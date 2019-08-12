//
//  CompetitionsContract.swift
//  SterlingApp
//
//  Created by Olar's Mac on 8/10/19.
//  Copyright © 2019 Adie Olalekan. All rights reserved.
//

import Foundation

struct CompetitionsContract {
    typealias View = _CompetitionsView
    typealias Presenter = _CompetitionsPresenter
}

protocol _CompetitionsView: BaseView {
    func showCompetitions(data: [CompetitionsData])
    func showProgress(visible: Bool)
}

protocol _CompetitionsPresenter: BasePresenter {
    func getCompetitions()
}
