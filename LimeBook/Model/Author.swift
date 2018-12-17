//
//  Author.swift
//  LimeBook
//
//  Created by Lê Dũng on 10/6/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

class Author: Mi {

    @objc dynamic var id = -1
    @objc dynamic var name = ""
    @objc dynamic var aliasname = ""

    class func  list(data : [Dictionary<String, Any>]) -> [Author]
    {
        var output  : [Author]  = []
        for item in data
        {
            let unit = Author.init(dictionary: item as NSDictionary)
            output.append(unit)
        }
        return output
    }

}


class AuthorList_Request: Mi {
    
}


class AuthorSearch_Request: Mi {
    @objc dynamic var keyword = ""
}

extension Services
{
    
    func authorSearch(_ request :  AuthorSearch_Request, success :@escaping (([Author])->Void), failure: ((String)->Void))
    {
        services.request(api: .authorSearch, param: request.dictionary(), success: { (response) in
            success(Author.list(data: response.data as! [Dictionary<String, Any>]))
        }) { (error) in
            
        }
    }

    
}
