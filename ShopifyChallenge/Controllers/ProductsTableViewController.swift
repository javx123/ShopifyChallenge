//
//  ProductsTableViewController.swift
//  ShopifyChallenge
//
//  Created by Javier Xing on 2018-09-24.
//  Copyright © 2018 Javier Xing. All rights reserved.
//

import UIKit

class ProductsTableViewController: UITableViewController {
    
    var tag: String?
    var products: [Product] = []
    {
        didSet{
            if let tableView = self.tableView {
                DispatchQueue.main.async {
                    tableView.reloadData()
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.separatorInset = UIEdgeInsets.zero
        self.tableView.layoutMargins = UIEdgeInsets.zero
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.products.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "productsCell", for: indexPath)
        // Configure the cell...
        if let cell = cell as? ProductsTableViewCell {
            let currentProduct: Product = self.products[indexPath.row]
            cell.configCell(currentProduct)
        }
        return cell
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "product") {
            if let indexPath = tableView.indexPathForSelectedRow, let productVC = segue.destination as? ProductViewController {
                let selectedProduct = self.products[indexPath.row]
                
                productVC.product = selectedProduct
            }
        }
    }
    

}
