//
//  CompetitionsPresenter.swift
//  SterlingApp
//
//  Created by Olar's Mac on 8/10/19.
//  Copyright © 2019 Adie Olalekan. All rights reserved.
//

import Foundation
import RxSwift
import RxSwiftExt

class CompetitionsPresenter: CompetitionsContract.Presenter {
    
    private var view: CompetitionsContract.View?
    private var disposeBag = DisposeBag()
    private var source: DataSource!
    
    init(view: CompetitionsContract.View, source: DataSource) {
        self.source = source
        self.view = view
    }
    
    func start() {
        get()
    }
    
    func get() {
        view?.showProgress(visible: true)
        source.getCompetitions()
            .subscribe(onNext: {[weak self] response in
            self?.view?.showProgress(visible: false)
            guard let data = response.competitions else {return}
            self?.view?.showData(data: data)
                }, onError: { _ in
                    self.view?.showProgress(visible: false)
            }).disposed(by: disposeBag)
    }
    
    func stop() {
        
    }
}
