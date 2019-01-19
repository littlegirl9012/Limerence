//
//  NewsDetailViewController.swift
//  LimeBook
//
//  Created by Lê Dũng on 8/29/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit





class NewsDetailViewController: MasterViewController,NewsCommentCellDelegate, UITableViewDelegate, UITableViewDataSource, ComposeViewDelegate, BookInfoDetailCellDelegate, BookActionViewDelegate, BookTakeUserViewDelegate, BookFeelCellDelegate, ReportViewDelegate{
    
    @IBOutlet weak var btWarning: UIButton!
    @IBOutlet weak var compose: ComposerView!
    @IBOutlet weak var btAction: UIButton!
    var book  : Book!
    var bookDetail : Book! = Book()
    var fromBookStore = false
    var comments : [Comment] = []
    var feel  : [Feelling] = []
    @IBOutlet weak var tbView: GreenTableView!
    var identifier = "BookInfoDetailCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        tbView.setIdentifier("BookFeelCell")
        tbView.setIdentifier("NewsCommentCell")

        
        if(self.book.book_type_n == .library)
        {
            identifier = "BookInfoDetailCell"
        }
        else
        {
            identifier = "BookOthersDetailCell"
        }
        tbView.setIdentifier(identifier)
        
        
        tbView.backgroundColor = template.backgroundColor
        
        tbView.reloadDataSmoothly()
        
        weak var weakself = self
        self.navigationView.set(style: .back, title: "Chi Tiết") {
            weakself?.pop()
        }
        let footer = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 1))
        footer.backgroundColor = UIColor.clear
        tbView.tableFooterView = footer
        
        let header = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 1, height: 1))
        tbView.tableHeaderView = header
        header.backgroundColor = template.backgroundColor
        compose.delegate = self;
        loadDetail()
        
        if(self.book.book_type_n == .library)
        {
            navigationView.bringSubview(toFront: self.btAction)
        }
        
        if(book.user_id != userInstance.user.id)
        {
            navigationView.bringSubview(toFront: self.btWarning)
        }

    }
    deinit {
        compose.removeObser()
        print("Deinit----------\(nibName ?? "Deinit")")
    }
    func loadDetail()
    {
        let request = BookDetail_Request()
        request.book_id = self.book.id
        request.user_id = userInstance.user.id;
        self.tbView.delegate = self;
        self.tbView.dataSource = self;
        weak var weakself = self

        services.bookDetail(request, success: { (response) in

            DispatchQueue.main.async {
                weakself?.bookDetail = response
                weakself?.tbView.reloadData()

            }
        }) { (error) in

        }
    }
    
    @IBAction func messageTouch(_ sender: Any)
    {
    }
    
    func bookUnitUserTouch(_ id: Int)
    {
    }
    @IBAction func actionTouch(_ sender: Any)
    {
        let bookActionView = BookActionView.init()
        bookActionView.delegate = self;
        bookActionView.set(self.book)
        view.alertBox(bookActionView, ratio: 0.94)
    }
    
    func composeDidSend(_ message: LimeMessage)
    {
        endEdit()
        let request = BookCommentInsert_Request()
        request.user_id = userInstance.user.id
        request.parent_id = -1
        request.target_id = book.id
        request.content = message.content
        weak var weakself = self

        services.bookCommentInsert(request, success: { (response) in
            DispatchQueue.main.async {
                weakself?.bookDetail.comment_model.append(contentsOf: response)
                weakself?.tbView.insertRows(at: [IndexPath.init(item: (weakself?.bookDetail.comment_model.count)! - 1, section: 2)], with: UITableViewRowAnimation.fade)
                weakself?.scrollToBotton()
            }
        }) { (error) in
            
        }
    }
    func scrollToBotton()
    {
        if(self.bookDetail.comment_model.count > 0)
        {
            tbView.scrollToRow(at: IndexPath.init(row: self.bookDetail.comment_model.count-1, section: 2), at: .bottom, animated: true)
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.section == 0)
        {
            let cell = tbView.dequeueReusableCell(withIdentifier:identifier) as! BookInfoDetailCell
            cell.delegate = self;
            cell.set(self.book)
            cell.delegate = self;
            return cell

        }
        else if(indexPath.section == 1)
        {
            let cell = tbView.dequeueReusableCell(withIdentifier:"BookFeelCell") as! BookFeelCell
            cell.set(bookDetail.feel_model[indexPath.row])
            cell.delegate = self;
            return cell
        }

        else
        {
            let cell = tbView.dequeueReusableCell(withIdentifier:"NewsCommentCell") as! NewsCommentCell
            cell.set(bookDetail.comment_model[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0)
        {
            return 1
        }
        else if(section == 1)
        {
            return bookDetail.feel_model.count
        }

        else
        {
            return bookDetail.comment_model.count
        }
    }
    
    func commentDidSelect(_ value: Comment)
    {
        
    }

    func bookInfoDetailCellRequestUploadCell() {
        self.tbView.beginUpdates()
        self.tbView.endUpdates()
        
    }
    
    func bookActionTake() {
        let request = BookTake_Request()
        request.book_id = self.book.id
        request.user_id = userInstance.user.id
        
        weak var weakself = self;
        services.bookTake(request, success: {
            weakself?.view.info(title: "Thành công", desc: "Đã thêm sách vào tủ của bạn")
        }) { (error) in
            
        }
    }
    
    func bookTakeDidSelectUser(_ user: User) {
        let chat = ChatViewController()
        chat.target = user
        push(chat)
    }
    
    func bookActionUserList()
    {
        let takeView = BookTakeUserView.init(frame: CGRect.init())
        takeView.delegate = self;
        view.alertBox(takeView, ratio: 0.86)
        takeView.loadData(self.book)
    }
    
    func bookFeelCellTouch(_ feel: Feelling)
    {
        if(userInstance.user.id != feel.user_id)
        {
            let chat = ChatViewController()
            let user = User()
            user.id = feel.user_id
            user.avatar = feel.avatar
            user.aliasname = feel.aliasname
            user.processMedia()
            chat.target = user
            push(chat)
        }
    }
    @IBAction func reportTouch(_ sender: Any) {
        let reportView = ReportView.init()
        reportView.delegate = self;
        view.alertBox(reportView)
    }
    
    func reportViewDidClose() {
        view.hideAlertBox()
    }
    
    func reportViewDidSend(_ content: String) {
        view.hideAlertBox()
        let request = BookReport_Request()
        request.user_id = userInstance.user.id
        request.book_id = self.book.id
        request.content = content
        
        weak var weakself = self;
        services.bookReport(request, success: {
            weakself?.view.info(title: "Thông Báo", desc: "Gửi báo cáo thành công. Chúng tôi sẽ xem xét yêu cầu của bạn")
        }) { (error) in
            
        }
    }
    
    func bookInfoDetailCellUserTouch(_ book: Book) {
        if(userInstance.user.id != book.user_id)
        {
            let chat = ChatViewController()
            let user = User()
            user.id = book.user_id
            user.avatar = book.avatar
            user.aliasname = book.aliasname
            user.processMedia()
            chat.target = user
            push(chat)
        }
    }
}
