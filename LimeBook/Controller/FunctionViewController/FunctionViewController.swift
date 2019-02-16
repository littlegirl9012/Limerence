//
//  FunctionViewController.swift
//  LimeBook
//
//  Created by Lê Dũng on 12/3/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit


//
//  SettingViewController.swift
//  LimeBook
//
//  Created by Lê Dũng on 8/18/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

enum SettingType : Int
{
    case userInfo  = 1
    case bookMap  = 2
    case bookFace = 3
    case library = 4
    case admin = 5
    case store = 6
    case order = 7
    case school = 8
    case univer = 9
    case search = 10

    
    
}


class SettingItem : NSObject
{
    var name = ""
    var des = ""
    var image : UIImage?
    var url = ""
    var settingType = SettingType.userInfo
    var color : UIColor!
    var controller : UIViewController!
    init(_ name : String, _ image : UIImage) {
        self.name = name
        self.image = image
    }
    
    init(_ name : String, _ des : String,_ url : String, _ image : UIImage?)
    {
        self.name = name
        self.des = des
        self.url = url
        self.image = image
    }
}


class FunctionViewController: MasterViewController, UITableViewDelegate, UITableViewDataSource {
    
    var trading : BookTradingViewController!

    var items  :  [SettingItem] =  []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tbView.setIdentifier("SettingCell");
        tbView.setIdentifier("SettingItemCell");
        simpleNavi.set("MiBook.vn")

        
        let search = SettingItem.init("Tìm kiếm sách", "book_search".image())
        search.settingType = . search
        search.color = "00a4a4".hexColor()

        
        let bookRound = SettingItem.init("Sách quanh tôi", "BookRound".image())
        bookRound.settingType = . bookMap
        bookRound.color = "145f71".hexColor()
        
        let face = SettingItem.init("Facebook - Hội Yêu Sách", "facebook".image())
        face.settingType = . bookFace
        face.color = "3b5998".hexColor()
        face.controller = HYSViewController()
        
        let library = SettingItem.init("Thư viện MiBook", "library".image())
        library.settingType = . library
        library.color = "e46e49".hexColor()
        
        let store = SettingItem.init("Cửa hàng sách", "library".image())
        store.settingType = . store
        store.color = "e46e49".hexColor()
        
        
        
        let school = SettingItem.init("Sách giáo khoa", "class_book".image())
        school.settingType = . school
        school.color = "17bb68".hexColor()

        let univer = SettingItem.init("Đại học - Cao đẳng", "school".image())
        univer.settingType = . univer
        univer.color = "9d194e".hexColor()

        

        items.append(search)
        items.append(face)
        items.append(bookRound)
        items.append(store)
        items.append(school)
        items.append(univer)
        
        if(userInstance.user.id == 1)
        {
            let admin = SettingItem.init("Quản trị", "home_setting".image())
            admin.settingType = . admin
            admin.color = "ffdd00".hexColor()
            items.append(admin)
        }
        tbView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.homeNavi.disableRight()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tbView.dequeueReusableCell(withIdentifier: "SettingItemCell") as! SettingItemCell
        cell.set(items[indexPath.row])
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let stype = items[indexPath.row].settingType
        if(stype == .userInfo)
        {
            push(UserViewController())
        }
        if(stype == .bookMap)
        {
            push(BookMapViewController())
        }
        if(stype == .bookFace)
        {
            push(items[indexPath.row].controller)
        }
        if(stype == .store)
        {
            if(self.trading == nil)
            {
                trading = BookTradingViewController()
            }
            push(trading)
        }
        if(stype == .order)
        {
            push(OrderHistoryViewController())
        }
        
        if(stype == .school)
        {
            push(BookRefContentViewController())
        }

        if(stype == .univer)
        {
            push(BookRefUniverViewController())
        }

        if(stype == .search)
        {
            let select = BookSelectViewController()
            select.selectType = .search
            push(select)
        }
        if(stype == .admin)
        {
            let select = AdminViewController()
            push(select)
        }

        
    }
    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    @IBOutlet weak var tbView: UITableView!
    
    
    
}


