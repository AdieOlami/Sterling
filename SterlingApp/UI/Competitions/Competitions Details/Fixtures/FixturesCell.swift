//
//  FixturesCell.swift
//  SterlingApp
//
//  Created by Olar's Mac on 8/11/19.
//  Copyright © 2019 Adie Olalekan. All rights reserved.
//

import UIKit
import Kingfisher

class FixturesCell: UITableViewCell {

    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var md: UILabel!
    @IBOutlet weak var homeTeam: UILabel!
    @IBOutlet weak var awayTeam: UILabel!
    @IBOutlet weak var zerozero: UILabel!
    @IBOutlet weak var homeGoal: UILabel!
    @IBOutlet weak var awayGoal: UILabel!
    
    var fixtureData: MatchesModel? {
        didSet {
            status.text = fixtureData?.status
//            time.text = fixtureData?.team?.name
            md.text = "MD:32"
            homeTeam.text = fixtureData?.homeTeam?.name
            awayTeam.text = fixtureData?.awayTeam?.name
            zerozero.text = "\(00)"
            homeGoal.text = "\(fixtureData?.score?.fullTime?.homeTeam ?? 0)"
            awayGoal.text = "\(fixtureData?.score?.fullTime?.awayTeam ?? 0)"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
