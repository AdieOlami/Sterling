//
//  FixturesVC.swift
//  SterlingApp
//
//  Created by Olar's Mac on 8/11/19.
//  Copyright © 2019 Adie Olalekan. All rights reserved.
//

import UIKit
import Kingfisher
import DZNEmptyDataSet
import RxSwift
import Material

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
    var presenter: FixturesContract.Presenter!
    var progressView: UIActivityIndicatorView!
    var refreshControl: UIRefreshControl!
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        layout()
        logic()
        emptyTable()
        presenter = FixturesPresenter(view: self, source: NetworkAdapter.instance)
        presenter.get(id: id)
    }
}

extension FixturesVC: FixturesContract.View {
    func showData(data: [MatchesModel]) {
        DispatchQueue.main.async {
            self.fixtureData.append(contentsOf: data)
            self.tableView.reloadData()
        }
    }
    
    func showProgress(visible: Bool) {
        visible ? progressView.startAnimating() : progressView.stopAnimating()
        visible ? refreshControl.beginRefreshing() : refreshControl.endRefreshing()
    }
}

extension FixturesVC {
    private func layout() {
        view.addSubview(tableView)
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        
        progressView = UIActivityIndicatorView(style: .gray)
        tableView.layout(progressView).center()
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
    
    fileprivate func emptyTable() {
        tableView.reloadEmptyDataSet()
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        
        //        tableView.registerCellNib(HistoryCell.self)
        // Remove excess divider lines
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Loading ..", attributes: nil)
        refreshControl.rx.controlEvent(.valueChanged).asDriver().drive(onNext: {
            self.presenter.get(id: self.id)
        }).disposed(by: disposeBag)
        
        tableView.refreshControl = refreshControl
        tableView.reloadEmptyDataSet()
    }
    
}

// MARK: DZNEmptyView DataSetSource/Delegate

extension FixturesVC: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    public func customView(forEmptyDataSet scrollView: UIScrollView!) -> UIView! {
        let viewFromNib: EmptyView = EmptyView.fromNib()
        return viewFromNib
    }
    
    public func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return !refreshControl.isRefreshing
    }
    
}
