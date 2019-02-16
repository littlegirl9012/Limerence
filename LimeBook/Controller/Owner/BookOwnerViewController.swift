//
//  BookOwnerViewController.swift
//  MiBook
//
//  Created by Lê Dũng on 2/16/19.
//  Copyright © 2019 limerence. All rights reserved.
//

import UIKit

class BookOwnerViewController: MasterViewController, UITableViewDelegate,UITableViewDataSource {
    var book : Book!
    var user : [User] = []

    @IBOutlet weak var tbView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tbView.setIdentifier("BookOwnerCell")
        loadData()
        
        
        
        weak var weakself = self;
        navigationView.set(style: .back, title: "Thành Viên Có Sách") {
            weakself?.pop()
        }
    }

    func loadData()
    {
        let request = BookUserList_Request()
        request.book_id = book.id
        weak var weakself = self;
        services.bookUserList(request, success: { (response) in
            weakself?.user.append(contentsOf: response)
            weakself?.tbView.reloadData()
        }) { (error) in
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tbView.dequeueReusableCell(withIdentifier: "BookOwnerCell") as! BookOwnerCell
        
        cell.set(user[indexPath.row])
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0)
        {
          return 0
        }
        return user.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chat = ChatViewController()
        chat.target = user[indexPath.row];
        push(chat)
    }
}
