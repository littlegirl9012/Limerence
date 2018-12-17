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
extension Services
{
    
    func adminBookTikiInsert(_ request :  BookTikiInsert_Request, success :@escaping (()->Void), failure: ((String)->Void))
    {
        services.request(api: .adminBookTikiInsert, param: request.dictionary(), success: { (response) in
            success()
        }) { (error) in
            
        }
    }
    
    
}
