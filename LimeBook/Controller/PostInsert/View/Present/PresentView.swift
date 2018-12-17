//
//  OthersPostView.swift
//  LimeBook
//
//  Created by Lê Dũng on 8/26/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

class PresentView: MasterPostView {

    @IBOutlet weak var des: PostUnitView!
    @IBOutlet weak var name: PostUnitView!
    @IBOutlet weak var author: PostUnitView!

    @IBOutlet weak var imgSelectView: ImageSelectView!

    override func initStyle() {
        name.set("Tên sách")
        des.set("Nội dung")
    }
    
    override func getPostPakage() -> (BookInsert_Request, [ImageSelect])? {
        let request = BookInsert_Request()
        request.title = name.content()
        request.content = des.content()
        request.price = 0.0
        request.user_id = userInstance.user.id
        request.author = ""
        request.images = [];
        request.status = 0
        request.book_type = BookType.present.rawValue
        return(request,imgSelectView.getImage())        
    }
    
    override func getError() -> String? {
        
        var errorString : String?
        if(name.isEmpty())
        {
            errorString = "Vui lònh nhập tiêu đề"
        }
        if(des.isEmpty())
        {
            errorString = "Vui lòng nhập nội dung"
        }
        return errorString
    }
    
    override func clear() {
        name.clear()
        des.clear()
    }
}
