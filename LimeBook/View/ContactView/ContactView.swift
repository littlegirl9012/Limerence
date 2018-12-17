//
//  ContactView.swift
//  MiBook
//
//  Created by Lê Dũng on 12/6/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

class ContactView: GreenView {
    @IBOutlet weak var htHeight: NSLayoutConstraint!
    
    @IBOutlet weak var responseView: UIView!
    @IBOutlet weak var requestView: UIView!
    @IBOutlet weak var generalView: UIView!
    @IBOutlet weak var btAddFriend: UIButton!
    var user : User!
    
    override func initStyle()
    {
        htHeight.constant = 0
        hidenAll()
        notifyInstance.addM(self, .contactInfo, selector: #selector(updateView))
        btAddFriend.drawRadius(3, color: template.primaryColor, thickness: 1)
        btAddFriend.setTitleColor(template.primaryColor, for: .normal)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    @objc func updateView(notify : Notification)
    {
        weak var weakself = self;
        DispatchQueue.main.async {
            let contact = notify.object as! LimeContact
            if(contact.contactType == .success)
            {
                weakself?.htHeight.constant = 0 ;
            }
            else
            {
                weakself?.htHeight.constant = 36 ;
                weakself?.processView(contact.contactType)
            }
        }
    }
    
    func hidenAll()
    {
        generalView.isHidden = true
        requestView.isHidden = true
        responseView.isHidden = true
    }
    
    func processView(_ contactType : ContactType)
    {
        hidenAll()
        switch contactType {
        case .none:  generalView.isHidden = false ;   break;
        case .success:     break;
        case .request:  requestView.isHidden = false ;  break;
        case .response:   responseView.isHidden = false ;  break;
        }
    }
    func set(_ user : User)
    {
        self.user = user
        let request = Contact_Request()
        request.user_id = userInstance.user.id
        request.target_user_id = user.id
        messageInstance.contactInfo(request)
    }
    @IBAction func requestTouch(_ sender: Any)
    {
        let request = Contact_Request()
        request.user_id = userInstance.user.id
        request.target_user_id = user.id
        messageInstance.contactAdd(request)
    }
    
    @IBAction func acceptTouch(_ sender: Any) {
        let request = Contact_Request()
        request.user_id = userInstance.user.id
        request.target_user_id = user.id
        messageInstance.contactAccept(request)
    }
    
    @IBAction func denyTouch(_ sender: Any)
    {
        let request = Contact_Request()
        request.user_id = userInstance.user.id
        request.target_user_id = user.id
        messageInstance.contactDeny(request)

    }
    @IBAction func cancelTouch(_ sender: Any)
    {
        let request = Contact_Request()
        request.user_id = userInstance.user.id
        request.target_user_id = user.id
        messageInstance.contactCancel(request)

    }

    
}
