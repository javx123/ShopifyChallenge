//
//  Product.swift
//  ShopifyChallenge
//
//  Created by Javier Xing on 2018-09-23.
//  Copyright © 2018 Javier Xing. All rights reserved.
//

import Foundation
import UIKit

class Product: NSObject {
    var id: Int
    var name: String
    var vendor: String
    var tags: [String]
    var imageURLString: String?
    
    init?(with dictionary: Dictionary <String, Any>) {
        guard let productID = dictionary["id"] as? Int,
            let productName = dictionary["title"] as? String,
            let productVendor = dictionary["vendor"] as? String,
            let productTags = dictionary["tags"] as? String else {
            return nil
        }
        
        id = productID
        name = productName
        vendor = productVendor
        //Creating an array of tags from the input string tag
        tags = productTags.components(separatedBy: ", ")
        
        if let productImageDictionary = dictionary["image"] as? Dictionary<String, Any>, let productImageURLString = productImageDictionary["src"] as? String {
            imageURLString = productImageURLString
        }
    }
}
