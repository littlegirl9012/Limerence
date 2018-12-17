//
//  UserInfoViewController.swift
//  LimeBook
//
//  Created by Lê Dũng on 9/3/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

class UserInfoViewController: MasterViewController {
    @IBOutlet weak var dob: UserUnitView!
    @IBOutlet weak var phone: UserUnitView!
    @IBOutlet weak var name: UserUnitView!
    @IBOutlet weak var gender: UserUnitView!

    @IBOutlet weak var btEdit: UIButton!
    @IBOutlet weak var logoutView: UserUnitView!
    
    
    var user : User!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = template.backgroundColor

        
        navigationView.set(style: .back, title: "Thông Tin") {
            self.pop()
        }
        
        btEdit.isHidden = !user.isMe()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()

    }

    
    func loadData()
    {
        
        
        navigationView.bringSubview(toFront: btEdit)
        
        gender.set("Giới tính", user.genderDisplay())
        phone.set("Điện thoại", user.phone)
        name.set("Tên", user.aliasname)
        dob.set("Ngày sinh", userInstance.user.dob);
        logoutView.set("Đăng xuất","")
        logoutView.setColor(.red)
        logoutView.setTouch {
            userInstance.logout()
        }
        
        if(!user.isMe())
        {
            logoutView.isHidden = true
            gender.set("Giới tính", "********")
            phone.set("Điện thoại", "********")
            name.set("Tên", user.aliasname)
            dob.set("Ngày sinh", "********");
        }

    }
    
    
    @IBAction func editTouch(_ sender: Any) {
        push(UserEditViewController())
    }
    
    
    


}
