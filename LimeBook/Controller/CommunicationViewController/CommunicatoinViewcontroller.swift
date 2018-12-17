//
//  CommunicatoinViewcontroller.swift
//  LimeBook
//
//  Created by Lê Dũng on 12/2/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

class CommunicatoinViewcontroller: MasterViewController, CommunicateTopViewDelegate {
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var topView: CommunicateTopView!
    
    
    var conversation = ConversationViewController()
    var contact = ContactViewController()

    
    override func viewDidLoad()
    {
        topView.delegate = self;
        super.viewDidLoad()
        addChildViewController(conversation)
        addChildViewController(contact)

        contentView.addSubview(conversation.view)
        contentView.setLayout(conversation.view)
    }
    
    func communicateChangePage(_ index: Int) {
        contentView.removeSubsView()
        if(index == 0)
        {
            contentView.addSubview(conversation.view)
            contentView.setLayout(conversation.view)
        }
        else
        {
            contentView.addSubview(contact.view)
            contentView.setLayout(contact.view)
        }
    }
    
    func communicateAddTouch() {
        push(UserSearchEngineViewController())

    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
