//
//  AppDelegate.swift
//  LimeBook
//
//  Created by Lê Dũng on 8/15/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit
import UserNotifications
import FBSDKCoreKit
import FBSDKLoginKit
import GooglePlaces
import GoogleMaps
import SDWebImage

extension String {
    
    func slice(from: String, to: String) -> String? {
        
        return (range(of: from)?.upperBound).flatMap { substringFrom in
            (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                String(self[substringFrom..<substringTo])
            }
        }
    }
}


class tiki : Mi
{
}

let app = UIApplication.shared.delegate as! AppDelegate

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    var window: UIWindow?
    
    var loginNavi : UINavigationController!
    
    func nillDefaut(_ value : Any?)->String
    {
        if(value != nil)
        {
            return value! as! String
        }
        return ""
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        
////        
////
//        for i in 0..<299
//        {
//            
//            let url = "https://tiki.vn/sach-tieng-anh/c320?src=tree&page=" + String(i)
//            let job = BlockOperation.init {
//                services.customRequest(url: url, success: { (response) in
//                    let first = "<div class=\"product-box-list\"" ;
//
//                    var subString = response.slice(from: "<div class=\"product-box-list\"", to: "<div class=\"category-bottom-banner-wrap\">")
//                    subString = first + subString!
//                    let cafe: Data? = subString!.data(using: .utf8) // non-nil
//                    let doc  =  TFHpple.init(xmlData: cafe)
//
//                    let element : [TFHppleElement] = doc?.search(withXPathQuery: "//div['data-seller-product-id']") as! [TFHppleElement]
//
//                    for item in element
//                    {
//                        let name = item.attributes["data-title"];
//
//                        if(name != nil)
//                        {
//                            if(item.children.count > 0)
//                            {
//                                let node1 = (item.children[1] as! TFHppleElement)
//
//                                let imageNode = node1.search(withXPathQuery: "//img['product-image img-responsive']")
//                                let priceNode = node1.search(withXPathQuery: "//span['price-regular']")
//
//
//
//                                let request = BookTikiInsert_Request()
//
//                                if(priceNode != nil)
//                                {
//                                    if(priceNode!.count > 4)
//                                    {
//                                        var priceAttri = (priceNode![4] as! TFHppleElement).children[0] as! TFHppleElement
//                                        var priceContent = priceAttri.content.replacingOccurrences(of: " ₫", with: "")
//                                        priceContent = priceAttri.content.replacingOccurrences(of: ".", with: "")
//                                        if(priceContent.length > 2)
//                                        {
//                                            priceContent = String(priceContent.dropLast())
//                                            priceContent = String(priceContent.dropLast())
//                                            request.price = priceContent.doubleValue()
//                                        }
//
//
//
//
//                                    }
//
//                                }
//
//                                if(imageNode!.count > 0)
//                                {
//                                    let attriImage  = imageNode![0] as! TFHppleElement;
//                                    request.image = self.nillDefaut(attriImage.attributes["src"])
//                                }
//
//                                request.title =  (name as! String)
//                                request.author = self.nillDefaut(item.attributes["data-brand"])
//                                request.tiki_id = self.nillDefaut(item.attributes["data-id"])
//                                request.tiki_link = self.nillDefaut(node1.attributes["href"])
//                                request.cat_name = self.nillDefaut(item.attributes["data-category"])
//
//
//
//
//
//
//                                services.adminBookTikiInsert(request, success: { () in
//
//                                }, failure: { (errror) in
//
//                                })
////
//                            }
//                        }
//                        else
//                        {
//
//                        }
//
//                    }
//                }) { (error) in
//
//                }
//
//            }
//
//            mediaQueue.mQueue.addOperation(job)
//
//        }
//
//
//
//        return true;
//
//        
        _ = confernceDataStore
        _ = audioInstance
        UIApplication.shared.setMinimumBackgroundFetchInterval(UIApplicationBackgroundFetchIntervalMinimum)
        
        UIApplication.shared.statusBarStyle = .lightContent
        
        self.window?.makeKeyAndVisible()
        
        GMSServices.provideAPIKey("AIzaSyAJSrKxx17Zp37q5VIdSNvTmmISuqJgur8")
        GMSPlacesClient.provideAPIKey("AIzaSyAJSrKxx17Zp37q5VIdSNvTmmISuqJgur8")
        
        UNUserNotificationCenter.current().delegate = self;
        
        UNUserNotificationCenter.current().requestAuthorization(options:[.badge, .alert, .sound]){ (granted, error) in }
        application.registerForRemoteNotifications()
        
        startApp()
        
        
        
        
        
        
        
        
        
        return true
    }
    
    
    
    
    func startApp()
    {
        services.applicationInfo(success: { (response) in
            if(response.count > 0)
            {
                let appInfo = response.last
                userInstance.setApplicationInfo(appInfo!)
                if(appInfo?.maintenance)!
                {
                    self.maintenance()
                    return
                }
                if(device.Version == appInfo?.version)
                {
                    self.matchVersion()
                    return
                }
                else
                {
                    self.errorVersion()
                }
            }
            
            
        }) { (error) in
            
        }
        
    }
    
    
    
    
    func maintenance()
    {
        let mt = MaintenanceViewController()
        self.window?.rootViewController = mt ;
        
    }
    
    func errorVersion()
    {
        #if DEBUG
        matchVersion()
        #else
        self.window?.rootViewController = UpdateVersionViewController()
        #endif
    }
    
    func matchVersion()
    {
        userInstance.isMatchVersion = true
        if(userInstance.alreadyLogin())
        {
            
            let request = UserLogin_Request()
            request.username = userInstance.getUsername()
            request.password = userInstance.getPassword()
            services.userLogin(request, success: { (response) in
                if(response.count > 0)
                {
                    let userLogin = response[0]
                    userInstance.login(userLogin)
                    if(userLogin.info_success)
                    {
                        self.home()
                    }
                    else
                    {
                        if(userLogin.user_type == 1)
                        {
                            self.infoFace()
                        }
                        else
                        {
                            self.info()
                        }
                    }
                }
            }) { (error) in
                
                self.login()
            }
        }
        else
        {
            login()
        }
    }
    
    
    func login()
    {
        
        DispatchQueue.main.async {
            let loginVC = LoginViewController()
            self.loginNavi = UINavigationController.init(rootViewController: loginVC)
            self.window?.rootViewController  = self.loginNavi
            self.loginNavi.isNavigationBarHidden = true ;
            
        }
    }
    
    
    func info()
    {
        let info = InitInfoViewController()
        self.window?.rootViewController = info
    }
    
    func infoFace()
    {
        let info = InitInfoViewController()
        info.fromFace = true;
        self.window?.rootViewController = info
    }
    
    
    func home()
    {
        DispatchQueue.main.async {
            let homeV = HomeViewController()
            let navi = UINavigationController.init(rootViewController: homeV)
            navi.isNavigationBarHidden = true
            self.window?.rootViewController = navi
        }
    }
    
    func applicationWillResignActive(_ application: UIApplication)
    {
        //        print("applicationWillResignActive")
        //        if(userInstance.isLogin)
        //        {
        //            messageInstance.disConnectSocket()
        //        }
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        
        print("applicationDidEnterBackground")
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        print("applicationWillEnterForeground")
        if(userInstance.isLogin)
        {
            //            messageInstance.reconnect()
        }
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        application.applicationIconBadgeNumber = 0
        
        if(!userInstance.isMatchVersion)
        {
            startApp()
        }
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        print("applicationWillTerminate")
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        userInstance.setDeviceToken(deviceTokenString)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        userInstance.setCustomKey("Receuve")
        PNServices.receiveRemoteNotification(userInfo)
        completionHandler(.newData)
        
    }
    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        debugPrint("performFetchWithCompletionHandler")
        userInstance.setCustomKey("Receuve")
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        userInstance.setCustomKey("Receuve")
        
        completionHandler(true)
    }
    
    
    func userNotificationCenter(center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: (UNNotificationPresentationOptions) -> Void) {
        userInstance.setCustomKey("Receuve")
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        userInstance.setCustomKey("Receuve")
        
        completionHandler()
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        
        
        
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        
        return FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
    }
}


