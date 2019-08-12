//
//  TeamsContract.swift
//  SterlingApp
//
//  Created by Olar's Mac on 8/11/19.
//  Copyright © 2019 Adie Olalekan. All rights reserved.
//

import Foundation

struct TeamsContract {
    typealias View = _TeamsView
    typealias Presenter = _TeamsPresenter
}

protocol _TeamsView: BaseView {
    func showData(data: [TeamsData])
    func showProgress(visible: Bool)
}

protocol _TeamsPresenter: BasePresenter {
    func get(id: Int?)
}
