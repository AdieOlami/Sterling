//
//  CompetitionsVC.swift
//  SterlingApp
//
//  Created by Olar's Mac on 8/10/19.
//  Copyright © 2019 Adie Olalekan. All rights reserved.
//

import UIKit

class CompetitionsVC: UIViewController {
    weak var coordinator: CompetitionCoordinator?
    lazy var headerTitle: UILabel = {
        let label = UILabel()
        label.text = "Competitions"
        label.textColor = .black
        label.font = UIFont(name: "Avenir", size: 26)
        label.textAlignment = .center
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        //        tableView.separatorStyle = .none
        return tableView
    }()
    
    let cellId = "dusih"
    var competitionsData: [CompetitionsData] = [CompetitionsData]()
    
    var presenter: CompetitionsContract.Presenter!
    var progressView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        layout()
        logic()
//        NetworkAdapter.instance.getCompetitions().subscribe(onNext: { response in
//            guard let data = response.competitions else {return}
//
//            //            log(value)
//        })
        
        //        NetworkAdapter.instance.getTeamsResource(id: 57).subscribe(onNext: { value in
        ////            log(value)
        //        })
        presenter = CompetitionsPresenter(view: self, source: NetworkAdapter.instance)
        presenter.start()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
}

extension CompetitionsVC: CompetitionsContract.View {
    func showCompetitions(data: [CompetitionsData]) {
        DispatchQueue.main.async {
            self.competitionsData.append(contentsOf: data)
            self.tableView.reloadData()
        }
    }
    
    func showProgress(visible: Bool) {
         visible ? progressView.startAnimating() : progressView.stopAnimating()
    }
}

extension CompetitionsVC {
    private func layout() {
        view.addSubview(headerTitle)
        view.addSubview(tableView)
        headerTitle.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 44, enableInsets: false)
        tableView.anchor(top: headerTitle.bottomAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        
        progressView = UIActivityIndicatorView(style: .white)
        tableView.layout(progressView).center()
    }
    
    private func logic() {
        
    }
}

extension CompetitionsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return competitionsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = competitionsData[indexPath.row].name
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //        guard let id = agentList[indexPath.row].id else {return}
        let controller = CompetitionsDetails()
        controller.navTitle = competitionsData[indexPath.row].name
        log("TITLEEEE BOOM \(competitionsData[indexPath.row].name)", .json)
        controller.id = competitionsData[indexPath.row].id
        navigationController?.pushViewController(controller, animated: true)
    }
    
}
