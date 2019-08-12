//
//  FixturesContract.swift
//  SterlingApp
//
//  Created by Olar's Mac on 8/11/19.
//  Copyright © 2019 Adie Olalekan. All rights reserved.
//

import Foundation

struct FixturesContract {
    typealias View = _FixturesView
    typealias Presenter = _FixturesPresenter
}

protocol _FixturesView: BaseView {
    func showData(data: [MatchesModel])
    func showProgress(visible: Bool)
}

protocol _FixturesPresenter: BasePresenter {
    func get(id: Int?)
}
