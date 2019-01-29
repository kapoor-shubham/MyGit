//
//  GitTableViewCell.swift
//  MyGit
//
//  Created by Shubham Kapoor on 29/01/19.
//  Copyright © 2019 Shubham Kapoor. All rights reserved.
//

import UIKit

class GitTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var languageNameLabel: UILabel!
    @IBOutlet weak var watchersCountLabel: UILabel!
    @IBOutlet weak var forksCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
