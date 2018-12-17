//
//  GeneralPostView.swift
//  LimeBook
//
//  Created by Lê Dũng on 8/25/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

class GeneralPostView: MasterPostView{

    @IBOutlet weak var des: PostUnitView!
    @IBOutlet weak var name: PostUnitView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var imgSelectView: ImageSelectView!
    override func initStyle() {

        name.set("Tên sách")
        des.set("Mô tả")
        name.singleLine()

        view.backgroundColor = template.backgroundColor
    }
    override func getPostPakage() -> (BookInsert_Request, [ImageSelect])? {
        let request = BookInsert_Request()
        request.title = name.content()
        request.content = des.content()
        request.price = 0.0
        request.user_id = userInstance.user.id
        request.author = ""
        request.status = 0
        request.book_type = BookType.general.rawValue
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
