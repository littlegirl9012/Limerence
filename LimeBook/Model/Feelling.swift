//
//  Feelling.swift
//  LimeBook
//
//  Created by Lê Dũng on 10/6/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

class Feelling: Mi {
    @objc dynamic var id = -1;
    @objc dynamic var user_id = -1;
    @objc dynamic var aliasname = "";
    @objc dynamic var avatar = "";

    @objc dynamic var name = "";
    @objc dynamic var image = ""
    @objc dynamic var content = ""
    @objc dynamic var note = ""
    @objc dynamic var intro = ""
    @objc dynamic var date = ""
    @objc dynamic var author = ""
    @objc dynamic var year = ""

    
    @objc dynamic var attributeIntro : NSMutableAttributedString!
    @objc dynamic var attributeNote : NSMutableAttributedString!
    @objc dynamic var attributeContent : NSMutableAttributedString!

    
    class func  list(data : [Dictionary<String, Any>]) -> [Feelling]
    {
        var output  : [Feelling]  = []
        for item in data
        {
            let unit = Feelling.init(dictionary: item as NSDictionary)
            unit.fillAttribute()
            output.append(unit)
        }
        
        return output
    }

    
    func fillAttribute()
    {
        content = content.trim()
//        content = "\""+content+"\"";
//        content = content.replacingOccurrences(of: "\"\"", with: "\"")
        


        attributeIntro  = attributeText(intro)
        attributeContent  = attributeTextItalic(content)
        
        
        
        
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .right
        paragraphStyle.lineHeightMultiple = 1
        paragraphStyle.lineSpacing = 1

        // Define attributed string attributes
        let attributes = [NSAttributedStringKey.paragraphStyle: paragraphStyle,NSAttributedStringKey.font : UIFont.systemFont(ofSize: 16),NSAttributedStringKey.foregroundColor : template.subTextColor]
        
        let attributedString = NSAttributedString(string:"\n"+""+date.date8601().stringValue(), attributes: attributes)
        attributeContent.append(attributedString)
        
        
//        if(note.length > 0)
//        {
//            note = note.trim()
//            note = "\""+note+"\"";
//            note = note.replacingOccurrences(of: "\"\"", with: "\"")
//            attributeNote  = attributeTextItalicNoHeight(note)
//
//            let attributedStringAuthor = NSAttributedString(string:"\n"+author.capitalized+", "+year, attributes: attributes)
//            attributeNote.append(attributedStringAuthor)
//        }
        
        
        
    }
    
    func attributeText(_ value : String) -> NSMutableAttributedString
    {
        
        let attri = NSMutableAttributedString.init(string: value)
        let paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.lineHeightMultiple = 1
//        paragraphStyle.lineSpacing = 1
        paragraphStyle.alignment = .natural
        attri.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attri.length))
        attri.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 16), range: NSMakeRange(0, attri.length))
        return attri ;
    }
    func attributeTextItalic(_ value : String) -> NSMutableAttributedString
    {
        
        let attri = NSMutableAttributedString.init(string: value)
        let paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.lineHeightMultiple = 1
//        paragraphStyle.lineSpacing = 1
        paragraphStyle.alignment = .natural
        attri.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attri.length))
        attri.addAttribute(NSAttributedStringKey.font, value: UIFont.italicSystemFont(ofSize: 16), range: NSMakeRange(0, attri.length))
        return attri ;
    }

    
    func attributeTextItalicNoHeight(_ value : String) -> NSMutableAttributedString
    {
        
        let attri = NSMutableAttributedString.init(string: value)
        let paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.lineHeightMultiple = 1
//        paragraphStyle.lineSpacing = 1
        paragraphStyle.alignment = .natural
        attri.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attri.length))
        attri.addAttribute(NSAttributedStringKey.font, value: UIFont.italicSystemFont(ofSize: 16), range: NSMakeRange(0, attri.length))
        return attri ;
    }


}




class  FeelingInsert_Request: Mi {
    
    
    @objc dynamic var user_id = -1
    @objc dynamic var book_id = -1
    @objc dynamic var image = ""
    @objc dynamic var content = ""
    @objc dynamic var note = ""
    @objc dynamic var rate = 0.0
    @objc dynamic var intro = ""
    @objc dynamic var images  : [String] = [];


}

class  FeelingList_Request: Mi {
    
        @objc dynamic var book_id = -1
}

extension Services
{
    func feelingInsert(request : FeelingInsert_Request, success :@escaping (()->Void), failure: ((String)->Void))
    {
        services.request(api: .feelingInsert, param:request.dictionary(), success: { (response) in
            success()
        }) { (error) in
        }
    }
    
    func feelingList(request : FeelingList_Request, success :@escaping (([Feelling])->Void), failure: ((String)->Void))
    {
        services.request(api: .feelingList, param:request.dictionary(), success: { (response) in
            success(Feelling.list(data: response.data as! [Dictionary<String, Any>]))
        }) { (error) in
        }
    }

}
