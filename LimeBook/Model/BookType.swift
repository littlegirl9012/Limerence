//
//  BookType.swift
//  LimeBook
//
//  Created by Lê Dũng on 10/7/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

class LimeBookType: Mi {
    @objc dynamic var id = -1;
    @objc dynamic var name = "";
    @objc dynamic var query_id = -1;
    
    @objc dynamic var userSelect = false ;

    
    class func  list(data : [Dictionary<String, Any>]) -> [LimeBookType]
    {
        var output  : [LimeBookType]  = []
        for item in data
        {
            let unit = LimeBookType.init(dictionary: item as NSDictionary)
            output.append(unit)
        }
        return output
    }

}
extension Services
{
    func bookTypeList(success :@escaping (([LimeBookType])->Void), failure: ((String)->Void))
    {
        services.request(api: .bookTypeList, param: ["":"" as AnyObject], success: { (response) in
            success(LimeBookType.list(data: response.data as! [Dictionary<String, Any>]))
        }) { (error) in
            
        }
    }
    
}
