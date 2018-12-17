//
//  ComposerView.swift
//  DXT
//
//  Created by Lê Dũng on 8/10/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

protocol ComposeViewDelegate : class {
    func composeDidSend(_ message : LimeMessage)
}


enum ComposingType : Int
{
    case text = 0
    case emoticon = 1
}


class ComposerView: GreenView, EmoticonInnerDelegate, UITextViewDelegate
{
    
    @IBOutlet var textView: UITextView!
    weak var delegate : ComposeViewDelegate?
    var composingType = ComposingType.text
    var placeholder  = "enter here.."
    
    
    var target_user_id = -1
    var messageType = MesageType.plaintext
    @IBOutlet weak var inputBarBottomSpacing: NSLayoutConstraint!
    let emjView = EmoticonInnerView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 216))

    override func initStyle() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardNotification(_:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        textView.resetTextStyle()
        
        textView.delegate = self;
        
        plainTextStyle()
        emjView.delegate = self;
        
    

    }
    
    func setPlaholderValue(_ pla : String)
    {
        placeholder = pla
        activePlaceholder()
    }
    
    func  activePlaceholder()
    {
        if self.textView.textStorage.getPlainString().isEmpty {
            textView.text = placeholder
            textView.textColor = template.subTextColor
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView)
    {
        if self.textView.textStorage.getPlainString() == placeholder {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }

    

    @IBOutlet weak var imgEmoj: UIImageView!
    @IBOutlet weak var btEmoj: UIButton!
    
    @objc func keyboardWillShow(_ notification: Notification)
    {
    }
    
    @objc func keyboardNotification(_ notification: Notification)
    {
        
        if let userInfo = (notification as NSNotification).userInfo {
            let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let duration:TimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIViewAnimationOptions().rawValue
            let animationCurve:UIViewAnimationOptions = UIViewAnimationOptions(rawValue: animationCurveRaw)
            if (endFrame?.origin.y)! >= UIScreen.main.bounds.size.height {
                self.inputBarBottomSpacing.constant = 0
                //                self.isKeyboardIsShown = false
            } else
            {
                if self.inputBarBottomSpacing.constant==0{
                    self.inputBarBottomSpacing.constant = endFrame?.size.height ?? 0.0
                }
                else
                {
                    self.inputBarBottomSpacing.constant = 0
                    self.inputBarBottomSpacing.constant = endFrame?.size.height ?? 0.0
                }
            }
            
            UIView.animate(withDuration: duration, delay: TimeInterval(0), options: animationCurve,
                           animations: {
                            self.superview?.layoutIfNeeded()
            },
                           completion: nil)
            
            }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    
    func removeObser()
    {
        NotificationCenter.default.removeObserver(self)
    }
    
    func set(_ value : ComposingType)
    {
        switch value {
        case .text:
            textView.inputView = nil;
            imgEmoj.image =  UIImage.init(named: "happiness")
        break ;
        case .emoticon:
            imgEmoj.image =  UIImage.init(named: "keyboard")
            textView.inputView = emjView
            break ;
            
        }
        textView.reloadInputViews()
        textView.becomeFirstResponder()

    }
    @IBAction func toggleType(_ sender: Any)
    {

        if(composingType == .text)
        {
            composingType = .emoticon
        }
        else{
            composingType = .text
        }
        set(composingType)
    }
    
    @IBAction func sendTouch(_ sender: Any)
    {
        if((textView.text.trim().length > 0) && (textView.text.trim() != self.placeholder))
        {
            let textStore = textView.textStorage.getPlainString()
            let message = LimeMessage.init((textStore?.trim())!)
            message.target_user_id = self.target_user_id
            message.readed = true ;
            delegate?.composeDidSend(message)
            textView.text = ""
        }
    }
    
    func emoticonDidSelect(_ attach: EmojiTextAttachment)
    {
        textView.insertAttach(attach)
    }
    
    func plainTextStyle()
    {
        self.imgEmoj.image = "happiness".image()
        self.composingType = .text
    }
    
    func emotionStyle()
    {
        self.imgEmoj.image = "keyboard".image()
        self.composingType = .emoticon
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        plainTextStyle()
        activePlaceholder()
    }
    
}





//
//  Created by Matt Zanchelli on 6/15/14.
//  Copyright (c) 2014 Matt Zanchelli. All rights reserved.
//
import UIKit

class KeyboardAppearance {
    
    class func keyboardLetterFont() -> UIFont {
        return UIFont.systemFont(ofSize: 24)
    }
    
    /// The color to use for the background.
    class func keyboardBackgroundColorForAppearance(appearance: UIKeyboardAppearance) -> UIColor {
        switch appearance {
        case .dark:
            return UIColor(white: 0.00, alpha: 1) // Black
            //            return UIColor(white: 0.30, alpha: 1) // iOS Gray
        //            return UIColor(white: 0.42, alpha: 1) // Tweetbot Gray
        case .default, .light:
            return UIColor(hue: 0.67, saturation: 0, brightness: 0.97, alpha: 1)
        }
    }
    
    /// The color to use for primary buttons, such as letters.
    class func primaryButtonColorForAppearance(appearance: UIKeyboardAppearance) -> UIColor {
        switch appearance {
        case .dark:
            return UIColor(white: 0.90, alpha: 1)
        case .default, .light:
            return UIColor(white: 0.32, alpha: 1)
        }
    }
    
}


