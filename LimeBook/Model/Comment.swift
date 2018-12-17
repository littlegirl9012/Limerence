//
//  Comment.swift
//  LimeBook
//
//  Created by Lê Dũng on 8/31/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

class Comment: Mi
{
    
    @objc dynamic var aliasname = ""
    @objc dynamic var avatar = ""
    @objc dynamic var id = -1
    @objc dynamic var user_id = -1
    @objc dynamic var target_id = -1
    @objc dynamic var parent_id = -1
    @objc dynamic var content = ""
    @objc dynamic var attributeContent : NSAttributedString!

    
    @objc dynamic var media_file  : MediaFile!

    
    @objc dynamic var date = ""
    
    
    class func  list(data : [Dictionary<String, Any>]) -> [Comment]
    {
        var output  : [Comment]  = []
        for item in data
        {
            let unit = Comment.init(dictionary: item as NSDictionary)
            unit.media_file = MediaFile.init(unit.avatar, .image)
            unit.attributeContent = unit.content.emojAttributeText()
            output.append(unit)
        }
        return output
    }

}
