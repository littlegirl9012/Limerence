//
//  CommentView.swift
//  LimeBook
//
//  Created by Lê Dũng on 9/30/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit


protocol CommentViewDelegate {
    func commentViewRequestUserInterface()
    func commentViewRequestUserInterfaceFocusView(_ sender : Any?)

}

class CommentView: GreenView, UITextViewDelegate {
    
    
    let LOAD_MORE_NUMBER = 8
    @IBOutlet weak var tfComment: UITextView!
    @IBOutlet weak var lbUser: UIImageView!
    @IBOutlet weak var ctHeight: NSLayoutConstraint!
    var delegate : CommentViewDelegate!
    var book : Book!
    var placeholder  = "enter here.."

    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var lbName: UILabel!
    
    @IBOutlet weak var loadMoreView: UIView!
    
    override func initStyle() {
        lbName.text = "Bình luận"
        lbName.textColor = template.primaryColor
        tfComment.delegate = self ;
        tfComment.drawRadius(4, color: template.backgroundColor, thickness: 1)
        setPlaholderValue(placeholder)
        loadMoreView.isHidden = true ;
    }
    
    @IBOutlet weak var tvComment: UITextView!
    
    @IBOutlet weak var userImageView: UserImageViewMe!
    func loadComment(success : @escaping (()->Void))
    {
        userImageView.drawImage()
        stackView.removeSubsView()
        if(self.book.comment_model.count == 0)
        {
            let request = BookCommentList_Request()
            request.target_id = self.book.id

            services.bookCommentList(request, success: { (response) in
                self.book.comment_model.append(contentsOf: response)
                if(response.count < 8)
                {
                    self.loadMoreView.isHidden = true
                }
                else
                {
                    self.loadMoreView.isHidden = false;
                }
                for item in response
                {
                    let fView = CommentUnitView.init(frame: CGRect.init())
                    self.stackView.addArrangedSubview(fView)
                
                    fView.set(item)
                }
                success()

            }) { (error) in
                success()
            }
        }
        else
        {
            if(self.book.comment_model.count < 8)
            {
                self.loadMoreView.isHidden = true
            }
            else
            {
                self.loadMoreView.isHidden = false

            }
            for item in self.book.comment_model
            {
                let fView = CommentUnitView.init(frame: CGRect.init())
                self.stackView.addArrangedSubview(fView)
                fView.set(item)
            }

            success()

        }
    }
    
    
    func setPlaholderValue(_ pla : String)
    {
        placeholder = pla
        activePlaceholder()
    }

    
    
    func textViewDidChange(_ textView: UITextView) {
        
    }
    
    func  activePlaceholder()
    {
        if self.tfComment.textStorage.getPlainString().isEmpty {
            tfComment.text = placeholder
            tfComment.textColor = template.subTextColor
        }
    }
    
    @IBAction func sendTouch(_ sender: Any)
    {
        if((tfComment.text.trim().length > 0) && (tfComment.text.trim() != self.placeholder))
        {
            tfComment.resignFirstResponder()
            let request = BookCommentInsert_Request()
            request.user_id = userInstance.user.id
            request.parent_id = -1
            request.target_id = book.id
            request.content = tfComment.text
            services.bookCommentInsert(request, success: { (response) in
                self.tfComment.text = ""
                if(response.count > 0)
                {
                    self.book.comment_model.append(contentsOf: response)
                    let fView = CommentUnitView.init(frame: CGRect.init())
                    self.stackView.addArrangedSubview(fView)
                    fView.set(response[0])
                    self.delegate.commentViewRequestUserInterface()
                }
                
            }) { (error) in
                
            }

            
        }
    }
    func textViewDidBeginEditing(_ textView: UITextView)
    {
        if tfComment.textStorage.getPlainString() == placeholder {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }

    
    func clear()
    {
        tfComment.resignFirstResponder()
        tfComment.text = ""
    }
    
    

}
