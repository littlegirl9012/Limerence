//
//  ReferenceGroup.swift
//  MiBook
//
//  Created by Lê Dũng on 1/26/19.
//  Copyright © 2019 limerence. All rights reserved.
//

import UIKit

class ReferenceGroup: Mi {
    @objc dynamic var id = 1;
    @objc dynamic var name = "";
    @objc dynamic var avatar = "";
    @objc dynamic var aliasname = "";
    @objc dynamic var user_id = 1;
    @objc dynamic var phone = "";
    @objc dynamic var note = "";

    
    func user()->User
    {
        let user = User.init()
        user.id = user_id
        user.aliasname = aliasname
        user.avatar = avatar
        return user
    }
    
    func isMine()->Bool
    {
        return (user_id == userInstance.user.id)
    }
    
    @objc dynamic var price = 0.0;
    
    class func  list(data : [Dictionary<String, Any>]) -> [ReferenceGroup]
    {
        var output  : [ReferenceGroup]  = []
        for item in data
        {
            let unit = ReferenceGroup.init(dictionary: item as NSDictionary)
            output.append(unit)
        }
        return output
    }
}


class ReferenceGroupList_Request : Mi
{
    @objc dynamic var province_id = -1;
    @objc dynamic var district_id = -1;
    @objc dynamic var reference_type_id = -1;
}

class ReferenceGroupDetail_Request : Mi
{
    @objc dynamic var reference_group_id = -1;
}

class ReferenceGroupCreate_Request : Mi
{
    @objc dynamic var province_id = -1;
    @objc dynamic var district_id = -1;
    @objc dynamic var user_id = -1;
    @objc dynamic var price = 0.0;
    @objc dynamic var note = "";
    @objc dynamic var reference_type_id = -1;
    @objc dynamic var book_reference  : [NSDictionary]! = [];
}

class ReferenceGroupUser_Request : Mi
{
    @objc dynamic var user_id = userInstance.user.id;
}
class ReferenceGroupDelete_Request : Mi
{
    @objc dynamic var reference_group_id = -1;
}


extension Services
{
    
    func referenceGroupDelete(request: ReferenceGroupDelete_Request,success :@escaping (()->Void), failure: ((String)->Void))
    {
        services.request(api: .referenceDelete, param:request.dictionary(), success: { (response) in
            success()
        }) { (error) in
        }
    }

    
    func referenceGroupList(request: ReferenceGroupList_Request,success :@escaping (([ReferenceGroup])->Void), failure: ((String)->Void))
    {
        services.request(api: .bookRefGroup, param:request.dictionary(), success: { (response) in
            
            success(ReferenceGroup.list(data: response.data as! [Dictionary<String, Any>]  ))
            
        }) { (error) in
            
        }
    }
    
    
    func referenceGroupCreate(request: ReferenceGroupCreate_Request,success :@escaping (()->Void), failure: ((String)->Void))
    {
        services.request(api: .bookRefInsert, param:request.dictionary(), success: { (response) in
            
            success()
            
        }) { (error) in
            
        }
    }
    
    func referenceUser(success :@escaping (([ReferenceGroup])->Void), failure: ((String)->Void))
    {
        services.request(api: .referenceUser, param:ReferenceGroupUser_Request().dictionary(), success: { (response) in
            success(ReferenceGroup.list(data: response.data as! [Dictionary<String, Any>]  ))
        }) { (error) in
            
        }
    }


    func referenceGroupDetail(request: ReferenceGroupDetail_Request,success :@escaping (((ReferenceGroup,[BookReference]))->Void), failure: ((String)->Void))
    {
        services.request(api: .referenceGroupDetail, param:request.dictionary(), success: { (response) in
            
            let info = (response.data as! NSDictionary).value(forKey: "info")
            let items = (response.data as! NSDictionary).value(forKey: "item")
            let info_model = ReferenceGroup.init(dictionary: info as! NSDictionary)
            let items_model = BookReference.list(data: items as! [Dictionary<String, Any>])
            success((info_model,items_model))
        }) { (error) in
            
        }
    }

    
    
}
