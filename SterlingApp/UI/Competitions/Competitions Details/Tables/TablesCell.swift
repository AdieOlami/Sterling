//
//  TablesCell.swift
//  SterlingApp
//
//  Created by Olar's Mac on 8/11/19.
//  Copyright © 2019 Adie Olalekan. All rights reserved.
//

import UIKit
import Kingfisher

class TablesCell: UITableViewCell {

    @IBOutlet weak var clubImage: UIImageView!
    @IBOutlet weak var postion: UILabel!
    @IBOutlet weak var clubName: UILabel!
    @IBOutlet weak var games: UILabel!
    @IBOutlet weak var points: UILabel!
    @IBOutlet weak var goalDiff: UILabel!
    
    var tableData: TableModel? {
        didSet {
            postion.text = "\(tableData?.position ?? 0)"
            clubName.text = tableData?.team?.name
            games.text = "\(tableData?.playedGames ?? 0)"
            points.text = "\(tableData?.points ?? 0)"
            goalDiff.text = "\(tableData?.goalDifference ?? 0)"
            guard let img = tableData?.team?.crestUrl else {return}
            let url = URL(string: img)
            clubImage.kf.setImage(with: url)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setup(tableData: TableModel) {
        postion.text = "\(tableData.position ?? 0)"
        clubName.text = tableData.team?.shortName
        games.text = "\(tableData.playedGames ?? 0)"
        points.text = "\(tableData.points ?? 0)"
        goalDiff.text = "\(tableData.goalDifference ?? 0)"
    }
    
}
