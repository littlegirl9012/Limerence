//
//  UserSearchEngineViewController.swift
//  LimeBook
//
//  Created by Lê Dũng on 10/25/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

class UserSearchEngineViewController: MasterViewController, UITableViewDelegate, UITableViewDataSource , NavigationViewDelegate{

    
    func navigationViewClearTouch() {
        navigationView.tfSearcg.text = ""
        users.removeAll()
        tbView.reloadData()
    }

    @IBOutlet weak var tbView: UITableView!
    
    var users : [User] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationView.setSearchPlaholder("Nhập số điện thoại")
        navigationView.focus()
        navigationView.enableSearch(true)
        navigationView.delegate = self ;
        
        notifyInstance.addM(self, .userSearch, selector: #selector(newsSearchResult))
        
        weak var weakself = self
        self.navigationView.set(style: .back, title: "") {
            weakself?.pop()
        }

        tbView.setIdentifier("UserSearchCell")
        tbView.backgroundColor = UIColor.white
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        messageInstance.reconnect()

    }
    
    func navigationViewSearching(_ searchText: String) {
        
        
        if(searchText.trim().length < 8)
        {
            self.users.removeAll()
            self.tbView.reloadData()
            return;
        }
        let request = UserSearch_Request()
        request.keyword = searchText.lossyValue()
        
        services.userSearch(request, success: { (response) in
            DispatchQueue.main.async {[weak self] in
                self?.users.removeAll()
                self?.users.append(contentsOf: response)
                self?.tbView.reloadData()
            }

        }) { (error) in
            
        }
//        messageInstance.userSearch(request)
        
        
        
    }
    
    
    @objc func newsSearchResult(notify : NSNotification)
    {
        DispatchQueue.main.async {[weak self] in
            let result = notify.object as! [User]
            
            self?.users.removeAll()
            self?.users.append(contentsOf: result)
            self?.tbView.reloadData()
            
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbView.dequeueReusableCell(withIdentifier: "UserSearchCell") as! UserSearchCell
        cell.set(self.users[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chat = ChatViewController()
        chat.target = self.users[indexPath.row]
        push(chat)
    }

}

