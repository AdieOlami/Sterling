//
//  TablesPresenter.swift
//  SterlingApp
//
//  Created by Olar's Mac on 8/11/19.
//  Copyright © 2019 Adie Olalekan. All rights reserved.
//

import Foundation
import RxSwift
import RxSwiftExt

class TablesPresenter: TablesContract.Presenter {
    
    private var view: TablesContract.View?
    private var disposeBag = DisposeBag()
    private var source: DataSource!
    
    init(view: TablesContract.View, source: DataSource) {
        self.source = source
        self.view = view
    }
    
    func start() {
    }
    
    func get(id: Int?) {
        view?.showProgress(visible: true)
        guard let id = id else {return}
        source
            .getCompetitionStandings(id: id).subscribe(onNext: {[weak self]  response in
                self?.view?.showProgress(visible: false)
                let standing = response.standings?.compactMap { $0 }
                standing?.forEach({ (model) in
                    
                    guard let data = model.table else {return}
                    self?.view?.showData(data: data)
                })}, onError: { _ in
                    self.view?.showProgress(visible: false)
            }).disposed(by: disposeBag)
    }
    
    func stop() {
        
    }
}
