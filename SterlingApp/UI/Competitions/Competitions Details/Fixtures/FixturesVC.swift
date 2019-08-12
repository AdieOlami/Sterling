//
//  FixturesVC.swift
//  SterlingApp
//
//  Created by Olar's Mac on 8/11/19.
//  Copyright © 2019 Adie Olalekan. All rights reserved.
//

import UIKit
import Kingfisher

class FixturesVC: UIViewController {

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "FixturesCell", bundle: .none), forCellReuseIdentifier: cellId)
        //        tableView.separatorStyle = .none
        return tableView
    }()
    
    let cellId = "FixturesCell"
    var fixtureData: [MatchesModel] = [MatchesModel]()
    var id: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        layout()
        logic()
        guard let id = id else {return}
        NetworkAdapter.instance.getCompetitionMatches(id: id).subscribe(onNext: { response in
            guard let data = response.matches else {return}
            log("DATA FUCK \(data)", .fuck)
            self.fixtureData.append(contentsOf: data)
            self.tableView.reloadData()
            
        })
        
    }
}

extension FixturesVC {
    private func layout() {
        view.addSubview(tableView)
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
    }
    
    private func logic() {
        
    }
}

extension FixturesVC: UITableViewDelegate, UITableViewDataSource {
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
