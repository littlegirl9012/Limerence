//
//  ReactBarView.swift
//  LimeBook
//
//  Created by Lê Dũng on 9/27/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

protocol BookReactViewDelegate {
    func reactViewDidLike()
    func reactViewDidTouchDetail()
    func reactViewComment()
    func reactViewStart()



}
class SerialOperationQueue: OperationQueue
{
    override init()
    {
        super.init()
        maxConcurrentOperationCount = 1
    }
}


class ReactBarView: GreenView, ReactUserDelegate {
    @IBOutlet weak var heartView: ReactUserView!
    @IBOutlet weak var commentView: ReactUserView!
    
    
    var delegate: BookReactViewDelegate!
    override func initStyle() {
        heartView.delegate = self;
        commentView.delegate = self

        heartView.setImage("unhear".image(), "")
        commentView.setImage("re_cover".image(), "")
    }
    func set(_ book : Book)
    {
        if(book.book_type_n == .library)
        {
            btDetail.isHidden = false ;
        }
        else
        {
            btDetail.isHidden = true ;
        }

        if(book.is_like)
        {
            heartView.setImage("heart".image(), String(book.like_count))
        }
        else
        {
            heartView.setImage("unhear".image(), String(book.like_count))
        }

        commentView.setImage("Book_Comment".image(), String(book.comment_count))
    }
    
    @IBOutlet weak var btDetail: UIButton!
    @IBAction func rightTouch(_ sender: Any) {
        
    delegate.reactViewDidTouchDetail()
    }
    func reactUserTouch(_ sender: ReactUserView) {
        if(delegate == nil)
        {
            return
        }
        if(sender == heartView)
        {
            delegate.reactViewDidLike()
        }
        else if(sender == commentView)
        {
            delegate.reactViewComment()
        }
        else
        {
        }

    }

}
