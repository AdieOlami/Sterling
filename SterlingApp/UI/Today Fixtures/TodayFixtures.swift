//
//  TodayFixtures.swift
//  SterlingApp
//
//  Created by Olar's Mac on 8/11/19.
//  Copyright © 2019 Adie Olalekan. All rights reserved.
//

import UIKit

class TodayFixtures: UIViewController {
    weak var coordinator: TodayFixturesCoordinator?
    let navView: NavView = {
        let navView = NavView()
        navView.backBtn.isHidden = true
        return navView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "FixturesCell", bundle: .none), forCellReuseIdentifier: cellId)
        return tableView
    }()
    
    let cellId = "TodayFixturesCell"
    var fixtureData: [MatchesModel] = [MatchesModel]()
    
    var presenter: TodayFixturesContract.Presenter!
    var progressView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        layout()
        logic()
        presenter = TodayFixturesPresenter(view: self, source: NetworkAdapter.instance)
        presenter.start()
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

extension TodayFixtures {
    private func layout() {
        view.addSubview(tableView)
        view.addSubview(navView)
        navView.navLabel.text = "Today's Fixtures"
        NSLayoutConstraint.activate([
            
            navView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            navView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            navView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            navView.heightAnchor.constraint(equalToConstant: 52)
            ])
        tableView.anchor(top: navView.bottomAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        progressView = UIActivityIndicatorView(style: .gray)
        tableView.layout(progressView).center()
    }
    
    private func logic() {
        
    }
}

extension TodayFixtures: TodayFixturesContract.View {
    func showTodaysFixtures(data: [MatchesModel]) {
        DispatchQueue.main.async {
            self.fixtureData.append(contentsOf: data)
            self.tableView.reloadData()
        }
    }
    
    func showProgress(visible: Bool) {
        visible ? progressView.startAnimating() : progressView.stopAnimating()
    }
}

extension TodayFixtures: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fixtureData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! FixturesCell
        let data = fixtureData
        cell.fixtureData = data[indexPath.row]
        log(data, .fuck)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 112.0
    }
    
}
