//
//  TeamListPresenter.swift
//  SterlingApp
//
//  Created by Olar's Mac on 8/11/19.
//  Copyright © 2019 Adie Olalekan. All rights reserved.
//

import Foundation
import RxSwift
import RxSwiftExt

class TeamListPresenter: TeamListContract.Presenter {
    
    private var view: TeamListContract.View?
    private var disposeBag = DisposeBag()
    private var source: DataSource!
    
    init(view: TeamListContract.View, source: DataSource) {
        self.source = source
        self.view = view
    }
    
    func start() {
    }
    
    func get(id: Int?) {
        view?.showProgress(visible: true)
        guard let id = id else {return}
        source.getTeamsResource(id: id)
            .subscribe(onNext: {[weak self] response in
                self?.view?.showProgress(visible: false)
//                guard let data = response else {return}
                self?.view?.showData(data: response)
                }, onError: { _ in
                    self.view?.showProgress(visible: false)
            }).disposed(by: disposeBag)
    }
    
    func stop() {
        
    }
}
