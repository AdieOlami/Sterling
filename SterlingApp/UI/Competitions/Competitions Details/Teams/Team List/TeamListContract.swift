//
//  TeamListContract.swift
//  SterlingApp
//
//  Created by Olar's Mac on 8/11/19.
//  Copyright © 2019 Adie Olalekan. All rights reserved.
//

import Foundation

struct TeamListContract {
    typealias View = _TeamListView
    typealias Presenter = _TeamListPresenter
}

protocol _TeamListView: BaseView {
    func showData(data: TeamsModel)
    func showProgress(visible: Bool)
}

protocol _TeamListPresenter: BasePresenter {
    func get(id: Int?)
}
