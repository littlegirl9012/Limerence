//
//  MIAdmin.swift
//  LimeBook
//
//  Created by Lê Dũng on 11/29/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

class MIAdmin: Mi {

}


class BookTikiInsert_Request: Mi
{
    @objc dynamic var title = "";
    @objc dynamic var author = "";
    @objc dynamic var tiki_id = "";
    @objc dynamic var tiki_link = "";
    @objc dynamic var cat_name = "";
    @objc dynamic var image = "";
    @objc dynamic var price = 0.0;


}

class BookTikiUpdatePrice_Request: Mi
{
    @objc dynamic var tiki_id = 0;
    @objc dynamic var sell_price = 0.0;
}

class BookFahasaInsert_Request: Mi
{
    
    @objc dynamic var title = "";
    @objc dynamic var side_id = "";
    @objc dynamic var link = "";
    @objc dynamic var price = 0.0;
    @objc dynamic var sell_price = 0.0;
    @objc dynamic var image = "";
    @objc dynamic var isbn = "";

}

extension Services
{
    
    func adminBookTikiInsert(_ request :  BookTikiInsert_Request, success :@escaping (()->Void), failure: ((String)->Void))
    {
        services.request(api: .adminBookTikiInsert, param: request.dictionary(), success: { (response) in
            success()
        }) { (error) in
            
        }
    }
    
    func adminTikiList( success :@escaping (([Book])->Void), failure: ((String)->Void))
    {
        services.request(api: .adminBookTikiList, param: ["":"" as AnyObject], success: { (response) in
            success(Book.simpleList(data: response.data as! [Dictionary<String, Any>]))
        }) { (error) in
            
        }
    }

    
    func adminFahasaInsert(_ request :  BookFahasaInsert_Request, success :@escaping (()->Void), failure: ((String)->Void))
    {
        services.request(api: .adminBookFahasaInsert, param: request.dictionary(), success: { (response) in
            success()
        }) { (error) in
            
        }
    }
    func adminTikiUpdatePrice(_ request :  BookTikiUpdatePrice_Request, success :@escaping (()->Void), failure: ((String)->Void))
    {
        services.request(api: .tikiUpdatePrice, param: request.dictionary(), success: { (response) in
            success()
        }) { (error) in
            
        }
    }

    
    
}
