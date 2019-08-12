//
//  CompetitionsDetails.swift
//  SterlingApp
//
//  Created by Olar's Mac on 8/11/19.
//  Copyright © 2019 Adie Olalekan. All rights reserved.
//

import RxSwift
import Material
import CarbonKit

class CompetitionsDetails: UIViewController {
    
    let navView: NavView = {
        let navView = NavView()
        return navView
    }()
    
    var carbonViews: UIView = {
        let carbonView = UIView(frame: .zero)
        carbonView.translatesAutoresizingMaskIntoConstraints = false
        return carbonView
    }()
    
    let disposeBag = DisposeBag()
    var id: Int?
    var navTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        logic()
        layout()
        carbonKitInit()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        super.viewWillDisappear(animated)
    }
    
}

extension CompetitionsDetails: CarbonTabSwipeNavigationDelegate {
    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, viewControllerAt index: UInt) -> UIViewController {
        switch index {
        case 0:
            let controller  = TablesVC()
            controller.id = id
            return controller
        case 1:
            let controller  = FixturesVC()
            controller.id = id
            return controller
        case 2:
            let controller  = TeamsVC()
            controller.id = id
            return controller
        default:
            fatalError()
        }
    }
    
    fileprivate func carbonKitInit() {
        let items = ["Tables", "Fixtures", "Teams"]
        let carbonTabSwipeNavigation = CarbonTabSwipeNavigation(items: items, delegate: self)
        carbonTabSwipeNavigation.insert(intoRootViewController: self, andTargetView: carbonViews)
        let font = UIFont(name: "Avenir", size: 18)
        //        carbonTabSwipeNavigation.toolbarHeight.constant = 45
        carbonTabSwipeNavigation.setSelectedColor(.white, font: font!)
        carbonTabSwipeNavigation.setNormalColor(UIColor.black.withAlphaComponent(0.6), font: font!)
        carbonTabSwipeNavigation.setIndicatorColor(.gray)
        let width = view.frame.width/3
        carbonTabSwipeNavigation.carbonSegmentedControl?.setWidth(width, forSegmentAt: 0)
        carbonTabSwipeNavigation.carbonSegmentedControl?.setWidth(width, forSegmentAt: 1)
        carbonTabSwipeNavigation.carbonSegmentedControl?.setWidth(width, forSegmentAt: 2)
        carbonTabSwipeNavigation.toolbar.isTranslucent = false
        carbonTabSwipeNavigation.toolbar.clipsToBounds = true
//        carbonTabSwipeNavigation.carbonSegmentedControl?.backgroundColor = UIColor(hexString: "#2E755E")
    }
    
}

extension CompetitionsDetails {
    
    fileprivate func layout() {
        
        view.addSubview(navView)
        view.addSubview(carbonViews)
        navView.navLabel.text = navTitle
        NSLayoutConstraint.activate([
            
            navView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            navView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            navView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            navView.heightAnchor.constraint(equalToConstant: 52),
            //            carbonViews.topAnchor.constraint(equalTo: navView.bottomAnchor, constant: 0),
            //            carbonViews.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            //            carbonViews.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            //            carbonViews.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            ])
        
        carbonViews.anchor(top: navView.bottomAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        
    }
    
    fileprivate func logic() {
        navView.backBtn.rx.tap.asDriver().drive(onNext: {
            self.navigationController?.popViewController(animated: true)
        }).disposed(by: disposeBag)
        
    }
}

class NavView: UIView {
    
    var navLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont(name: "Avenir", size: 26)
        label.textAlignment = .center
        return label
    }()
    
    var nav: UIView = {
        let nav = UIView()
        nav.translatesAutoresizingMaskIntoConstraints = false
        nav.backgroundColor = .white
        return nav
    }()
    
    var backBtn: IconButton = {
        let backBtn = IconButton(image: Icon.arrowBack, tintColor: .black)
        backBtn.translatesAutoresizingMaskIntoConstraints = false
        return backBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        shared()
        layout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func shared() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func layout() {
        addSubview(nav)
        nav.addSubview(backBtn)
        nav.addSubview(navLabel)
        NSLayoutConstraint.activate([
            nav.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            nav.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            nav.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            nav.heightAnchor.constraint(equalToConstant: 52),
            
            backBtn.centerYAnchor.constraint(equalTo: nav.centerYAnchor),
            backBtn.leadingAnchor.constraint(equalTo: nav.leadingAnchor, constant: 16),
            backBtn.heightAnchor.constraint(equalToConstant: 30),
            backBtn.widthAnchor.constraint(equalToConstant: 30),
            
            navLabel.centerYAnchor.constraint(equalTo: nav.centerYAnchor),
            navLabel.leadingAnchor.constraint(equalTo: backBtn.trailingAnchor, constant: 10),
            navLabel.heightAnchor.constraint(equalToConstant: 30)
            ])
        
    }
}
