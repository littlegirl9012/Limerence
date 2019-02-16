//
//  ComposerView.swift
//  DXT
//
//  Created by Lê Dũng on 8/10/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit
import Gallery
protocol ComposeViewDelegate : class {
    func composeDidSend(_ message : LimeMessage)
    func composeWillType()
}


enum ComposingType : Int
{
    case text = 0
    case emoticon = 1
}


class ComposerView: GreenView, EmoticonInnerDelegate, GalleryControllerDelegate,ComposeImageViewDelegate, UITextViewDelegate
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
        
        
        textView.backgroundColor = "f3f4f5".hexColor()
        textView.drawRadius(4)
    

    }
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        delegate?.composeWillType()
        return true
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
    @IBAction func imgTouch(_ sender: Any) {
        
        
        callLibrary()
    }
    
    func set(_ value : ComposingType)
    {
        switch value {
        case .text:
            textView.inputView = nil;
            imgEmoj.image =  UIImage.init(named: "compose_emoticon")
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
        self.imgEmoj.image = "compose_emoticon".image()
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
    
    func callLibrary()
    {
        let gallery = GalleryController()
        Config.tabsToShow = [Config.GalleryTab.cameraTab,Config.GalleryTab.imageTab]
        Config.Camera.imageLimit = 1;
        Config.Grid.CloseButton.tintColor = template.primaryColor
        Config.Grid.ArrowButton.tintColor = template.primaryColor
        gallery.delegate = self
        viewController()?.present(gallery, animated: false, completion: nil)
    }

    func galleryController(_ controller: GalleryController, didSelectImages images: [Image]) {
        
        controller.dismiss()
        weak var weakself = self;
        images[0].resolveMedium { (png) in
            weakself?.previewViewTouch(png)            
        }
    }
    
    func previewViewTouch(_ image : UIImage?)
    {
        let previewView = ComposeImageView.init(frame: CGRect.init(x: 0, y: 0, width: 1, height: 216))
        textView.inputView = previewView
        previewView.backgroundColor = template.backgroundColor
        previewView.image = image
        previewView.delegate = self;
        textView.reloadInputViews()
        textView.becomeFirstResponder()

    }
    @IBOutlet weak var widthConstraintBtImage: NSLayoutConstraint!
    
    func disableSendImage()
    {
        widthConstraintBtImage.constant = 0;
    }
    
    func ComposeImageViewSend(_ image: UIImage?) {
        
        weak var weakself = self;
        services.uploadMedia(MediaBrand.conference, images: [image!], success: { (response) in
            
            let mediaFilesResponse = MediaFile.list(data: response.data as! [Dictionary<String, Any>])
            if(mediaFilesResponse.count > 0)
            {
                let path = mediaFilesResponse[0].path
                let message = LimeMessage.init(path)
                message.target_user_id = self.target_user_id
                message.readed = true ;
                message.message_type = MesageType.media.rawValue
                weakself?.delegate?.composeDidSend(message)
                weakself?.textView.text = ""
                weakself?.textView.inputView = nil ;

                weakself?.textView.resignFirstResponder()
            }
            
        }, failure: { (error) in
            
        }) { (progress) in
            
        }
    }
    
    func ComposeImageViewCancel() {
        textView.inputView = nil
        textView.resignFirstResponder()

        
    }
    func galleryController(_ controller: GalleryController, didSelectVideo video: Video) {
        controller.dismiss()
        
    }
    
    func galleryController(_ controller: GalleryController, requestLightbox images: [Image]) {
        controller.dismiss()
        
    }
    
    func galleryControllerDidCancel(_ controller: GalleryController) {
        controller.dismiss()
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




import UIKit
import Photos


// MARK: - UIImage

extension Image {
    
    /// Resolve UIImage synchronously
    ///
    /// - Parameter size: The target size
    /// - Returns: The resolved UIImage, otherwise nil
    public func resolveMedium(completion: @escaping (UIImage?) -> Void) {
        let options = PHImageRequestOptions()
        options.isNetworkAccessAllowed = true
        options.deliveryMode = .opportunistic
        
        let targetSize = CGSize(
            width: asset.pixelWidth,
            height: asset.pixelHeight
        )
        
        PHImageManager.default().requestImage(
            for: asset,
            targetSize: targetSize,
            contentMode: .default,
            options: options) { (image, _) in
                completion(image)
        }
    }
    
    public static func resolveMedium(images: [Image], completion: @escaping ([UIImage?]) -> Void) {
        let dispatchGroup = DispatchGroup()
        var convertedImages = [Int: UIImage]()
        
        for (index, image) in images.enumerated() {
            dispatchGroup.enter()
            
            image.resolveMedium(completion: { resolvedImage in
                if let resolvedImage = resolvedImage {
                    convertedImages[index] = resolvedImage
                }
                
                dispatchGroup.leave()
            })
        }
        
        dispatchGroup.notify(queue: .main, execute: {
            let sortedImages = convertedImages
                .sorted(by: { $0.key < $1.key })
                .map({ $0.value })
            completion(sortedImages)
        })
    }
}
