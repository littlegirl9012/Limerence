//
//  CartInstance.swift
//  MiBook
//
//  Created by Lê Dũng on 12/9/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit
let  cart = CartInstance.sharedInstance()

class CartInstance: NSObject {
    static var instance: CartInstance!

    var order : [Order] = []
    class func sharedInstance() -> CartInstance
    {
        if(self.instance == nil)
        {
            self.instance = (self.instance ?? CartInstance())
        }
        return self.instance
    }

    
    func addProduct(_ book : Book)
    {
        let targetIndex = self.order.index{$0.user_id == book.user_id}
        if(targetIndex == nil)
        {
            let newOrder = Order()
            newOrder.user_id = book.user_id
            newOrder.aliasname = book.aliasname
            newOrder.avatar = book.avatar
            newOrder.product.append(book)
            order.append(newOrder)
        }
        else
        {
            if self.order[targetIndex!].product.index(where: {$0.id == book.id}) == nil
            {
                self.order[targetIndex!].product.append(book)
            }
        }
        notifyInstance.post(.cartUpdateItem, nil)
    }
    
    func remove(_ product : Book)
    {
        let targetIndex = order.index{$0.user_id == product.user_id}
        let targetOrder = order[targetIndex!]
        
        let targetIndexProduct = targetOrder.product.index{$0.id == product.id}
        targetOrder.product.remove(at: targetIndexProduct!)
        
        if(targetOrder.product.count == 0)
        {
            order.remove(at: targetIndex!)
        }
    }
    
    func clear()
    {
        for item in cart.order
        {
            item.product.removeAll()
        }
        
        cart.order.removeAll()
    }
}
