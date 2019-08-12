//
//  TablesVC.swift
//  SterlingApp
//
//  Created by Olar's Mac on 8/11/19.
//  Copyright © 2019 Adie Olalekan. All rights reserved.
//

import UIKit

class TablesVC: UIViewController {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TablesCell", bundle: .none), forCellReuseIdentifier: cellId)
        //        tableView.separatorStyle = .none
        return tableView
    }()
    
    let cellId = "TablesCell"
    var tableData: [TableModel] = [TableModel]()
    var id: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        layout()
        logic()
        guard let id = id else {return}
        NetworkAdapter.instance.getCompetitionStandings(id: id).subscribe(onNext: { response in
            
            let standing = response.standings?.compactMap { $0 }
            standing?.forEach({ (model) in
                
                guard let data = model.table else {return}
                log("DATA FUCK \(data)", .fuck)
                self.tableData.append(contentsOf: data)
                self.tableView.reloadData()
            })
//                .compactMap {$0.table}.reduce([], +)
            
        })
        
    }
}

extension TablesVC {
    private func layout() {
        view.addSubview(tableView)
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
    }
    
    private func logic() {
        
    }
}

extension TablesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TablesCell
        let data = tableData
        cell.tableData = data[indexPath.row]
        log(data, .fuck)
//        cell.textLabel?.text = competitionsData[indexPath.row].name
        cell.selectionStyle = .none
        return cell
    }
    
}
