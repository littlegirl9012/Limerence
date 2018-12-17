//
//  PostUnitView.swift
//  LimeBook
//
//  Created by Lê Dũng on 8/26/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

class PostUnitView: GreenView , AccessoryEmojViewDelegate, EmoticonInnerDelegate
{
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var ortherActionView: UIView!
    
    @IBOutlet weak var rightImage: UIImageView!
    @IBOutlet  var tfContent: UITextField!
    @IBOutlet  var tvContent: UITextView!
    @IBOutlet weak var lbTitle: UILabel!
    
    @IBOutlet weak var rightWidth: NSLayoutConstraint!
    @IBOutlet weak var rightView: UIView!
    var isSingleLine = false ;
    let emojAccessView = AccessoryEmojView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 40))
    let emojKeyboard = EmoticonInnerView.init(frame: CGRect.init(x: 0, y: 0, width: 120, height: 216))

    @IBOutlet weak var btDelete: UIButton!
    
    @IBOutlet weak var btMain: UIButton!
    
    
    var mainBlock :(()->Void)!
    var clearBlock :(()->Void)!
    var rightBlock :(()->Void)!

    @IBAction func mainTouch(_ sender: Any) {
        mainBlock()
    }
    
    override func initStyle()
    {
        
        
        self.btDelete.image("delete-cross".image(), template.dangerColor)
        btMain.isHidden = true
        rightWidth.constant = 0 ;
        mainView.drawRadius(4, color: template.backgroundColor, thickness: 1)
        tfContent.isHidden = true
    }
    
    func setEmojKeyboard()
    {
        tvContent.inputAccessoryView = emojAccessView
        emojKeyboard.delegate = self;
        emojAccessView.delegate = self;

    }
    
    func accessEmojSelectKeyboard()
    {
        tvContent.inputView = nil
        self.tvContent.reloadInputViews()
    }
    
    func accessEmojSelectEmoj() {
        tvContent.inputView = emojKeyboard
        self.tvContent.reloadInputViews()
    }
    
    func emoticonDidSelect(_ attach: EmojiTextAttachment) {
        tvContent.insertAttach(attach)
        
    }

    func keyboard(_ type : UIKeyboardType)
    {
        tfContent.keyboardType = type
    }
    
    func singleLine()
    {
        isSingleLine = true
        tvContent.removeFromSuperview()
        tfContent.isHidden = false
    }
    
    func set(_ title : String)
    {
        lbTitle.text = title
    }
    
    func setTitleRequired(_ title : String)
    {
        var attributes = [NSAttributedStringKey: AnyObject]()
        attributes[.foregroundColor] = UIColor.red
        let requiredText = NSAttributedString.init(string: " *", attributes: attributes)
        let attri = NSMutableAttributedString.init(string: title)
        attri.append(requiredText)
        lbTitle.attributedText = attri
    }

    
    func isEmpty()->Bool
    {
        if(isSingleLine)
        {
            if(tfContent.text?.trim().length == 0)
            {
                return true
            }
        }
        else
        {
            if(tvContent.textStorage.getPlainString().trim().length == 0)
            {
                return true;
            }
        }
        return false;
    }
    
    func content()->String
    {
        return isSingleLine ? tfContent.text! : tvContent.textStorage.getPlainString()!
    }
    
    func clear()
    {
        tvContent.text = ""
        tfContent.text = ""
    }
    
    func action(block : @escaping (()->Void))
    {
        self.mainBlock =  block;
        self.btMain.isHidden = false
    }
    func setContent(_ value : String)
    {
        self.tfContent.text = value
        self.tvContent.text = value;
    }
    
    func setAttribute(_ attr : NSAttributedString)
    {
        tvContent.attributedText = attr;
    }
    
    
    func showClearButton(_ touch : @escaping (()->Void))
    {
        self.clearBlock = touch
        self.rightWidth.constant = 40;
        ortherActionView.isHidden = true ;
        btDelete.isHidden = false ;
        
    }
    
    @IBAction func clearTouch(_ sender: Any) {
        self.clearBlock()
        self.rightWidth.constant = 0;
        self.clear()

    }

    
    
    
    func setRighAction(_ image : UIImage, action : @escaping (()->Void))
    {
        rightWidth.constant = 44 ;

        self.rightBlock = action;
        rightImage.image = image
        ortherActionView.isHidden = false ;
        btDelete.isHidden = true ;

    }
    
    
    @IBAction func rightAction(_ sender: Any) {
        self.rightBlock()
    }
    
    
    
    func hideClearButton()
    {
        self.clearBlock = nil
    }
    
    func endEdit()
    {
        tfContent.resignFirstResponder()
        tvContent.resignFirstResponder()
    }
}
