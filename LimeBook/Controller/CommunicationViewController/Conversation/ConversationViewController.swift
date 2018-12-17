//
//  ConversationViewController.swift
//  LimeBook
//
//  Created by Lê Dũng on 8/18/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

class ConversationViewController: MasterViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tbView: UITableView!

    
    @IBOutlet weak var btAdd: UIButton!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        notifyInstance.addM(self, .conversationReceive, selector: #selector(refreshConversation))
        notifyInstance.addM(self, .conversationUpdateItem, selector: #selector(refreshConversation))

        
        tbView.setIdentifier("ConversationCell");
    }
    override func viewWillAppear(_ animated: Bool) {
        tbView.reloadData()
    }

    
    @IBAction func searchTouch(_ sender: Any) {
        push(UserSearchEngineViewController())
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tbView.dequeueReusableCell(withIdentifier: "ConversationCell") as! ConversationCell
        cell.set(confernceDataStore.conversations[indexPath.row])
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chat = ChatViewController()
        chat.target = confernceDataStore.conversations[indexPath.row].user()
        self.push(chat)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return confernceDataStore.conversations.count
    }

    @objc func refreshConversation()
    {
        DispatchQueue.main.async {
            self.tbView.reloadData()
        }
    }
    

    
}
