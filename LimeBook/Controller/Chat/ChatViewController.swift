//
//  ChatViewController.swift
//  LimeBook
//
//  Created by Lê Dũng on 8/15/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

class ChatViewController: MasterViewController, UITableViewDelegate,UITableViewDataSource , ComposeViewDelegate, LoadmoreViewDelegate{

    @IBOutlet weak var contactView: ContactView!
    @IBOutlet weak var userImageView: UserImageView!
    var  target : User!
    @IBOutlet weak var composeView: ComposerView!
    let headerView = LoadmoreView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 32))

    
    var conversation : Conversation = Conversation()
    @IBOutlet weak var tbView: UITableView!
    @IBOutlet weak var containImageView: GCleanView!
    @IBOutlet weak var btBook: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notifyInstance.addM(self, .messageReceive, selector: #selector(messageReceive))
        contactView.set(target)
        
        conversation = confernceDataStore.forceGetConversationByUser(target)
        conversation.removeAliasMessage()
        let request = MessageLatest_Request.init(userInstance.user.id, target.id, conversation.messageLatestId())
        messageInstance.latestMessage(request)
        messageInstance.conversationMarkRead(GeneralMessageRequest.init(target))
        
        notifyInstance.addM(self, .messageLatest, selector: #selector(reloadTable))
        conversation.readAllMessage()
        notifyInstance.postM(.conversationUpdateItem, conversation)
        initStyle()
        headerView.view.backgroundColor = template.backgroundColor
        navigationView.bringSubview(toFront: self.btBook)
        scrollToBotton()
        
    }
    @IBAction func bookTouchIn(_ sender: Any)
    {
        view.endEditing(true)
        let bookUserView = BookUserView.init(frame: CGRect.init())
        bookUserView.loadData(self.target)
        view.alertBox(bookUserView, ratio: 0.86)
    }
    
    @objc func messageReceive(notify  : NSNotification)
    {
        let ca = notify.object as! LimeMessage
        if(ca.conversation_id == self.conversation.id)
        {
            self.tbView.insertRows(at: [IndexPath.init(row: self.conversation.messageCount() - 1, section: 0)], with: .none)
            self.scrollToBotton()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        messageInstance.reconnect()
        super.viewWillAppear(animated)
    }
    
    @objc func reloadTable()
    {
        weak var weakself = self;
        DispatchQueue.main.async {
            weakself?.tbView.reloadData()
            weakself?.scrollToBotton()
        }
    }
    
    func initStyle()
    {
        navigationView.bringSubview(toFront: self.containImageView)
        tbView.backgroundColor =  template.backgroundColor
        composeView.delegate = self;
        tbView.setIdentifier("MessageMyCell")
        tbView.setIdentifier("MessageTargetCell")
        tbView.setIdentifier("MessageLoadmoreCell")
        
        tbView.setIdentifier("MessageImageTargetCell")
        tbView.setIdentifier("MessageImageMyCell")

        
        
        
        
        
        
        composeView.target_user_id = target.id
        headerView.delegate = self;
        let hd = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 1))
        tbView.tableHeaderView = hd
        headerView.clipsToBounds = true
        weak var weakself = self
        self.navigationView.set(style: .back, title: target.aliasname) {
            weakself?.navigationController?.popViewController(animated: false)
            weakself?.composeView.removeObser()
            NotificationCenter.default.removeObserver(weakself!)
        }
    }
    func loadmoreDidSelect()
    {
        
    }
    
    @IBAction func userTouch(_ sender: Any)
    {
        let userInfo = FriendViewController()
        userInfo.user = target
        push(userInfo)
    }
    
    func scrollToBotton()
    {
        DispatchQueue.main.async {
            if(self.conversation.messageCount() > 0)
            {
                self.tbView.scrollToRow(at: IndexPath.init(row: self.conversation.messageCount() - 1, section: 0), at: .bottom, animated: true)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let message = conversation.messages[indexPath.row];
        let cell = tbView.dequeueReusableCell(withIdentifier: MessageCell.getCell(message)) as! MessageCell
        cell.set(message)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conversation.messageCount()
    }

    func composeDidSend(_ message: LimeMessage)
    {
        confernceDataStore.sendMessage(message)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        view.endEditing(true)
    }

    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(conversation.messageCount() >= 24)
        {
            return 32
        }
        else
        {
            return 0;
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView
    }
    
    func composeWillType() {
        
        print("Scroll to bottom")
        scrollToBotton()
    }
    
}
