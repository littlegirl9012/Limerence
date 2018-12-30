//
//  PNServicesInstance.swift
//  LimeBook
//
//  Created by Lê Dũng on 9/16/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit
import UserNotifications
let  PNServices = PNServicesInstance.sharedInstance()
class PNServicesInstance: NSObject {

    static var instance: PNServicesInstance!
    class func sharedInstance() -> PNServicesInstance
    {
        if(self.instance == nil)
        {
            self.instance = (self.instance ?? PNServicesInstance())
        }
        return self.instance
    }


    
    func receiveRemoteNotification(_ info :  [AnyHashable : Any])
    {
        let dictionary = info["message"]
        let newMessate = PNMessage.init(dictionary: dictionary as! NSDictionary)
        UNUserNotificationCenter.current().getDeliveredNotifications { (nodes) in
            var uniqueIden : [String] = []
            for item in nodes
            {
                let message = PNMessage.init(dictionary: item.request.content.userInfo["message"] as! NSDictionary)
                if(message.user_id ==  newMessate.user_id)
                {
                    if(message.interval() != newMessate.interval())
                    {
                        uniqueIden.append(item.request.identifier)
                    }
                }
            }
            
        }
    }
}
