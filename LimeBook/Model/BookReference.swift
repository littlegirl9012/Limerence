//
//  BookReference.swift
//  LimeBook
//
//  Created by Lê Dũng on 9/26/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

class BookReference: Mi {

    @objc dynamic var id = -1;
    @objc dynamic var name = "";
    @objc dynamic var type_id = -1;
    
    @objc dynamic var ref_name = "";

    @objc dynamic var isSelected = false;

    
    func getNameDisplay() ->String
    {
        if((name.length == 0) || (name == "<null>"))
        {
            return ref_name
        }
        else
        {
            return name;
        }
    }
    var child : [BookReference] =  []
    class func  list(data : [Dictionary<String, Any>]) -> [BookReference]
    {
        var output  : [BookReference]  = []
        for item in data
        {
            let unit = BookReference.init(dictionary: item as NSDictionary)
            output.append(unit)
        }
        return output
    }
    
    
    func bookRef(success :@escaping (([BookReference])->Void), failure: ((String)->Void))
    {
        DispatchQueue.global(qos: .background).async {
            services.request(api: .bookRef, param: ["" : "" as AnyObject], success: { (response) in
                success(BookReference.list(data: response.data as! [Dictionary<String, Any>]))
            }) { (error) in
                
            }
        }
    }


}


extension Services
{
    func bookRef(success :@escaping (([BookReference])->Void), failure: ((String)->Void))
    {
        DispatchQueue.global(qos: .background).async {
            services.request(api: .bookRef, param: ["" : "" as AnyObject], success: { (response) in
                
                let ref : [NSDictionary] = (response.data as! NSDictionary).value(forKey: "book_reference") as! [NSDictionary]
                let refType : [NSDictionary] = (response.data as! NSDictionary).value(forKey: "book_reference_type") as! [NSDictionary]
                
                let refType_Model = BookReference.list(data: refType as! [Dictionary<String, Any>])
                let ref_Model = BookReference.list(data: ref as! [Dictionary<String, Any>])
                
                for item in refType_Model
                {
                    for sub in ref_Model
                    {
                        if(sub.type_id == item.id)
                        {
                            item.child.append(sub)
                        }
                    }
                }

                success(refType_Model)

            }) { (error) in
                
            }
        }
    }
}

