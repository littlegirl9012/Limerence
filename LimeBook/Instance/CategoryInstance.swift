//
//  CategoryInstance.swift
//  LimeBook
//
//  Created by Lê Dũng on 9/24/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

let  categoryInstance = CategoryInstance.sharedInstance()

class CategoryInstance: NSObject
{
    static var instance: CategoryInstance!
    var bookCategory : [BookCategory] = []
    var bookType : [LimeBookType] = []

    class func sharedInstance() -> CategoryInstance
    {
        if(self.instance == nil)
        {
            self.instance = (self.instance ?? CategoryInstance())
        }
        return self.instance
    }
    
    
    func loadCategory()
    {
        services.categoryList(success: { (response) in
            self.bookCategory.removeAll()
            self.bookCategory.append(contentsOf: response)
        }) { (errror) in
            
        }
    }
    
    func loadType()
    {
        services.bookTypeList(success: { (response) in
            self.bookType.removeAll()
            self.bookType.append(contentsOf: response)
        }) { (errror) in
            
        }
    }
    
}
