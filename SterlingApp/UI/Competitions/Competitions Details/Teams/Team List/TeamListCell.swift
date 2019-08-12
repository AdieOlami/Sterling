//
//  TeamListCell.swift
//  SterlingApp
//
//  Created by Olar's Mac on 8/11/19.
//  Copyright © 2019 Adie Olalekan. All rights reserved.
//

import UIKit

class TeamListCell: UITableViewCell {

    @IBOutlet weak var count: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var postion: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(squadData: SquadModel, indexPath: IndexPath) {
        postion.text = squadData.position
        name.text = squadData.name
        count.text = "\(indexPath.row + 1)"
    }
    
}
