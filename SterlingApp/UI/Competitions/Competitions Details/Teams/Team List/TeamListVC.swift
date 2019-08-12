//
//  TeamListVC.swift
//  SterlingApp
//
//  Created by Olar's Mac on 8/11/19.
//  Copyright © 2019 Adie Olalekan. All rights reserved.
//

import UIKit
import RxSwift
import Material

class TeamListVC: UIViewController {
    
    lazy var bgView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    let navView: NavView = {
        let navView = NavView()
        return navView
    }()
    
    lazy var clubCrest: UIImageView = {
       let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TeamListCell", bundle: .none), forCellReuseIdentifier: cellId)
        return tableView
    }()
    
    let cellId = "TeamListCell"
    var squadData: [SquadModel] = [SquadModel]()
    var id: Int?
    var navTitle: String?
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clear.withAlphaComponent(0.3)
        layout()
        logic()
        guard let id = id else {return}
        NetworkAdapter.instance.getTeamsResource(id: id).subscribe(onNext: { response in
            
            guard let data = response.squad else {return}
            guard let img = response.crestUrl else {return}
            let url = URL(string: img)
            self.clubCrest.kf.setImage(with: url)
            self.squadData.append(contentsOf: data)
            self.tableView.reloadData()
            
        })
    }
}

extension TeamListVC {
    private func layout() {
        showAnimate()
        view.addSubview(bgView)
        bgView.addSubview(navView)
        bgView.addSubview(clubCrest)
        bgView.addSubview(tableView)
        bgView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 50, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        
        clubCrest.anchor(top: navView.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 50, height: 50, enableInsets: false)
        
        tableView.anchor(top: clubCrest.bottomAnchor, left: bgView.leftAnchor, bottom: bgView.bottomAnchor, right: bgView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        
        NSLayoutConstraint.activate([
            
            navView.topAnchor.constraint(equalTo: bgView.topAnchor, constant: 0),
            navView.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 0),
            navView.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: 0),
            navView.heightAnchor.constraint(equalToConstant: 52),
            clubCrest.centerXAnchor.constraint(equalTo: bgView.centerXAnchor)
            ])
    }
    
    private func logic() {
        navView.backBtn.rx.tap.asDriver().drive(onNext: {
            self.removeAnimate()
        }).disposed(by: disposeBag)
        navView.navLabel.text = navTitle
        navView.navLabel.textAlignment = .center
        navView.backBtn.image = Icon.close
    }
    
    fileprivate func showAnimate() {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
    }
    
    fileprivate func removeAnimate() {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0
        }, completion: {(finished: Bool) in
            if finished {
                self.willMove(toParent: nil)
                self.view.removeFromSuperview()
                self.removeFromParent()
            }
        })
    }
}

extension TeamListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return squadData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TeamListCell
        let data = squadData[indexPath.row]
        cell.setup(squadData: data, indexPath: indexPath)
        log(data, .fuck)
        cell.selectionStyle = .none
        return cell
    }
    
}
