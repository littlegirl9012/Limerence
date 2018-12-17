//
//  UserSearchViewController.swift
//  LimeBook
//
//  Created by Lê Dũng on 8/25/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

class UserSearchViewController: MasterViewController, UserSearchViewDelegate {
    func userSearchViewMessage() {
        
    }
    
    @IBOutlet weak var btSearch: ButtonSuccess!
    @IBOutlet weak var resultView: UserSearchView!

    @IBOutlet weak var tfPhone: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        resultView.delegate = self;
        view.backgroundColor = template.backgroundColor ;
        
        navigationView.set(style: .back, title: "Thêm bạn") {
            self.navigationController?.popViewController(animated: false)
        }
        registerDismissKeyboardWhenTouchScreen()
        resultView.isHidden = true ;
        btSearch.drawRadius(4)
        
        resultView.drawRadius(4)
        
        tfPhone.becomeFirstResponder()
    }
    @IBAction func searchTouch(_ sender: Any) {
        
        view.endEditing(true)
        self.resultView.isHidden = true

        let request = UserSearch_Request()
        request.phone = tfPhone.text!.trim()
        services.userSearch(request, success: { (response) in
            if(response.count > 0)
            {
                self.resultView.set(response[0])
                self.resultView.isHidden = false
            }
            else
            {
                self.view.dialog(title: "Thông báo", desc: "Không tìm thấy kết quả", type: .info, acceptBlock: {
                    
                }, cancelBlock: { () in
                    
                })
            }
        }) { (error) in
            
        }
        
    }
    
    
    func userSearchViewAdd() {
        self.pop()
    }

}
