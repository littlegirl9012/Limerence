//
//  AdminViewController.swift
//  LimeBook
//
//  Created by Lê Dũng on 11/29/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

class AdminViewController: MasterViewController {

    
    var books : [Book] = []
    var  j = 0;

    override func viewDidLoad() {
        super.viewDidLoad()

        
        weak var weakself = self;

        navigationView.set(style: .back, title: "Tiki") {
            weakself?.pop()
        }
        
        callList()
        
    }

    func callList()
    {
        j = 0 ;
        weak var weakself = self;

        services.adminTikiList(success: { (response) in
            weakself?.books.append(contentsOf: response)
            weakself?.requestFullData()
        }) { (error) in
            
        }

    }
    /*
     <a href="http://railsmachine.com/" class="sponsor" id="rails-machine" target="_blank">RailsMachine</a>
     [doc search:@"//a[@class='sponsor']"];
     
     
     <p class="special-price-item" data-value="209950" id="p-specialprice">
     
     
     let price_id  = item.search(withXPathQuery: "//span['price-label']")

     
     */
    
    func requestFullData()
    {
        
        for item in books
        {
            services.customRequest(url: item.link, success: { (response) in
                
                let first = "<div class=\"row flex\"" ;
                var subString = response.slice(from: first, to: "<div class=\"question-answer-form\">")
                if(subString != nil)
                {
                    subString = first + subString!
                    let cafe: Data? = subString!.data(using: .utf8) // non-nil
                    
                    let doc  =  TFHpple.init(xmlData: cafe)
                    
                    let priceArray = doc?.peekAtSearch(withXPathQuery: "//p[@class=\"special-price-item\"]")  as TFHppleElement?
                    
                    if(priceArray != nil)
                    {
                        var priceValue = priceArray!.attributes["data-value"];
                        let request = BookTikiUpdatePrice_Request()
                        request.tiki_id = item.tiki_id
                        request.sell_price = (priceValue as! String).doubleValue()
                        services.adminTikiUpdatePrice(request, success: {
                            self.processRecall()
                        }, failure: { (error) in
                            
                        })
                        
                    }
                    else
                    {
                        self.processRecall()
                    }

                }
                else
                {
                    self.processRecall()

                }
                
            }) { (error) in
                self.processRecall()

            }

        }
    }
    
    func processRecall()
    {
        j = j + 1
        if(j == self.books.count - 1 )
        {
            self.books.removeAll()

            audioInstance.playSound()
            callList()
        }
    }
}
