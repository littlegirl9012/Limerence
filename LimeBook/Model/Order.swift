//
//  Order.swift
//  MiBook
//
//  Created by Lê Dũng on 12/9/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

enum OrderStatus : Int
{
    case pending = 0
    case accept = 1
    case buyer_cancel = 2
    case seller_cancel = 3
    case success = 4
}


class Order: Mi {
    @objc dynamic var user_id = -1
    @objc dynamic var aliasname = ""
    @objc dynamic var avatar = ""
    @objc dynamic var phone = ""
    @objc dynamic var address = ""
    @objc dynamic var id = -1

    @objc dynamic var create_date = ""

    
    
    @objc dynamic var seller_id = -1
    @objc dynamic var status = -1
    @objc dynamic var product_price = 120000.0


    @objc dynamic var product : [Book] = []
    @objc dynamic var products : [NSDictionary] = []
    
    func totalPrice()->Double
    {
        return product.map({$0.price}).reduce(0, +)
    }
    class func  list(data : [Dictionary<String, Any>]) -> [Order]
    {
        var output  : [Order]  = []
        for item in data
        {
            let unit = Order.init(dictionary: item as NSDictionary)
            output.append(unit)
        }
        return output
    }
    
    func buySellTitle()->String
    {
        if(seller_id == userInstance.user.id)
        {
            return "Đơn bán sách"
        }
        return "Đơn mua sách"
    }
    
    func isUserSell()->Bool
    {
        return userInstance.user.id == seller_id
    }
    
    func getStatusTitle() -> String
    {
        let status_e = OrderStatus.init(rawValue: status)!
        var result = ""
        
        if(isUserSell())
        {
            switch status_e {
            case .accept: result = "Đã xác nhận bán và giao hàng" ; break ;
            case .buyer_cancel: result =   "Người mua huỷ đơn hàng"; break ;
            case .seller_cancel:  result =  "Từ chối bán" ;break ;
            case .pending: result =  "Đơn hàng chờ xử lý" ; break ;
            case .success: result =  "Đơn hàng hoàn tất" ;break ;
            }

        }
        
        else
        {
            switch status_e {
            case .accept: result = "Đang giao hàng" ; break ;
            case .buyer_cancel: result =   "Đã huỷ "; break ;
            case .seller_cancel:  result =  "Người bán từ chối" ;break ;
            case .pending: result =  "Chờ người bán xử lý" ; break ;
            case .success: result =   "Đơn hàng hoàn tất" ;break ;
            }
            
        }
        return result ;
     }

    
    func endState() ->Bool
    {
        let status_e = OrderStatus.init(rawValue: status)!
        if(status_e == .buyer_cancel || (status_e == .seller_cancel) || (status_e == .success))
        {
            return true
        }
        else
        {
            return false ;
        }
    }
    
    func shipUserTitle()->String
    {
        return totalPrice() > 200000 ? "Người bán trả" : "Người mua trả"
    }
    
    func prepareRequest() -> NSDictionary
    {
        products.removeAll()
        for item in product
        {
            products.append(item.dictionary(ignore: ["book_type_n","product","atributeTitle","attibuteConent","attibuteShortContent","media_model","image_media"]) as NSDictionary)
        }
        return dictionary(ignore: ["product"]) as NSDictionary
    }
}

class OrderInsert_Request : Mi
{
    @objc dynamic var orders : [NSDictionary] = []
    @objc dynamic var user_id = userInstance.user.id
    @objc dynamic var address = ""
    @objc dynamic var phone = ""

}

class OrderList_Request : Mi
{
    @objc dynamic var user_id = userInstance.user.id
}
class OrderDetail_Request : Mi
{
    @objc dynamic var user_id = -1
    @objc dynamic var order_id = -1

}
class OrderChange_Request : Mi
{
    @objc dynamic var order_id = -1
    @objc dynamic var status = -1
    @objc dynamic var user_id = userInstance.user.id

    
}


extension Services
{
    func ordersInsert(request: OrderInsert_Request,success :@escaping (()->Void), failure: ((String)->Void))
    {
        services.request(api: .orderInsert, param:request.dictionary(), success: { (response) in
            
            success()
            
        }) { (error) in
            
        }
    }
    func ordersList(success :@escaping (([Order])->Void), failure: ((String)->Void))
    {
        services.request(api: .orderList, param:OrderList_Request.init().dictionary(), success: { (response) in
            success(Order.list(data: response.data as! [Dictionary<String, Any>] ))
        }) { (error) in
            
        }
    }
    
    func ordersDetail(request : OrderDetail_Request ,success :@escaping (((Order,[Book]))->Void), failure: ((String)->Void))
    {
        services.request(api: .orderDetail, param:request.dictionary(), success: { (response) in
            
            let totalDictionary = response.data as! NSDictionary
            let order = Order.init(dictionary: totalDictionary.value(forKey: "order") as! NSDictionary)
            let products = Book.simpleList(data: totalDictionary.value(forKey: "product") as! [Dictionary<String, Any>])
            success((order,products))
            }) { (error) in
            
        }
    }
    
    func ordersChange(request : OrderChange_Request ,success :@escaping (((Order,[Book]))->Void), failure: ((String)->Void))
    {
        services.request(api: .orderChange, param:request.dictionary(), success: { (response) in
            
            let totalDictionary = response.data as! NSDictionary
            let order = Order.init(dictionary: totalDictionary.value(forKey: "order") as! NSDictionary)
            let products = Book.simpleList(data: totalDictionary.value(forKey: "product") as! [Dictionary<String, Any>])
            success((order,products))
        }) { (error) in
            
        }
    }
}
