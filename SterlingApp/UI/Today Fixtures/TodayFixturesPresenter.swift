//
//  TodayFixturesPresenter.swift
//  SterlingApp
//
//  Created by Olar's Mac on 8/11/19.
//  Copyright © 2019 Adie Olalekan. All rights reserved.
//

import Foundation
import RxSwift
import RxSwiftExt

class TodayFixturesPresenter: TodayFixturesContract.Presenter {
    
    private var view: TodayFixturesContract.View?
    private var disposeBag = DisposeBag()
    private var source: DataSource!
    
    init(view: TodayFixturesContract.View, source: DataSource) {
        self.source = source
        self.view = view
    }
    
    func start() {
        getTodaysFixture()
    }
    
    func getTodaysFixture() {
        view?.showProgress(visible: true)
        source.getCompetitions()
            .subscribe(onNext: {[weak self] response in
                self?.view?.showProgress(visible: false)
                guard let data = response.matches else {return}
                self?.view?.showTodaysFixtures(data: data)
                }, onError: { _ in
                    self.view?.showProgress(visible: false)
            }).disposed(by: disposeBag)
    }
    
    func stop() {
        
    }
}
