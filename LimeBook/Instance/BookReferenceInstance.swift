//
//  BookReferenceInstance.swift
//  MiBook
//
//  Created by Lê Dũng on 1/20/19.
//  Copyright © 2019 limerence. All rights reserved.
//

import UIKit
let  bookRef = BookReferenceInstance.sharedInstance()

class BookReferenceInstance: Mi
{
    static var instance: BookReferenceInstance!
    
    var bookRefList : [BookReference] = []
    
    
    class func sharedInstance() -> BookReferenceInstance
    {
        if(self.instance == nil)
        {
            self.instance = (self.instance ?? BookReferenceInstance())
        }
        return self.instance
    }
    
    func getRef()
    {
        if(bookRefList.count > 0 )
        {
            return  ;
        }
        
        weak var weakself = self;
        services.bookRef(success: { (response ) in
            if(weakself?.bookRefList.count == 0)
            {
                weakself?.bookRefList.append(contentsOf: response)

            }
        }) { (error) in
            
        }
    }

}
