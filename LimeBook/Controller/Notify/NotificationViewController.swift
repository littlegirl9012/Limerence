//
//  NotificationViewController.swift
//  LimeBook
//
//  Created by Lê Dũng on 9/3/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

class NotificationViewController: MasterViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var btSetting: UIButton!
    var noti : [LimeNotification] = []
    @IBOutlet weak var tbView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tbView.setIdentifier("NotificationCell")
        loadData()
        simpleNavi.set("Thông báo")
        simpleNavi.bringSubview(toFront: self.btSetting)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
        self.homeNavi.disableRight()
    }
    func loadData()
    {
        let request  = NotificationList_Request()
        services.notificationList(request , success: { (response) in
            self.noti.removeAll()
            self.noti.append(contentsOf: response)
            self.tbView.reloadData()
        }) { (error) in
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tbView.dequeueReusableCell(withIdentifier: "NotificationCell") as! NotificationCell
        cell.set(self.noti[indexPath.row])
        return cell;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noti.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let request = BookDetail_Request()
        request.book_id = self.noti[indexPath.row].target_id
        weak var weakself = self;
        services.bookDetail(request, success: { (response) in
            let detail = NewsDetailViewController()
            detail.book = response
            weakself?.push(detail)
        }) { (errror) in
            
        }
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let request = NotificationDelete_Request()
            request.notification_id = self.noti[indexPath.row].id
            weak var weakself = self;
            services.notificationDelete(request, success: {
                weakself?.noti.remove(at: indexPath.row)
                weakself?.tbView.deleteRows(at: [indexPath], with: .fade)
            }) { (error) in
                
            }
        }
    }

}
