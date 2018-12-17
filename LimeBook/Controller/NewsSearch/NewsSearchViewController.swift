//
//  NewsSearchViewController.swift
//  LimeBook
//
//  Created by Lê Dũng on 11/3/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit






class NewsSearchViewController: MasterViewController, UITableViewDelegate, UITableViewDataSource , NavigationViewDelegate{
    func navigationViewClearTouch() {
    }
    
    
    @IBOutlet weak var tbView: UITableView!
    var news : [Book] = []
    
    @IBOutlet weak var tfSearch: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        tbView.setIdentifier("NewsSearchCell")
        tbView.backgroundColor = template.backgroundColor
        
        navigationView.set(style: .back, title: "Tìm kiếm") { [weak self] in
            self?.pop()
        }
        
        notifyInstance.addM(self, .newsSearch, selector: #selector(newsSearchResult))
        
        navigationView.setSearchPlaholder("Nhập nội dung tìm kiếm")
        navigationView.focus()
        navigationView.enableSearch(true)
        navigationView.delegate = self ;

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //messageInstance.reconnect()
        
    }

    
    func navigationViewSearching(_ searchText: String) {
        
        if(searchText.trim().length == 0)
        {
            self.news.removeAll()
            self.tbView.reloadData()
            return;
        }
        let request = NewsSearch_Request()

        if(messageInstance.isConnected())
        {
            request.keyword = searchText.lossyValue()
            messageInstance.newsSearch(request)
        }
        else
        {
            weak var weakself = self;
            
            let request = BookSearch_Request()
            request.keyword = searchText.trim()
            services.bookSearchAll(request, success: { (response) in
                weakself?.news.removeAll()
                weakself?.news.append(contentsOf: response)
                weakself?.tbView.reloadData()
            }) { (error) in
                
            }
            
            
        }
        
    }

    
    @objc func newsSearchResult(notify : NSNotification)
    {
        DispatchQueue.main.async {[weak self] in
            let result = notify.object as! [Book]
            self?.news.removeAll()
            self?.news.append(contentsOf: result)
            self?.tbView.reloadData()
        }
    }
    
    deinit {
        print("-----------------------EndView")
    }
    @IBAction func searchChange(_ sender: Any)
    {
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbView.dequeueReusableCell(withIdentifier: "NewsSearchCell") as! NewsSearchCell
        cell.set(book: self.news[indexPath.row], indexPath: indexPath)
        return cell 
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        navigationView.dissmissSearch()
        let request = BookDetail_Request()
        request.book_id = self.news[indexPath.row].id
        weak var weakself = self;
        services.bookDetail(request, success: { (response) in
            
            if(response.book_type_n == .web)
            {
                let detail = NewsDetailWebViewController()
                detail.book = response
                weakself?.push(detail)
            }
            else
            {
                let detail = NewsDetailViewController()
                detail.book = response
                weakself?.push(detail)
            }
        }) { (errror) in
            
        }
    }

}
