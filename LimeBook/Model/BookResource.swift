//
//  BookResource.swift
//  MiBook
//
//  Created by Dũng Lê on 7/10/17.
//  Copyright © 2017 Ledung. All rights reserved.
//

import UIKit


enum BookResourceType : Int
{
    case local
    case sever
}

class BookResource: Mi {
    var ID : Int = 0
    var BookID = 0
    var Image = ""
    var imageLocal : UIImage!
    var mainImage = false;
    var imageURL = ""
    var imageType = BookResourceType.local

    
    
    class func  list(data : [Dictionary<String, Any>]) -> [BookResource]
    {
        var output  : [BookResource]  = []
        for item in data
        {
            let resource = BookResource.init(dictionary: item as NSDictionary)
            resource.imageType = .sever
            output.append(resource)
        }
        return output
    }
    
    
    func endUrl()-> URL
    {
        return  URL.init(string: "servicesConfig.urlBookImage.appending(Image)")!
    }

}



class BookResourceList_Request : Mi  // lấy danh sách hình ảnh của sách
{
    var BookID = 0
}


class BookResourceRegister_Request : Mi
{
    var BookID = 0
    var Image = ""
    
}
class BookResourceDelete_Request : Mi
{
    var BookResourceID = 0
}
class BookResourceDeleteAll_Request : Mi
{
    var BookID = 0
}


extension Services
{
    
}
