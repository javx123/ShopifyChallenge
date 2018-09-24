//
//  ProductsTableViewCell.swift
//  ShopifyChallenge
//
//  Created by Javier Xing on 2018-09-24.
//  Copyright © 2018 Javier Xing. All rights reserved.
//

import UIKit
import SDWebImage

class ProductsTableViewCell: UITableViewCell {

    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var vendorName: UILabel!
    @IBOutlet weak var productTags: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configCell(_ product:Product) {
        self.productName.text = product.name
        self.vendorName.text = product.vendor
        self.productTags.text = product.tags.joined(separator: ", ")
        if let productImageString = product.imageURLString {
            productImage.sd_setImage(with: URL(string: productImageString))
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
