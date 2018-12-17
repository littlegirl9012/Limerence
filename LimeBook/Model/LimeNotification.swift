//
//  Notification.swift
//  LimeBook
//
//  Created by Lê Dũng on 9/5/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

enum NotificationType : Int
{
    case book = 1
}


class LimeNotification: Mi
{
    @objc dynamic var id = -1;
    @objc dynamic var user_id = -1;
    @objc dynamic var target_id = -1;
    @objc dynamic var effect_id = -1;
    @objc dynamic var aliasname = "";
    @objc dynamic var title = "";
    @objc dynamic var avatar = "";
    @objc dynamic var media : MediaFile!;


    
    @objc dynamic var attributeDisplay  : NSAttributedString!;

    
    @objc dynamic var notification_type = -1;

    @objc dynamic var date = "";

    class func  list(data : [Dictionary<String, Any>]) -> [LimeNotification]
    {
        var output  : [LimeNotification]  = []
        for item in data
        {
            let unit = LimeNotification.init(dictionary: item as NSDictionary)
            unit.attributeDisplay = unit.display()
            unit.media = MediaFile.init(unit.avatar, .image)
            output.append(unit)
        }
        return output
    }
    
    
    func display()->NSAttributedString
    {
        let font = UIFont.boldSystemFont(ofSize: 14)
        let attributes = [NSAttributedStringKey.font: font]

        
        let wString = " đã bình luận bài viết "
        let wAttribute = NSAttributedString.init(string: wString)
        let attributeAlias = NSMutableAttributedString.init(string: aliasname, attributes: attributes)
        
        attributeAlias.append(wAttribute)
        
        
        let attributeTitle = NSMutableAttributedString.init(string: title, attributes: attributes)
        
        attributeAlias.append(attributeTitle)
        
        return attributeAlias

    }
}


class NotificationBook_Request : Mi
{
    @objc dynamic var user_id = userInstance.user.id
}

class NotificationList_Request : Mi
{
    @objc dynamic var user_id = userInstance.user.id
}

class NotificationDelete_Request : Mi
{
    @objc dynamic var notification_id = -1
    @objc dynamic var user_id = userInstance.user.id
}

class NotificationSubscribe_Request : Mi
{
    @objc dynamic var notification_id = -1
    @objc dynamic var subscribe = false
}



extension Services
{
    func notificationList(_ request : NotificationList_Request, success :@escaping (([LimeNotification])->Void), failure: ((String)->Void))
    {
        services.request(api: .notificationList, param: request.dictionary(), success: { (response) in
            success(LimeNotification.list(data: response.data as! [Dictionary<String, Any>]))
        }) { (error) in
            
        }
    }
    
    func notificationSubscribe(_ request : NotificationSubscribe_Request, success :@escaping (([LimeNotification])->Void), failure: ((String)->Void))
    {
        services.request(api: .notificationSubscribe, param: request.dictionary(), success: { (response) in
            success(LimeNotification.list(data: response.data as! [Dictionary<String, Any>]))
        }) { (error) in
            
        }
    }
    
    func notificationDelete(_ request : NotificationDelete_Request, success :@escaping (()->Void), failure: ((String)->Void))
    {
        services.request(api: .notificationDelete, param: request.dictionary(), success: { (response) in
            success()
        }) { (error) in
            
        }
    }

}
