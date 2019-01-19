//
//  User.swift
//  LimeBook
//
//  Created by Lê Dũng on 8/18/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit


import GoogleMaps
import GooglePlaces

class GMSBookMarker: GMSMarker {
    var user_id = -1
}

enum ContactStatus : Int
{
    case waiting = 1
    case answer = 2
    case beauty = 12
    case none = 0
}

enum UserStore : Int
{
    case personal = 0
    case coffee = 12
    case bookStore = 24
}

class User: Mi {

    @objc dynamic var id = -1
    @objc dynamic var username = ""
    @objc dynamic var password = ""
    @objc dynamic var aliasname = ""
    @objc dynamic var avatar = "https://steamuserimages-a.akamaihd.net/ugc/269463939060405893/119A5E4828FACC5F55A992CB27D4A4B25DD57241/"
    @objc dynamic var cover = ""
    @objc dynamic var caption = ""
    @objc dynamic var phone = ""
    @objc dynamic var dob = ""
    @objc dynamic var gender = 0
    @objc dynamic var user_type = 0
    @objc dynamic var latitude = 0.0
    @objc dynamic var longitude = 0.0
    @objc dynamic var user_store = 0
    @objc dynamic var contact_id = -1
    @objc dynamic var info_success = false
    @objc dynamic var isOnline = false
    @objc dynamic var status = -1
    @objc dynamic var mediaAvatar : MediaFile!
    var user_store_n = UserStore.personal
    var status_n = ContactStatus.answer
    
    func storeName()->String
    {
        switch user_store_n {
        case .personal:
            return "Người dùng phổ thông"
        case .coffee:
            return "Coffee sách"
        case .bookStore:
            return "Nhà sách"
        }
    }
    
    func imageStore()-> UIImage
    {
        switch user_store_n {
        case .personal:
            return "BookMap".image()
        case .coffee:
            return "BookCoffee".image()
        case .bookStore:
            return "BookStore".image()
        }
    }
    
    class func  list(data : [Dictionary<String, Any>]) -> [User]
    {
        var output  : [User]  = []
        for item in data
        {
            let unit = User.init(dictionary: item as NSDictionary)
            unit.mediaAvatar = MediaFile.init(unit.avatar, .image)
            unit.user_store_n = UserStore.init(rawValue: unit.user_store)!
            output.append(unit)
        }
        
        return output
    }
    
    func processMedia()
    {
       mediaAvatar = MediaFile.init(avatar, .image)
    }

    
    func downloadMedia()
    {
        mediaAvatar.downloadContent()
    }
    
    
    func genderDisplay() ->String
    {
        if(gender == 0)
        {
            return "Nam"
        }
        else
        {
            return "Nữ"
        }
    }
    
    func isMe() ->Bool
    {
        return (userInstance.user.id == id)
    }
    
    func isNotMe() ->Bool
    {
        return (userInstance.user.id != id)
    }

    func gmsMarker() -> GMSBookMarker
    {
        let market = GMSBookMarker.init(position: CLLocationCoordinate2D.init(latitude: latitude, longitude: longitude))
        market.icon = imageStore()
        market.snippet = aliasname
        market.user_id = id;
        return market
    }
}

class General_Request : Mi
{
    @objc dynamic var user_id = userInstance.user.id
}
class UserLogin_Request : Mi
{
    @objc dynamic var username = ""
    @objc dynamic var password = ""

}
class UserNear_Request: Mi
{
    @objc dynamic var user_id = -1;
    @objc dynamic var latitude = 0.0;
    @objc dynamic var longitude = 0.0;
    @objc dynamic var distance = 0.0;
}

class UserInfo_Request: Mi
{
    @objc dynamic var user_id = userInstance.user.id;
    @objc dynamic var target_user_id = -1;
}


class UserRegister_Request : Mi
{
    @objc dynamic var username = ""
    @objc dynamic var password = ""
}

class UserSearch_Request : Mi
{
    @objc dynamic var user_id = userInstance.user.id
    @objc dynamic var phone = ""
    @objc dynamic var keyword = ""

}

class NewsSearch_Request : Mi
{
    @objc dynamic var keyword = ""
}


class UserDetail_Request : Mi
{
    @objc dynamic var user_id = -1
}

class UserConsultant_Request : Mi
{
    @objc dynamic var consultant_id = 1
}

class UserUpdateAA_Request : Mi
{
    @objc dynamic var user_id = 1
    @objc dynamic var aliasname = ""
    @objc dynamic var avatar = ""
}

class UserUpdateToken_Request : Mi
{
    @objc dynamic var user_id = 1
    @objc dynamic var token = ""
}

class UserUpdateAvatar_Request : Mi
{
    @objc dynamic var user_id = 1
    @objc dynamic var avatar = ""
}

class UserUpdateInfo_Request : Mi
{
    @objc dynamic var user_id = 1
    @objc dynamic var university_id = -1

    @objc dynamic var gender = 0
    @objc dynamic var phone = ""
    @objc dynamic var aliasname = ""
    @objc dynamic var dob = ""
}

extension Services
{
    
    func userDetail(_ request : UserDetail_Request, success :((User)->Void), failure: ((String)->Void))
    {
        services.request(api: .userDetail, param: request.dictionary(), success: { (response) in
            
        }) { (error) in
            
        }
    }
    
    func userConsultant(_ request : UserConsultant_Request, success :@escaping (([User])->Void), failure: ((String)->Void))
    {
        services.request(api: .userConsultant, param: request.dictionary(), success: { (response) in
            success(User.list(data: response.data as! [Dictionary<String, Any>]))
        }) { (error) in
            
        }
    }
    
    func userSearch(_ request : UserSearch_Request, success :@escaping (([User])->Void), failure: ((String)->Void))
    {
        services.request(api: .userSearch, param: request.dictionary(), success: { (response) in
            success(User.list(data: response.data as! [Dictionary<String, Any>]))
        }) { (error) in
            
        }
    }

    
    func userLogin(_ request : UserLogin_Request, success :@escaping (([User])->Void), failure: @escaping ((String)->Void))
    {
        services.request(api: .userLogin, param: request.dictionary(), success: { (response) in
            success(User.list(data: response.data as! [Dictionary<String, Any>]))
        }) { (error) in
            failure(error)
        }
    }
    
    func userLoginFacebook(_ request : UserLogin_Request, success :@escaping (([User])->Void), failure: @escaping ((String)->Void))
    {
        services.request(api: .userLoginFacebook, param: request.dictionary(), success: { (response) in
            success(User.list(data: response.data as! [Dictionary<String, Any>]))
        }) { (error) in
            failure(error)
        }
    }

    
    func userRegister(_ request : UserRegister_Request, success :@escaping (([User])->Void), failure: @escaping ((String)->Void))
    {
        services.request(api: .userRegister, param: request.dictionary(), success: { (response) in
            success(User.list(data: response.data as! [Dictionary<String, Any>]))
        }) { (error) in
            failure(error)
        }
    }


    func userContacts(success :@escaping (([User])->Void), failure: ((String)->Void))
    {
        services.request(api: .contactList, param: General_Request().dictionary(), success: { (response) in
            success(User.list(data: response.data as! [Dictionary<String, Any>]))
        }) { (error) in
            
        }
    }

    func userContactAccept(_ request : UserRegister_Request,success :@escaping (([User])->Void), failure: ((String)->Void))
    {
        services.request(api: .contactList, param: General_Request().dictionary(), success: { (response) in
            success(User.list(data: response.data as! [Dictionary<String, Any>]))
        }) { (error) in
            
        }
    }

    func userUpdateAA( request :UserUpdateAA_Request,success :@escaping (([User])->Void), failure: @escaping ((String)->Void))
    {
        services.request(api: .userUpdateAA, param: request.dictionary(), success: { (response) in
            success(User.list(data: response.data as! [Dictionary<String, Any>]))
        }) { (error) in
            failure("Vui lòng thử lại sau")
        }
    }
    
    func userUpdateToken( request :UserUpdateToken_Request,success :@escaping (()->Void), failure: ((String)->Void))
    {
        services.request(api: .userUpdateToken, param: request.dictionary(), success: { (response) in
            success()
        }) { (error) in
            
        }
    }

    func userUpdateAvatar( request :UserUpdateAvatar_Request,success :@escaping (()->Void), failure: ((String)->Void))
    {
        services.request(api: .userUpdateAvatar, param: request.dictionary(), success: { (response) in
            success()
        }) { (error) in
            
        }
    }

    func userUpdateInfo( request :UserUpdateInfo_Request,success :@escaping (([User])->Void), failure: ((String)->Void))
    {
        services.request(api: .userUpdateInfo, param: request.dictionary(), success: { (response) in
            success(User.list(data: response.data as! [Dictionary<String, Any>]))
        }) { (error) in
            
        }
    }
    func userNear( request :UserNear_Request,success :@escaping (([User])->Void), failure: ((String)->Void))
    {
        services.request(api: .userNear, param: request.dictionary(), success: { (response) in
            success(User.list(data: response.data as! [Dictionary<String, Any>]))
        }) { (error) in
            
        }
    }

    
    func userSearch( request :UserNear_Request,success :@escaping (([User])->Void), failure: ((String)->Void))
    {
        services.request(api: .userSearch, param: request.dictionary(), success: { (response) in
            success(User.list(data: response.data as! [Dictionary<String, Any>]))
        }) { (error) in
            
        }
    }

    
    func userInfo( request :UserInfo_Request,success :@escaping ((User)->Void), failure: ((String)->Void))
    {
        services.request(api: .userInfo, param: request.dictionary(), success: { (response) in
            let user = User.init(dictionary: response.data as! NSDictionary)
            success(user)
        }) { (error) in
            
        }
    }

}


