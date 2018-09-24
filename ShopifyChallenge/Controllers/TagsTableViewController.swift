//
//  TagsTableViewController.swift
//  ShopifyChallenge
//
//  Created by Javier Xing on 2018-09-23.
//  Copyright © 2018 Javier Xing. All rights reserved.
//

import UIKit

class TagsTableViewController: UITableViewController {
    
    var tags: [String] = []
    {
        didSet{
            if let tableView = self.tableView {
                DispatchQueue.main.async {
                    tableView.reloadData()
                }
            }
        }
    }
    
    var products: [Product] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        //Have seperators span whole tableview
        self.tableView.separatorInset = UIEdgeInsets.zero
        self.tableView.layoutMargins = UIEdgeInsets.zero
        self.tableView.separatorColor = UIColor.init(red: 150, green: 191, blue: 72)
        
        pullProductsData()
    }
    
    func pullProductsData() {
        ProductsManager.shared().fetchProducts { (products) in
            self.products = products
            
            //Create an array with all the tags
            var productTagsArray: [String] = []
            for product in products {
                productTagsArray.append(contentsOf: product.tags)
            }
            
            //ProductTagsArray is now a huge list of duplicate tags
            //Change to set and back to array to remove duplicates, since order doesn't really matter in this case
            let tagsArray = Array(Set(productTagsArray))
            print(tagsArray)
            self.tags = tagsArray
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.tags.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TagsCell", for: indexPath)
        // Configure the cell...
        if let cell = cell as? TagsTableViewCell {
            let currentTag: String = self.tags[indexPath.row]
            cell.configCell(tagName: currentTag)
        }
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "taggedProducts") {
            
            if let indexPath = tableView.indexPathForSelectedRow, let productsVC = segue.destination as? ProductsTableViewController {
                let productsTag = self.tags[indexPath.row]
        
                var selectedProducts: [Product] = []
                for product in self.products {
                    if (product.tags.contains(productsTag)) {
                        selectedProducts.append(product)
                    }
                }
                productsVC.products = selectedProducts
                productsVC.title = productsTag
            }
        }
        
    }

}

//Mark: - Convenience extensions

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
}
