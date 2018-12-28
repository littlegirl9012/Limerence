//
//  BookViewController.swift
//  LimeBook
//
//  Created by Lê Dũng on 8/29/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

class BookViewController: MasterViewController, UITableViewDelegate, UITableViewDataSource, BookAddActionViewDelegate
{
    @IBOutlet weak var tbView: UITableView!
    var user : User!
    var book  : [Book] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return book.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbView.dequeueReusableCell(withIdentifier: "BooksCell") as! BooksCell
        cell.set(book: book[indexPath.row], indexPath: indexPath)
        return cell
    }
    
    @IBAction func addAction(_ sender: Any)
    {
        let bookSelect = BookSelectViewController()
        bookSelect.isTake = true ;
        push(bookSelect)
    }
    
    func loadData()
    {
        let reuquest = BookUser_Request()
        reuquest.last_id = 0
        reuquest.user_id = user.id
        weak var weakself = self;
        services.bookUser(reuquest, success: { (response) in
            weakself?.book.removeAll()
            weakself?.book.append(contentsOf: response)
            weakself?.tbView.reloadData()
        }) { (error) in
            
        }
    }
    @IBOutlet weak var btAdd: UIButton!
    @IBOutlet weak var btChat: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weak var weakself = self;

        navigationView.set(style: .back, title: "Tủ sách của \(user.aliasname)") {
            weakself?.navigationController?.popViewController(animated: false)
        }
        tbView.setIdentifier("BooksCell")
        
        self.navigationView.bringSubview(toFront: self.btAdd)
        self.btAdd.isHidden = !(user.isMe())
        self.btChat.isHidden = user.isMe()
        btChat.drawRound()

    }
    
    @IBAction func messageTouch(_ sender: Any)
    {
        
        let chat = ChatViewController()
        chat.target = user
        self.push(chat)

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }

    
    deinit {
        print("Deinit----------\(nibName ?? "Deinit")")
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(user.isMe())
        {
            let add = BookDetailViewController()
            add.book = self.book[indexPath.row]
            push(add)
        }
    }
    
    func bookAddGeneral() {
        push(BookAddViewController())
    }
    
    func bookAddFromMibook() {
        view.hideAlertBox()
        let bookSelect = BookSelectViewController()
        bookSelect.isTake = true ;
        push(bookSelect)
    }

}
