//
//  ProductViewController.swift
//  ShopifyChallenge
//
//  Created by Javier Xing on 2018-09-24.
//  Copyright © 2018 Javier Xing. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController, UINavigationBarDelegate {

    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var navTitle: UINavigationItem!
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productVendor: UILabel!
    @IBOutlet weak var productTags: UILabel!
    @IBOutlet weak var productID: UILabel!
    
    var product: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navBar.delegate = self
        
        configureProductView()
    }
    
    func configureProductView() {
        if let product = self.product, let productImageString = product.imageURLString {
            self.navTitle.title = product.name
            self.productName.text = product.name
            self.productVendor.text = product.vendor
            self.productTags.text = product.tags.joined(separator: ", ")
            self.productID.text = String(product.id)
            productImage.sd_setImage(with: URL(string: productImageString))
        }
    }

    //Mark : - Close
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //Mark : - NavBar delegate functions
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }

}
