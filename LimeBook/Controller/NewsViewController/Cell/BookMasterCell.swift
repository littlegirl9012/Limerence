//
//  BookMasterCell.swift
//  LimeBook
//
//  Created by Lê Dũng on 10/9/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit
protocol BookInfoCellDelegate {
    func bookInfoExten(_ indexPath : IndexPath)
    func bookInfoUpdate(_ indexPath : IndexPath)
    func bookInfoUpdateScrollToTop(_ indexPath : IndexPath)
    func bookInfoUpdateScrollToBot(_ indexPath : IndexPath)
    func bookInfoReloadScrollToTop(_ indexPath : IndexPath)
    func bookDidSelectRate(_ indexPath : IndexPath)
    func commentViewRequestUserInterfaceFocusView(_ sender : Any?)
    
}

class BookMasterCell: UITableViewCell ,FeelingListViewDelegate, BookReactViewDelegate,CommentViewDelegate{
    func feelingListViewDidTouch(_ feel: Feelling) {
        book.feeling_target = feel
        //self.feelingView.setFistFeel(book.feeling_target)
        delegate.bookInfoReloadScrollToTop(self.indexPath)


    }
    
    var delegate : BookInfoCellDelegate!

    
    @IBOutlet weak var imgGroupView: ImageGroup1!
    @IBOutlet weak var userImageView: UserImageView!
    @IBOutlet weak var lbUsername: UILabel!
    @IBOutlet weak var lbContent: UILabel!

    
    @IBOutlet weak var feelingView: FeelingView!
    @IBOutlet weak var externalView2: UIView!
    @IBOutlet weak var externallHeight2: NSLayoutConstraint!
    @IBOutlet weak var extenalView: UIView!
    @IBOutlet weak var extenalHeight: NSLayoutConstraint!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var reactBar: ReactBarView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbDes: UILabel!
    
    @IBOutlet weak var feelingListHeight: NSLayoutConstraint!
    
    var indexPath : IndexPath!
    var book : Book!
    let queue = SerialOperationQueue()
    var bookInfoView = BookInfoView()
    var bookCommentView = CommentView()

    override func awakeFromNib() {
        super.awakeFromNib()
        reactBar.delegate = self;
        mainView.drawRadius(4)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    
    func set(_ book : Book, _ indexPath : IndexPath)
    {
        self.book = book
        self.indexPath = indexPath
        self.bookCommentView.book = self.book
        bookCommentView.delegate = self;
        reactBar.set(book)
    }

    func reactViewComment() {
        
        book.isDrawExtenalComment = !book.isDrawExtenalComment
        
        if(book.isDrawExtenalComment)
        {
            book.isDrawExtenal = false;
        }
        drawProcess()
        book.canDraw = false ;
        if(book.isDrawExtenalComment)
        {
            bookCommentView.loadComment {
                self.delegate.bookInfoUpdateScrollToBot(self.indexPath)
            }
        }
        else
        {
            self.delegate.bookInfoUpdate(self.indexPath)
        }
    }
    
    func reactViewDidTouchDetail()
    {
        book.isDrawExtenal = !book.isDrawExtenal
        
        if(book.isDrawExtenal)
        {
            book.isDrawExtenalComment = false;
        }
        drawProcess()
        book.canDraw = false ;
        if(book.isDrawExtenal)
        {
            delegate.bookInfoUpdateScrollToBot(self.indexPath)
        }
        else
        {
            delegate.bookInfoUpdate(self.indexPath)
        }
    }
    
    func clear()
    {
        clearExtenal()
        clearExtenalComment()
        if(feelingView != nil)
        {
            feelingView.clearSequence()
        }
    }
    func clearExtenal()
    {
        extenalView.removeSubsView()
        extenalHeight.constant = 0.0
    }
    
    func drawExtenalComment()
    {
        self.externalView2.removeSubsView()
        self.externalView2.addSubview(self.bookCommentView)
        self.externalView2.setLayout(self.bookCommentView)
    }
    
    func clearExtenalComment()
    {
        externalView2.removeSubsView()
        externallHeight2.constant = 0.0
        bookCommentView.clear()
    }
    func drawProcess()
    {
        if(book.isDrawExtenal)
        {
            drawExtenal()
        }
        else
        {
            clearExtenal()
        }
        
        if(book.isDrawExtenalComment)
        {
            drawExtenalComment()
        }
        else
        {
            clearExtenalComment()
        }
    }

    func reactViewDidLike() {
        let request = BookLike_Request()
        request.book_id = self.book.id
        if(self.book.is_like)
        {
            request.is_like = false ;
        }
        else
        {
            request.is_like = true
        }
        
        request.user_id = userInstance.user.id
        services.bookLike(request, success: { (response) in
            self.book.updateReact(response)
            self.reactBar.set(self.book)
        }) { (errlr) in
        }
        
    }
    func drawExtenal()
    {
        extenalView.removeSubsView()
        extenalView.addSubview(bookInfoView)
        extenalView.setLayout(bookInfoView)
    }
    func commentViewRequestUserInterface() {
        delegate.bookInfoUpdate(self.indexPath)
    }
    func commentViewRequestUserInterfaceFocusView(_ sender: Any?) {
        delegate.commentViewRequestUserInterfaceFocusView(sender)
    }

    
    @IBAction func touchInAvatar(_ sender: Any) {
        if(book.user_id != userInstance.user.id)
        {
            let chat = ChatViewController()
            let user = User.init()
            user.aliasname = book.aliasname
            user.id = book.user_id
            chat.target = user;
            viewController()?.push(chat)
        }

    }
    
    func reactViewStart() {
    }

}
