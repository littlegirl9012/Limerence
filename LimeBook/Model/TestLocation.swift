//
//  TestLocation.swift
//  MiBook
//
//  Created by Lê Dũng on 1/14/19.
//  Copyright © 2019 limerence. All rights reserved.
//

import UIKit

class TestLocation: Mi {
    
    

}



class Location_request : Mi {
    
    @objc dynamic  var locationId = "08f6f30f-4667-49e5-8050-fd0488594d6e"
    
}


extension Services
{
    func locationRequest()
    {
        let request = Location_request.init()
        
        services.requestLocation(api: .test, param: request.dictionary(), success: { (response) in
            
        }) { (error) in
            
        }
    }
}

