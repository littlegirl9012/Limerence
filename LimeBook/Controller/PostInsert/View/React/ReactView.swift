//
//  OthersPostView.swift
//  LimeBook
//
//  Created by Lê Dũng on 8/26/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

class ReactView: MasterPostView , PostSelectViewDelegate, BookSelectViewControllerDelegate{

    @IBOutlet weak var name: PostUnitView!
    
    @IBOutlet weak var ratingView: RatingView!
    @IBOutlet weak var react: PostUnitView!
    @IBOutlet weak var note: PostUnitView!
    @IBOutlet weak var postSelectView: PostSelectView!
    @IBOutlet weak var imgSelectView: ImageSelectView!
    var bookSelect : Book!
    
    override func initStyle() {

        react.setTitleRequired("Cảm nhận của bạn")
        note.set("Trích đoạn hay trong sách")
        postSelectView.set("Chọn sách")
        postSelectView.setType(.select)
        self.ratingView.set("Điểm số ")
        postSelectView.delegate = self;
    }
    
    func postSelectViewInvoke(_ type: PostSelectType, sender: PostSelectView) {
        if(type == .select)
        {
            let book = BookSelectViewController()
            book.delegate = self;
            viewController()?.push(book)
        }
    }
    
    func bookSelectViewDidSelect(_ book: Book) {
        self.bookSelect = book
        self.postSelectView.set(title: book.title)
    }
    
    
    override func getPostPakage() -> (FeelingInsert_Request, [ImageSelect])? {
        let request = FeelingInsert_Request()
        request.book_id = self.bookSelect.id
        request.content = react.content()
        request.user_id = userInstance.user.id
        request.intro = ""
        request.note = note.content()
        request.image = "";
        request.rate = Double(self.ratingView.rateView.value)
        return(request,imgSelectView.getImage())
    }
    
    override func getError() -> String? {
        
        var errorString : String?
        if(react.isEmpty())
        {
            errorString = "Vui lòng nhập nội dung"
        }
        
        if(self.bookSelect == nil)
        {
            errorString = "Vui lòng chọn sách"

        }
        return errorString
    }
    
    override func clear() {
    }
}
