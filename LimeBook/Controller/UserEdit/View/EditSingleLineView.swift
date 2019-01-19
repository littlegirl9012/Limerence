//
//  EditSingleLineView.swift
//  LimeBook
//
//  Created by Lê Dũng on 9/17/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

class EditSingleLineView: GreenView {
    @IBOutlet weak var tfContent: UITextView!
    @IBOutlet weak var line: UIView!
    
    @IBOutlet weak var lbContent: UILabel!
    @IBOutlet weak var lbTitle: UILabel!
    
    var actionBlock  : (()->Void)!
    override func initStyle() {
        lbTitle.textColor = template.generalTextColor
        tfContent.textColor = template.subTextColor
        lbContent.textColor = template.subTextColor

//        lbLine.backgroundColor = template.subTextColor
//        lbLine.alpha = 0.24
        
        lbTitle.text = ""
        tfContent.text = ""
        
        view.backgroundColor = UIColor.white
        btTouch.isHidden = true
        lbContent.isHidden = true ;
    }
    
    @IBOutlet weak var btTouch: UIButton!
    
    @IBAction func touchIn(_ sender: Any)
    {
        if(actionBlock != nil)
        {
            actionBlock();
        }
        else
        {
            tfContent.becomeFirstResponder()
        }
    }
    func hidenLine()
    {
        line.isHidden = true
    }
    
    func setTouch(_ action : @escaping (()->Void))
    {
        self.actionBlock = action;
        self.btTouch.isHidden = false
        tfContent.isHidden = true
        lbContent.isHidden = false ;
    }
    
    func setContent(_ value : String)
    {
        tfContent.text = value
    }
    
    func setInput(_ value : UIView)
    {
        tfContent.inputView = value
    }
    func set( _ name : String, _ value : String)
    {
        lbTitle.text = name;
        tfContent.text = value
        lbContent.text = value
    }
    
    func setColor(_ value : UIColor)
    {
        lbTitle.textColor = value;
    }
    
    func dismiss()
    {
        tfContent.resignFirstResponder()
    }

    
    func isEmpty() ->Bool
    {
        return (tfContent.text?.trim().isEmpty)!
    }
}
