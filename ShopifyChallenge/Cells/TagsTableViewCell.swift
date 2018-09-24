//
//  TagsTableViewCell.swift
//  ShopifyChallenge
//
//  Created by Javier Xing on 2018-09-23.
//  Copyright © 2018 Javier Xing. All rights reserved.
//

import UIKit

class TagsTableViewCell: UITableViewCell {

    @IBOutlet weak var tagName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configCell(tagName: String) {
        self.tagName.text = tagName
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
