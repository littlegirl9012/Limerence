//
//  PNMessage.swift
//  LimeBook
//
//  Created by Lê Dũng on 9/16/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

class PNMessage: Mi
{
    @objc dynamic var pn_message_type = 1;
    @objc dynamic var user_id = 1;
    @objc dynamic var aliasname = "";
    @objc dynamic var date = "";
    
    func interval() -> Double
    {
        return date.date8601().timeIntervalSince1970
    }

}
