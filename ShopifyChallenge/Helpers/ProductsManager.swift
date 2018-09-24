//
//  ProductsManager.swift
//  ShopifyChallenge
//
//  Created by Javier Xing on 2018-09-23.
//  Copyright © 2018 Javier Xing. All rights reserved.
//

import Foundation

class ProductsManager: NSObject {
    private static var sharedFactory: ProductsManager = {
        let sharedFactory = ProductsManager()
        
        
        return sharedFactory
    }()
    
    //Mark: - Singleton Method
    class func shared() -> ProductsManager {
        return sharedFactory
    }
    
    func fetchProducts(completion: @escaping (_ products: [Product]) -> Void) {
        let sessionConfig = URLSessionConfiguration.default
        
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        
        //Provided Shopfiy URL
        guard let productsURL = URL(string: "https://shopicruit.myshopify.com/admin/products.json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6" ) else {return}
        
        var request = URLRequest(url: productsURL)
        request.httpMethod = "GET"
        
        //Start downloading task
        let task = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            if (error == nil) {
                //Success
                let statusCode = (response as! HTTPURLResponse).statusCode
                print("URL Session Task Succeeded: HTTP \(statusCode)")
            } else {
                //Failure
                print("URL Session Task Failed: %@", error!.localizedDescription);
            }
            
        //JSON Parsing
            var json: Any?
            do {
                json = try JSONSerialization.jsonObject(with: data!)
            }
            catch {
                print(#line, error.localizedDescription)
            }
            
            guard let productInfoDictionary = json as? Dictionary<String, Any>,
                let productInfo = productInfoDictionary["products"] as? [Dictionary<String, Any>] else {
                    return
            }
            
            var products: [Product] = []
            for productDict in productInfo {
                let currentProduct = Product(with: productDict)
                if let product = currentProduct {
                    products.append(product)
                }
            }
            //Finished creating all the products
            completion(products)
        }
        task.resume()
        session.finishTasksAndInvalidate()
    }
    
    //Mark: - Functions
    
}

