//
//  NewsDetailWebViewController.swift
//  LimeBook
//
//  Created by Lê Dũng on 11/23/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

class NewsDetailWebViewController: MasterViewController {

    var book : Book!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        weak var weakself = self;
        self.navigationView.set(style: .back, title: "Chi Tiết") {
            weakself?.pop()
        }
        
        
        
        services.wpRequestPost(id: String(book.wp_id), success: { (response) in
            
            let dictionary = response as! NSDictionary
            let content = dictionary.value(forKey: "content") as! NSDictionary
            let render = content.value(forKey: "rendered") as! String
            
            if let path = Bundle.main.path(forResource: "template", ofType: "html") {
                do {
                    var text = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
                    text = text.replacingOccurrences(of: "MICONTENT", with: render)
                    text = text.replacingOccurrences(of: "MITITLE", with: self.book.title.lowercased().capitalizingFirstLetter())
                    self.webView.loadHTMLString(text, baseURL: nil)
                } catch {
                }
            } else {
            }

            
        }) { (error) in
            
        }

        
        
//        self.webView.loadRequest(URLRequest.init(url: URL.init(string: book.wp_link)!))
//
//
//
        
        
    }

    @IBOutlet weak var webView: UIWebView!
    
}
