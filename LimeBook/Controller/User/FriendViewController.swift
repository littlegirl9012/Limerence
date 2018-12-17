//
//  UserInfoViewController.swift
//  LimeBook
//
//  Created by Lê Dũng on 8/22/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit
//
//  UserDetailViewController.swift
//  LimeBook
//
//  Created by Lê Dũng on 9/3/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit


class FriendViewController: MasterViewController, UITableViewDelegate, UITableViewDataSource {
    var headerView = UserInfoHeaderView()
    
    
    
    var user : User!
    
    
    var menu  : [UserDetailMenu] = []
    @IBOutlet weak var tbView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationView.set(style: .back, title: "Trang Cá Nhân") {
            self.pop()
        }
        
        let info = UserDetailMenu.init("Thông tin chung")
        info.menuType = .infoDetail
        let book = UserDetailMenu.init("Tủ sách ")
        book.menuType = .book
        
        let news = UserDetailMenu.init("Tin đã đăng")
        news.menuType = .news
        
        menu.append(contentsOf: [info,book,news])
        tbView.setIdentifier("UserDetailCell");
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tbView.dequeueReusableCell(withIdentifier: "UserDetailCell") as! UserDetailCell
        
        cell.set(menu[indexPath.row])
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let type = menu[indexPath.row].menuType
        
        if(type == .infoDetail)
        {
            let info = UserInfoViewController()
            info.user = user
            push(info)
        }
        
        if(type == .book)
        {
            let book = BookViewController()
            book.user = user
            push(book)
        }
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        headerView.set(user)
        return headerView;
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 240
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.count
    }
}

