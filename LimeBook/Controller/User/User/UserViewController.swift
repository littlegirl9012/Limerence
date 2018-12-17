//
//  UserDetailViewController.swift
//  LimeBook
//
//  Created by Lê Dũng on 9/3/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit


enum UserInfoMenu : Int
{
    case infoDetail = 0
    case book = 1
    case news = 2
}

class UserDetailMenu : NSObject
{
    var name = ""
    var menuType = UserInfoMenu.infoDetail
    
    init(_ name : String) {
        
        super.init()
        
        self.name = name
        
    }
}


class UserViewController: MasterViewController, UITableViewDelegate, UITableViewDataSource {
    var headerView = UserInfoHeaderView()

    
    var menu  : [UserDetailMenu] = []
    @IBOutlet weak var tbView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        tbView.setIdentifier("UserDetailCell")
        
        simpleNavi.set("Trang Cá Nhân")
        
        let item0 = UserDetailMenu.init("Thông tin tài khoản")
        item0.menuType = .infoDetail
        let item1 = UserDetailMenu.init("Tủ sách")
        item1.menuType = .book
        menu.append(contentsOf: [item0,item1])
        tbView.reloadData()

    }

    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tbView.dequeueReusableCell(withIdentifier: "UserDetailCell") as! UserDetailCell
        cell.set(menu[indexPath.row])
        return cell
        
    }
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        headerView.set(userInstance.user)
        return headerView;
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = menu[indexPath.row]
        if(item.menuType == .infoDetail)
        {
            let page = UserInfoViewController()
            page.user = userInstance.user
            push(page)
        }
        if(item.menuType == .book)
        {
            let page = BookViewController()
            page.user = userInstance.user
            push(page)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.count
    }
}
