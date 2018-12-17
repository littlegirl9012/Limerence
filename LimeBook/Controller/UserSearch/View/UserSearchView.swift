//
//  UserSearchView.swift
//  LimeBook
//
//  Created by Lê Dũng on 8/25/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

protocol UserSearchViewDelegate {
    func userSearchViewAdd()
    func userSearchViewMessage()
}

class UserSearchView: GreenView {

    @IBOutlet weak var userImageView: UserImageView!
    @IBOutlet weak var gender: UserUnitView!
    @IBOutlet weak var phone: UserUnitView!
    @IBOutlet weak var name: UserUnitView!
    
    @IBOutlet weak var btChat: UIButton!
    @IBOutlet weak var btAdd: UIButton!
    
    var delegate : UserSearchViewDelegate!
    
    var user : User!
    func set(_ user : User)
    {
        phone.set("Điện thoại", user.username)
        name.set("Tên", user.aliasname)
        gender.set("Giới tính", user.genderDisplay())
        userImageView.set(user.aliasname, url: user.avatar)
        self.user = user
    }
    
    @IBAction func smsAction(_ sender: Any)
    {
        let chat = ChatViewController()
        chat.target = self.user
        viewController()?.push(chat)
    }
    
    @IBAction func addAction(_ sender: Any)
    {
//        let request = ContactAdd_Request()
//        request.target_user_id = user.id ;
//        messageInstance.contactAdd(request)
//        
//        view.dialog(title: "Thông báo", desc: "Đã gửi yêu cầu kết bạn", type: .info, acceptBlock: {
//            self.delegate.userSearchViewAdd()
//        }) {
//            
//        }
    }
    
}
