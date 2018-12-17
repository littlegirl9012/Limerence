//
//  ContactViewController.swift
//  LimeBook
//
//  Created by Lê Dũng on 8/15/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit


class ContactGroup : NSObject
{
    var name = ""
    var user : [User] = []
    
    init (  value : [User], status : ContactStatus)
    {
        super.init()
        
        
        
        switch status {
        case .waiting:
            self.name = "Đã gửi yêu cầu kết bạn"
            break;
            
        case .answer:
            self.name = "Trả lời yêu cầu kết bạn"

            break;

        case .beauty:  self.name = "Danh sách bạn bè"
            break;

        case .none:
            Void()
        }
        
        for item in value
        {
            if(item.status == status.rawValue)
            {
                user.append(item)
            }
        }
    }
    
    
    
}


class ContactViewController: MasterViewController, ContactCellDelegate, UITableViewDelegate,UITableViewDataSource {
    

    @IBOutlet weak var tbView: UITableView!
    
    var contacts : [ContactGroup] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tbView.setIdentifier("ContactCell")
        tbView.backgroundColor = template.backgroundColor
        notifyInstance.add(self, .reloadContactList, selector: #selector(reloadTableView))
        reloadTableView()
    }
    
    @objc func reloadTableView()
    {
        
        contacts.removeAll()
        let rosterList = contactDataStore.contacts
        
        let waiting = ContactGroup.init(value: rosterList, status: .waiting)
        
        let anser = ContactGroup.init(value: rosterList, status: .answer)
        
        let beauty = ContactGroup.init(value: rosterList, status: .beauty)
        
        if(waiting.user.count  > 0)
        {
            contacts.append(waiting)
        }
        if(anser.user.count  > 0)
        {
            contacts.append(anser)
        }
        
        if(beauty.user.count  > 0)
        {
            contacts.append(beauty)
        }
        
        
        tbView.reloadData()
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tbView.dequeueReusableCell(withIdentifier: "ContactCell") as! ContactCell
        cell.delegate = self;
        cell.set(contacts[indexPath.section].user[indexPath.row])
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chat = ChatViewController()
        chat.target = contacts[indexPath.section].user[indexPath.row]
        self.push(chat)
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts[section].user.count
    }

    @IBOutlet weak var btAdd: UIButton!
    override func viewWillAppear(_ animated: Bool) {
        messageInstance.contactList(GeneralMessageRequest())
    }

    @IBAction func addTouch(_ sender: Any) {
        let search = UserSearchViewController()
        self.push(search)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = ContactHeaderView.init(frame: CGRect.init())
        headerView.set(contacts[section].name)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44

    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        return ContactFooterView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 8
    }
    
    func contactCellDeny(_ user: User)
    {
        let contactRequest = Contact_Request()
        contactRequest.target_user_id = user.id
        contactRequest.user_id = userInstance.user.id
        contactRequest.contact_id = user.contact_id
        messageInstance.contactCancel(contactRequest)
        refreshContactList()
    }
    
    func refreshContactList()
    {
        messageInstance.contactList(GeneralMessageRequest())
    }

    func contactCellAccept(_ user: User)
    {
        let contactRequest = Contact_Request()
        contactRequest.target_user_id = user.id
        contactRequest.user_id = userInstance.user.id
        contactRequest.contact_id = user.contact_id
        messageInstance.contactAccept(contactRequest)
        refreshContactList()
    }
    
    func contactCellCancel(_ user: User)
    {
        let contactRequest = Contact_Request()
        contactRequest.target_user_id = user.id
        contactRequest.user_id = userInstance.user.id
        contactRequest.contact_id = user.contact_id
        messageInstance.contactCancel(contactRequest)
        refreshContactList()
    }
}
