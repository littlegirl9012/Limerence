//
//  BookTradingViewController.swift
//  LimeBook
//
//  Created by Lê Dũng on 12/4/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

class BookTradingViewController: MasterViewController , UITableViewDelegate,UITableViewDataSource, BookTradingViewDelegate{
    @IBOutlet weak var tbView: UITableView!
    @IBOutlet weak var btAdd: UIButton!

    var books : [Book] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        btAdd.backgroundColor = template.dangerColor
        btAdd.drawRound()

        tbView.backgroundColor = template.backgroundColor
        
        
        tbView.setIdentifier("BookTradingCell")
        let request = BookTrading_Request()
        request.load_type = 0
        request.last_date = ""
        
        weak var weakself = self;

        navigationView.set(style: .back, title: "Tiệm Sách") {
            weakself?.pop()
        }
        
        services.bookTrading(request, success: { (response) in
            weakself?.books.append(contentsOf: response)
            weakself?.tbView.reloadData()
        }) { (errror) in
            
        }
        
        cartUpdateItem()
        notifyInstance.add(self, .cartUpdateItem, selector: #selector(cartUpdateItem))
    }

    @objc func cartUpdateItem()
    {
        btAdd.isHidden = (cart.order.count == 0)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbView.dequeueReusableCell(withIdentifier: "BookTradingCell") as! BookTradingCell
        cell.set(books[indexPath.row])
        return cell
    }

    deinit {
        notifyInstance.remove(self)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let book = self.books[indexPath.row]
        let infoView = BookTradingView()
        infoView.drawRadius(4)
        infoView.setBook(book)
        view.alertBox(infoView, ratio: 0.90)
        infoView.delegate = self
    }
    
    func bookTradingAddSuccess() {
        view.hideAlertBox()
        view.info(title: "Thông báo", desc: "Đã thêm sách vào giỏ hàng.")
    }
    
    func bookTradingMessageTouch(_ book: Book) {
        view.hideAlertBox()
        let user = User()
        user.aliasname = book.aliasname
        user.id = book.user_id
        let chat = ChatViewController()
        chat.target = user
        push(chat)

    }
}
