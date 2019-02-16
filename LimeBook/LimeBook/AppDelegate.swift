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
    // https://tiki.vn/sach-tieng-anh/c320?src=tree&page=158
    ////
    ////
    
    //Van hoc tieng viet https://tiki.vn/sach-van-hoc/c839?src=tree&page=2  -> 169
    //kinh te : https://tiki.vn/sach-kinh-te/c846?src=tree&page=2 ->100
    //thiếu nhi/ mẫu giáo : https://tiki.vn/mau-giao-0-6-tuoi/c5936?src=tree&page=
    //thiếu nhi/6-11 https://tiki.vn/nhi-dong-6-11-tuoi/c3369?src=tree&page=2
    // thieu nhi 11-15 https://tiki.vn/thieu-nien-11-15-tuoi/c3370?src=tree&page=2
    //thieu nhi ehon https://tiki.vn/ehon-nhat-ban/c6040?src=tree&page=2
    // van hoc thieu nhi https://tiki.vn/van-hoc-thieu-nhi/c1754?src=tree&page=
    //dao duc ky nang song https://tiki.vn/bai-hoc-dao-duc/c852?src=tree&page=
    
    
    // kien thuc back khoa https://tiki.vn/kien-thuc-ky-nang/c853?src=tree&page=  //error
    // truyen co tich https://tiki.vn/truyen-co-tich/c1753?src=tree&page=   700
    // truyen ke cho be https://tiki.vn/truyen-ke-cho-be/c854?src=tree&page= 1340
    //truyen tranh thieu nhi https://tiki.vn/truyen-tranh-thieu-nhi/c855?src=tree&page= 1955
    //to mau luyen chu https://tiki.vn/to-mau-luyen-chu/c856?src=tree&page= 1833
    //sach hoc ngoai ngu thieu nhi https://tiki.vn/sach-hoc-ngoai-ngu-thieu-nhi/c10078?src=tree&page= 300
    
    //---------
    //kỹ nang - song dep https://tiki.vn/sach-ky-nang-song-dep/c870?src=tree&page=60
    
    //----------
    //me va em be https://tiki.vn/sach-ba-me-em-be/c2527?src=tree 1236
    
    // sach hoc ngoai ngu https://tiki.vn/ngoai-ngu-tu-dien/c887?src=tree 3133
    
    // sach tham khảo https://tiki.vn/sach-tham-khao/c2320?src=tree. 4935
    
    
    // tu dien https://tiki.vn/tu-dien/c897?src=tree 473
    
    // kien thuc tong hop https://tiki.vn/sach-kien-thuc-tong-hop/c873?src=tree 3590
    
    // giao trinh dai hoc cao dang https://tiki.vn/gia-trinh-dai-hoc-cao-dang/c6991?src=tree 259
    
    // truyen tranh https://tiki.vn/truyen-tranh/c1084?src=tree  2114
    
    
    // lịch sử : https://tiki.vn/lich-su-dia-ly/c880?src=tree 619
    
    // khoa hoc ky thua https://tiki.vn/khoa-hoc-ky-thuat/c879?src=tree 535
    
    // dien anh nhac hoa https://tiki.vn/dien-anh-nhac-hoa/c881?src=tree 480
    
    // ton giao tam linh https://tiki.vn/ton-giao-tam-linh/c861?src=tree 1180
    
    // chinh tri phap ly https://tiki.vn/chinh-tri-phap-ly/c875?src=tree 1296
    
    
    // van hoa du lich https://tiki.vn/van-hoa-dia-ly-du-lich/c857?src=tree 430
    
    // nong lam ngu nghiep https://tiki.vn/nong-lam-ngu-nghiep/c882?src=tree 145
    // cong nghe thong tin https://tiki.vn/cong-nghe-thong-tin/c876?src=tree 146
    
    // y hoc https://tiki.vn/y-hoc/c885?src=tree. 768
    
    // tap chi https://tiki.vn/tap-chi-catalogue/c1468?src=tree.
    
    // tam ly gioi tinh https://tiki.vn/tam-ly-gioi-tinh/c868?src=tree 275
    
    // thuong thuc doi song https://tiki.vn/sach-thuong-thuc-doi-song/c862?src=tree 1365
    
    //        for i in 0..<30
    //        {
    ////            if(i%2 != 0)
    ////            {
    ////                 continue ;
    ////            }
    //            let url = "https://tiki.vn/sach-thuong-thuc-doi-song/c862?src=tree&page=" + String(i)
    //            let job = BlockOperation.init {
    //                services.customRequest(url: url, success: { (response) in
    //                    let first = "<div class=\"product-box-list\"" ;
    //
    //                    var subString = response.slice(from: "<div class=\"product-box-list\"", to: "<footer id=\"footer\">")
    ////                    var subString = response.slice(from: "<div class=\"product-box-list\"", to: "<div class=\"category-bottom-banner-wrap\">")
    //
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
    //                                        var priceAttri = TFHppleElement.init()
    //
    //                                        if((priceNode![4] as! TFHppleElement).children.count > 0 )
    //                                        {
    //                                            priceAttri = (priceNode![4] as! TFHppleElement).children[0] as! TFHppleElement
    //                                        }
    //
    //                                        var priceContent = ""
    //                                        if(priceAttri.content != nil)
    //                                        {
    //                                            priceContent = priceAttri.content.replacingOccurrences(of: " ₫", with: "")
    //                                            priceContent = priceAttri.content.replacingOccurrences(of: ".", with: "")
    //                                        }
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
    //                                if(request.author.length == 0)
    //                                {
    //                                    request.author = "unknow"
    //                                }
    //                                print("-------------------------------")
    //
    //                                print("\n title : \(request.title)")
    //                                print("\n author : \(request.author)")
    //                                print("\n tiki_id : \(request.tiki_id)")
    //                                print("\n tiki_link : \(request.tiki_link)")
    //                                print("\n cat_name : \(request.cat_name)")
    //
    //
    //
    //                                services.adminBookTikiInsert(request, success: { () in
    //
    //                                }, failure: { (errror) in
    //
    //                                })
    //
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
    
    var from = 0;
    var to = 2
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        _ = confernceDataStore
        _ = audioInstance

        
        
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(fahasa), userInfo: nil, repeats: true)
        
        UIApplication.shared.setMinimumBackgroundFetchInterval(UIApplicationBackgroundFetchIntervalMinimum)
        UIApplication.shared.statusBarStyle = .lightContent
        
        
        GMSServices.provideAPIKey("AIzaSyAJSrKxx17Zp37q5VIdSNvTmmISuqJgur8")
        GMSPlacesClient.provideAPIKey("AIzaSyAJSrKxx17Zp37q5VIdSNvTmmISuqJgur8")

        
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
        } else {
            // Fallback on earlier versions
        };
        
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().requestAuthorization(options:[.badge, .alert, .sound]){ (granted, error) in }
        } else {
            // Fallback on earlier versions
        }
        self.window?.makeKeyAndVisible()

        application.registerForRemoteNotifications()
        
        
        
        fahasa()
        
        bookRef.getRef()

        
        
        self.window?.rootViewController = IntroViewController()
        return true
    }
    
    func maintenance()
    {
        let mt = MaintenanceViewController()
        self.window?.rootViewController = mt ;
        
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
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        
        print("applicationDidEnterBackground")
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        print("applicationWillEnterForeground")
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        application.applicationIconBadgeNumber = 0
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
    
    
    @available(iOS 10.0, *)
    func userNotificationCenter(center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: (UNNotificationPresentationOptions) -> Void) {
        userInstance.setCustomKey("Receuve")
        
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        userInstance.setCustomKey("Receuve")
        
        completionHandler()
        
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        
        
        
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        
        return FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
    }
    
    
    


    @objc func fahasa()
    {
        
        return
        
        
//        let request = BookFahasaInsert_Request.init()
//        request.title = "sadf"
//        request.link = "link"
//        request.sell_price = 0.0
//        request.price = 0.0
//        services.adminFahasaInsert(request, success: {
//
//        }, failure: { (error) in
//
//        })
//

        
        
        //<li class="col-sm-3 col-xs-6 col-md-3 ">
        //tiki <div data-seller-product-id="1621209"
        //fa

                for i in from..<to
                {
                    
                    let job = BlockOperation.init {
                        let url = "https://www.fahasa.com/foreigncategory/page/\(i).html"
                        services.customRequest(url: url, success: { (response) in
                            let first = "<ul class=\"products-grid row fhs-top\"" ;
                            print("----\(i)")
                            var subString = response.slice(from: "<ul class=\"products-grid row fhs-top\"", to: "<div class=\"ma-footer-static\">")
        
                            if(subString != nil)
                            {
                                subString = first + subString!
                                let cafe: Data? = subString!.data(using: .utf8) // non-nil
                                let doc  =  TFHpple.init(xmlData: cafe)
                                
                                let element : [TFHppleElement] = doc?.search(withXPathQuery: "//div['product images-container']") as! [TFHppleElement]
                                
                                var j = 0
                                for item in element
                                {
                                    j = j+1;
                                    if(item.children.count == 5)
                                    {
                                        let node1  = item.children[1] as! TFHppleElement
                                        if(node1.children.count > 1)
                                        {
                                            let sub1 = node1.children[1] as! TFHppleElement
                                            let title = sub1.attributes["title"];
                                            let href = sub1.attributes["href"]
                                            
                                            
                                            
                                            
                                            if(title != nil)
                                            {
                                                let imageNode = node1.search(withXPathQuery: "//span['product-image']")
                                                let imageRef = ((imageNode![0] as! TFHppleElement).children[1] as! TFHppleElement).attributes["src"]
                                                
                                                var request = BookFahasaInsert_Request()
                                                request.side_id = "";
                                                request.title = title as! String
                                                request.link = (href as! String)
                                                request.image = imageRef as! String
                                                
                                                
                                                
                                                
                                                
                                                let price_id  = item.search(withXPathQuery: "//span['price-label']")
                                                var idArr = (price_id![2] as! TFHppleElement).attributes["id"]
                                                
                                                if(idArr != nil)
                                                {
                                                    var refArra = (idArr as! String).split(separator: "-")
                                                    request.side_id = String(refArra[2])
                                                }
                                                
                                                var priceNode : String? = (((item.search(withXPathQuery: "//span['price']")  as! [TFHppleElement])[2]).children[0] as! TFHppleElement).content
                                                if(priceNode != nil)
                                                {
                                                    priceNode = priceNode?.replacingOccurrences(of: "đ", with: "")
                                                    priceNode = priceNode?.replacingOccurrences(of: ".", with: "")
                                                    request.sell_price = priceNode!.doubleValue()
                                                }
                                                
                                                
                                                let realPriceNode = (item.search(withXPathQuery: "//span['price']"))  as! [TFHppleElement]
                                               if(realPriceNode.count >= 4)
                                               {
                                                var realPrice : String? = (((item.search(withXPathQuery: "//span['price']")  as! [TFHppleElement])[4] as!  TFHppleElement).children[0] as! TFHppleElement).content
                                                    if(realPrice != nil)
                                                    {
                                                        realPrice = realPrice!.replacingOccurrences(of: "đ", with: "")
                                                        realPrice = realPrice!.replacingOccurrences(of: ".", with: "")
                                                        request.price = realPrice!.doubleValue()
                                                        
                                                        
                                                    }

                                            }
                                                
                                                
                                                services.adminFahasaInsert(request, success: {
                                                    
                                                }, failure: { (error) in
                                                    
                                                })
                                                
//                                                return ;
//
                                                print("--------------------------\(j)")
//                                                print(request.dictionary())
                                                
                                                
                                                
                                            }
                                        }
                                        
                                    }
                                    
                                }

                            }
                        }) { (error) in
        
                        }
        
                    }
        
                    mediaQueue.mQueue.addOperation(job)
        
                }
        
        from = from + 2;
        to = to + 2;

    }
}


