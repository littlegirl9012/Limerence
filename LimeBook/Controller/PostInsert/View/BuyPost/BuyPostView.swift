//
//  BuyPostView.swift
//  LimeBook
//
//  Created by Lê Dũng on 8/26/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

class BuyPostView: MasterPostView {

    @IBOutlet weak var des: PostUnitView!
    @IBOutlet weak var name: PostUnitView!
    
    
    override func initStyle() {
        name.set("Tên sách")
        name.singleLine()
        des.set("Mô tả")
    }
    
    override func getPostPakage() -> (Mi, [ImageSelect])? {
        let request = BookInsert_Request()
        request.title = name.content()
        request.content = des.content()
        request.price = 0.0
        request.user_id = userInstance.user.id
        request.author = ""
        request.images = [];
        request.status = 0
        request.book_type = BookType.buy.rawValue
        return(request,[])
    }

    override func getError() -> String? {
        
        
        var errorString : String?
        if(name.isEmpty())
        {
            errorString = "Vui lònh nhập tiêu đề"
        }
        
        
        if(des.isEmpty())
        {
            errorString = "Vui lòng nhập mô tả"
        }
        return errorString
    }
    
    override func clear() {
        name.clear()
        des.clear()
    }

}
