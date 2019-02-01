//
//  AddressInstance.swift
//  Mobile_68
//
//  Created by Lê Dũng on 7/17/18.
//  Copyright © 2018 Ledung. All rights reserved.
//

import UIKit
let  addressInstance = AddressInstance.sharedInstance()
class AddressInstance: NSObject {
    var provinceList  : [DHMProvince] = []
    var dictristList : [DHMDistrict] = []
    
    static var instance: AddressInstance!

    class func sharedInstance() -> AddressInstance
    {
        if(self.instance == nil)
        {
            self.instance = (self.instance ?? AddressInstance())
        }
        return self.instance
    }
    
    func getProvinceDistrict()
    {
        
        services.addressNode(success: { (province, district) in
            self.provinceList = DHMProvince.list(data: province as! [Dictionary<String, Any>])
            self.dictristList = DHMDistrict.list(data: district as! [Dictionary<String, Any>])

        }) { (error) in
            
        }
    }
    
    func provinceName(_ id : Int)->String
    {
        if let index = provinceList.index(where: {$0.id == id})
        {
            return provinceList[index].name
        }
        return ""
    }
    

    func getChild(_ province : DHMProvince) -> [DHMDistrict]?
    {
        return dictristList.filter{ $0.province_id == province.id }
    }

}
