//
//  BookCategory.swift
//  LimeBook
//
//  Created by Lê Dũng on 9/25/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

class BookCategory: Mi {

    @objc dynamic var   id = -1;
    @objc dynamic var   name = "";
  
    @objc dynamic var   selected = false;

    
    class func  list(data : [Dictionary<String, Any>]) -> [BookCategory]
    {
        var output  : [BookCategory]  = []
        for item in data
        {
            let unit = BookCategory.init(dictionary: item as NSDictionary)
            output.append(unit)
        }
        return output
    }
    
    func toggleSeleted()
    {
        selected  = !selected
    }

}

extension Services
{
    func categoryList(success :@escaping (([BookCategory])->Void), failure: ((String)->Void))
    {
        services.request(api: .categoryList, param: ["":"" as AnyObject], success: { (response) in
            success(BookCategory.list(data: response.data as! [Dictionary<String, Any>]))
        }) { (error) in
            
        }
    }
    
}

