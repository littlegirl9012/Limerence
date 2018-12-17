//
//  BookReference.swift
//  LimeBook
//
//  Created by Lê Dũng on 9/26/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

class BookReference: Mi {

    @objc dynamic var id = 1;
    @objc dynamic var name = "";

    class func  list(data : [Dictionary<String, Any>]) -> [Book]
    {
        var output  : [Book]  = []
        for item in data
        {
            let unit = Book.init(dictionary: item as NSDictionary)
            unit.title = unit.title.uppercased()
            unit.fillData()
            output.append(unit)
        }
        return output
    }

}
