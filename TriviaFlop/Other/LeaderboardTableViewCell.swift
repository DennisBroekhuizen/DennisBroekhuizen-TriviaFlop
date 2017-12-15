//
//  LeaderboardTableViewCell.swift
//  TriviaFlop
//
//  Created by Dennis Broekhuizen on 13-12-17.
//  Copyright © 2017 Dennis Broekhuizen. All rights reserved.
//

import UIKit

// Custom TableViewCell
class LeaderboardTableViewCell: UITableViewCell {

    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
