//
//  HomeViewController.swift
//  Mobile_68
//
//  Created by Lê Dũng on 5/12/18.
//  Copyright © 2018 Ledung. All rights reserved.
//

import UIKit
import SwipeableTabBarController
class HomeViewController: MasterViewController, HomeNaviViewDelegate
{
    
    var news = NewsViewController()
    var conversation = CommunicatoinViewcontroller()
    var setting = UserViewController()
    var contact = ContactViewController()
    var consult = ConsultantViewController()
    var notification = NotificationViewController()
    var function  = FunctionViewController()
    var searchEngineViewController  : SearchEngineViewController!

    var searchMode = false ;
    
    let item0 = UITabBarItem.init(title: "", image: "news_disable".image(), tag: 0)
    let item1 = UITabBarItem.init(title: "", image: "chat_disable".image(), tag: 1)
    let item2 = UITabBarItem.init(title: "", image: "Contact".image(), tag: 1)
    let item3 = UITabBarItem.init(title: "", image: "user_disable".image(), tag: 1)
    let item4 = UITabBarItem.init(title: "", image: "Conver".image(), tag: 1)
    let item5 = UITabBarItem.init(title: "", image: "notify_disable".image(), tag: 1)
    let item6 = UITabBarItem.init(title: "", image: "function_disable".image(), tag: 1)
    
    var item0Selected : UIImage! = UIImage(named: "news_enable")?.withRenderingMode(.alwaysOriginal)
    let item1Selected : UIImage! = UIImage(named: "chat_enable")?.withRenderingMode(.alwaysOriginal)
    var item5Selected : UIImage! = UIImage(named: "notify_enable")?.withRenderingMode(.alwaysOriginal)
    var item6Selected : UIImage! = UIImage(named: "function_enable")?.withRenderingMode(.alwaysOriginal)
    var item3Selected : UIImage! = UIImage(named: "user_enable")?.withRenderingMode(.alwaysOriginal)

    @IBOutlet weak var bottomContraits: NSLayoutConstraint!
    
    
   // @IBOutlet weak var topView: HomeTopView!
    let mainTabar = MainTabbarViewController()
    @IBOutlet weak var contentView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.homeNavi.delegate = self;
        conversation.homeNavi = self.homeNavi
        contact.homeNavi = self.homeNavi
        news.homeNavi = self.homeNavi
        setting.homeNavi = self.homeNavi
        consult.homeNavi = self.homeNavi
        notification.homeNavi = self.homeNavi
        function.homeNavi = self.homeNavi

        self.addChildViewController(mainTabar)
        contentView.addSubview(mainTabar.view)
        contentView.setLayout(mainTabar.view)
        
        mainTabar.tabBar.layer.borderWidth = 0.0
        mainTabar.tabBar.layer.borderColor = UIColor.clear.cgColor
        mainTabar.tabBar.tintColor = "3588D1".hexColor()
        
        mainTabar.tabBar.barTintColor = template.navigationColor
        mainTabar.tabBar.isTranslucent = false
        
        news.tabBarItem = item0
        conversation.tabBarItem = item1
        contact.tabBarItem = item2
        setting.tabBarItem = item3
        consult.tabBarItem = item4
        notification.tabBarItem = item5
        
        
        item6.selectedImage = item6Selected
        item5.selectedImage = item5Selected
        item0.selectedImage = item0Selected
        item1.selectedImage = item1Selected
        item3.selectedImage = item3Selected

        function.tabBarItem = item6

        
        mainTabar.viewControllers  = [news,notification,conversation,function,setting]

        notifyInstance.add(self, .reloadContactList, selector: #selector(contactRefresh))
        notifyInstance.addM(self, .conversationReceive, selector: #selector(refreshConversation))
        notifyInstance.addM(self, .conversationUpdateItem, selector: #selector(refreshConversation))

        news.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        conversation.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        setting.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        notification.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        contact.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        function.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)

        mainTabar.setTabBarSwipe(enabled: false)
        mainTabar.isSwipeEnabled = false
        mainTabar.selectedIndex = 4
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if(apppInstance.isMatchVersion())
        {
            bottomContraits.constant = 0
        }
        else
        {
            #if !DEBUG
            bottomContraits.constant = 36
            #endif
        }
    }
    @IBAction func updateTouch(_ sender: Any) {
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(URL.init(string: apppInstance.ios_link)!, options: [:]) { (response) in
                
            }
        } else
        {
            UIApplication.shared.openURL(URL.init(string: apppInstance.ios_link)!)
        }
    }
    
    @objc func contactRefresh()
    {
        
        let tabRT = mainTabar.tabBar.items![3]

        let count = contactDataStore.contacts.count{$0.status == 2}
        if(count > 0)
        {
            tabRT.badgeValue = String(count)
        }
        else
        {
            tabRT.badgeValue = nil
        }
    }
    
    @objc func refreshConversation()
    {
        let tabRT = mainTabar.tabBar.items![2]
        let count = confernceDataStore.conversationNotifyUnreadMessage()

        if(count > 0)
        {
            tabRT.badgeValue = String(count)
        }
        else
        {
            tabRT.badgeValue = nil
        }

    }

    func enableSearch()
    {
        searchEngineViewController  = SearchEngineViewController()
        contentView.addSubview(searchEngineViewController.view)
        self .addChildViewController(searchEngineViewController)
    }
    
    func disabelSearch()
    {
        searchEngineViewController.view.removeFromSuperview()

    }
    
    func homeNaviViewActiveSearchEngine()
    {
        if(!searchMode)
        {
            searchMode = true;
            enableSearch()
        }
        
    }
    
    func homeNaviViewDisableSearch()
    {
        searchMode = false
        disabelSearch()
    }
    
    func homeNaviViewSearch(_ text: String)
    {
        searchEngineViewController.search(text)
    }
}
