//
//  CommentUnitView.swift
//  LimeBook
//
//  Created by Lê Dũng on 10/3/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit


protocol CommentUnitViewDelegate {
    func commentDidTouch()
}
class CommentUnitView: GreenView {
    
    var delegate : CommentUnitViewDelegate!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var userImageView: UserImageView!

    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var lbContent: UILabel!
    var comment : Comment!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func initStyle() {
        lbDate.textColor = template.subTextColor
    }

    func set(_ comment : Comment)
    {
        self.comment = comment
        lbContent.attributedText = comment.attributeContent
        userImageView.setMedia(comment.media_file)
        lbName.text = comment.aliasname
        lbDate.text = comment.date.date8601().stringValue()
    }

    @IBAction func avaTouch(_ sender: Any) {
        if(comment.user_id != userInstance.user.id)
        {
            let chat = ChatViewController()
            let user = User.init()
            user.aliasname = comment.aliasname
            user.id = comment.user_id
            chat.target = user;
            viewController()?.push(chat)
        }
    }
}
