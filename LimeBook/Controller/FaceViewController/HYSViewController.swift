//
//  HYSViewController.swift
//  LimeBook
//
//  Created by Lê Dũng on 9/24/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

class HYSViewController: MasterViewController , UIWebViewDelegate{

    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        
        navigationView.set(style: .back, title: "Group HYS") {
            self.pop()
        }
        
        
        webView.delegate = self;
        super.viewDidLoad()
        webView.loadRequest(URLRequest.init(url: URL.init(string: "https://www.facebook.com/groups/hoiyeusachtn/")!))
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        self.activity.startAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        self.activity.stopAnimating()
    }

}
