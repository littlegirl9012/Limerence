//
//  DHMProvince.swift
//  Mobile_68
//
//  Created by Lê Dũng on 7/17/18.
//  Copyright © 2018 Ledung. All rights reserved.
//

import UIKit

class DHMProvince: Mi {
    @objc dynamic var id = -1
    @objc dynamic var name = ""
    @objc dynamic var child : [DHMDistrict]! = []
    
    @objc dynamic var IsSelect = false

    
    class func  list(data : [Dictionary<String, Any>]) -> [DHMProvince]
    {
        var output  : [DHMProvince]  = []
        for item in data
        {
            let unit = DHMProvince.init(dictionary: item as NSDictionary)
            output.append(unit)
        }
        return output
    }

}


