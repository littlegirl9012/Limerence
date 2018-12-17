//
//  SellPostView.swift
//  LimeBook
//
//  Created by Lê Dũng on 8/26/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

class SellPostView: MasterPostView {
    @IBOutlet weak var name: PostUnitView!
    @IBOutlet weak var price: PostUnitView!
    
    @IBOutlet weak var des: PostUnitView!
 
    @IBOutlet weak var imgSelectView: ImageSelectView!


    override func initStyle() {
        name.set("Tên sách")
        name.singleLine()
        price.set("Giá")
        price.keyboard(.numberPad)
        price.singleLine()
        des.set("Mô tả")
    }
    override func getPostPakage() -> (Mi, [ImageSelect])? {
        let request = BookInsert_Request()
        request.title = name.content()
        request.content = des.content()
        request.price =  price.content().doubleValue()
        request.user_id = userInstance.user.id
        request.author = ""
        request.images = [];
        request.status = 0
        request.book_type = BookType.sell.rawValue
        return(request,imgSelectView.getImage())
    }

    
    override func getError() -> String? {
        

        var errorString : String?
        if(name.isEmpty())
        {
            errorString = "Vui lònh nhập tiêu đề"
        }
        
        if(price.isEmpty())
        {
            errorString = "Vui lònh nhập giá bán"
        }
        if(imgSelectView.getImage().count == 0)
        {
            errorString = "Vui chọn ảnh sách cần bán"
        }

        if(des.isEmpty())
        {
            errorString = "Vui lòng nhập mô tả"
        }
        return errorString
    }

    
    override func clear() {
        name.clear()
        price.clear()
        des.clear()
    }
}
