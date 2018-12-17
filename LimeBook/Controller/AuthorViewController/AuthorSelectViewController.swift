//
//  AuthorSelectViewController.swift
//  LimeBook
//
//  Created by Lê Dũng on 10/3/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit
protocol AuthorSelectViewDelegate {
    func authorDidSelect(_ value : Author)
}

class AuthorSelectViewController: MasterViewController, UITableViewDelegate, UITableViewDataSource, NavigationViewDelegate {

    
    
    func navigationViewClearTouch() {
        
    }
    
    
    @IBOutlet weak var tbView: UITableView!
    
    
    var delegate : AuthorSelectViewDelegate!
    
    var author : [Author] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tbView.setIdentifier("AuthorCell")
        navigationView.set(style: .back, title: "") {
            self.pop()
        }
        
        navigationView.enableSearch(true)
        navigationView.delegate = self;
        notifyInstance.addM(self, .bookAuthor, selector: #selector(authorSearchResult))
        navigationView.setSearchPlaholder("Nhập tên tác giả")
        navigationView.focus()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc func authorSearchResult(notify  : NSNotification)
    {
        let authorList = notify.object as! [Author]
        self.author.removeAll()
        self.author.append(contentsOf: authorList)
        self.tbView.reloadData()
    }
    
    func navigationViewSearching(_ searchText: String) {
        let request = AuthorSearch_Request()
        request.keyword = searchText.lossyValue()
        
        if(messageInstance.isConnected())
        {
            messageInstance.bookAuthor(request)
        }
        else
        {
            services.authorSearch(request, success: { (response) in
                self.author.removeAll()
                self.author.append(contentsOf: response)
                self.tbView.reloadData()
            }) { (error) in
                
            }
        }
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        messageInstance.reconnect()

    }

    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate.authorDidSelect(self.author[indexPath.row])
        pop()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return author.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbView.dequeueReusableCell(withIdentifier: "AuthorCell") as! AuthorCell
        cell.set(self.author[indexPath.row])
        return cell
    }
    

}
