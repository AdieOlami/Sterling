//
//  TeamsVC.swift
//  SterlingApp
//
//  Created by Olar's Mac on 8/11/19.
//  Copyright © 2019 Adie Olalekan. All rights reserved.
//

import UIKit

class TeamsVC: UIViewController {

//    let itemSpacing: CGFloat = 4.0
//    let itemsInOneLine = 2
//    let collectionWidth = 136
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "TeamsCell", bundle: .main), forCellWithReuseIdentifier: cellId)
        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    let cellId = "TeamsCell"
    var teamData: [TeamsData] = [TeamsData]()
    
    var id: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        layout()
        logic()
        guard let id = id else {return}
        NetworkAdapter.instance.getCompetitionTeams(id: id).subscribe(onNext: { response in
            
            guard let data = response.teams else {return}
            self.teamData.append(contentsOf: data)
            self.collectionView.reloadData()
            log("DATA FUCK \(data)", .fuck)
            
        })
        
    }
}

extension TeamsVC {
    private func layout() {
        view.addSubview(collectionView)
        collectionView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 4, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
    }
    
    private func logic() {
        
    }
}

extension TeamsVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let controller = TeamListVC()
        controller.id = teamData[indexPath.row].id
        controller.navTitle = teamData[indexPath.row].name
        log("TITLEEEE \(teamData[indexPath.row].name)", .fuck)
        self.addChild(controller)
        controller.view.frame = self.view.frame
        self.view.addSubview(controller.view)
        controller.didMove(toParent: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return teamData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TeamsCell
        cell.teamData = teamData[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var numOfColums: CGFloat = 3
        if UIScreen.main.bounds.width > 460 {
            numOfColums = 4
        }
        
        let spaceBtwCells: CGFloat = 8
        let padding: CGFloat = 46
        let cellDimension = ((collectionView.bounds.width - padding) - (numOfColums - 1) * spaceBtwCells) / numOfColums
        
        return CGSize(width: cellDimension, height: cellDimension)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
//    }
}
