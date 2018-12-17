//
//  GreenExtension+NSAttributeString.swift
//  LimeBook
//
//  Created by Lê Dũng on 10/9/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

class LimeAttributedString : NSObject{

    
    
    class func attribute(string : String ,italic: Bool,emotion : Bool) ->NSMutableAttributedString
    {
        let attri = NSMutableAttributedString.init(string: string)
        if(emotion)
        {
            if(string.contains("emj"))
            {
                for item in interfaceDataStore.emoj
                {
                    if(string.contains(item))
                    {
                        var n = 0
                        let rang = attri.string.ranges(of:item)
                        for itemRange in rang
                        {
                            var targetName = item.replacingOccurrences(of: "]", with: "")
                            targetName = targetName.replacingOccurrences(of: "[", with: "")
                            let image1Attachment = NSTextAttachment()
                            image1Attachment.image = UIImage(named: targetName)
                            if(string.length == 7 )
                            {
                                image1Attachment.bounds = CGRect.init(x: 0, y: 0, width: 48, height: 48)
                            }
                            else
                            {
                                image1Attachment.bounds = CGRect.init(x: 0, y: -4, width: 18, height: 18)
                            }
                            let image1String = NSAttributedString(attachment: image1Attachment)
                            attri.replaceCharacters(in: NSRange.init(location: itemRange.lowerBound.encodedOffset - (n*6), length: 7), with: image1String)
                            n = n + 1;
                        }
                    }
                }
            }

        }
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1
        paragraphStyle.lineSpacing = 1
        paragraphStyle.alignment = .natural
        attri.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attri.length))
        
        if(italic)
        {
            attri.addAttribute(NSAttributedStringKey.font, value: UIFont.italicSystemFont(ofSize: 16), range: NSMakeRange(0, attri.length))
        }
        else
        {
            attri.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 16), range: NSMakeRange(0, attri.length))

        }
        
        
        return  attri
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
