//
//  TeamsCell.swift
//  SterlingApp
//
//  Created by Olar's Mac on 8/11/19.
//  Copyright © 2019 Adie Olalekan. All rights reserved.
//

import UIKit
import Kingfisher

class TeamsCell: UICollectionViewCell {

    @IBOutlet weak var clubImage: UIImageView!
    @IBOutlet weak var clubName: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    var teamData: TeamsData? {
        didSet {
            clubName.text = teamData?.name
            guard let img = teamData?.crestUrl else {return}
            let url = URL(string: img)
            clubImage.kf.setImage(with: url)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupView()
    }
    
    func setupView() {
        bgView.addShadowAndRoundCorners()
    }

}
