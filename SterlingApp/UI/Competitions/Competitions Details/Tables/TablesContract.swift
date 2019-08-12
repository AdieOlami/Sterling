//
//  TablesContract.swift
//  SterlingApp
//
//  Created by Olar's Mac on 8/11/19.
//  Copyright © 2019 Adie Olalekan. All rights reserved.
//

import Foundation

struct TablesContract {
    typealias View = _TablesView
    typealias Presenter = _TablesPresenter
}

protocol _TablesView: BaseView {
    func showData(data: [TableModel])
    func showProgress(visible: Bool)
}

protocol _TablesPresenter: BasePresenter {
    func get(id: Int?)
}
