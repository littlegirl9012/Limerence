//
//  BookRefInfoViewController.swift
//  MiBook
//
//  Created by Lê Dũng on 1/26/19.
//  Copyright © 2019 limerence. All rights reserved.
//

import UIKit

class BookRefInfoViewController: MasterViewController , UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var btAdd: UIButton!
    @IBOutlet weak var tbView: UITableView!
    
    var  items : [BookReference] = []
    var group : ReferenceGroup!
    
    @IBOutlet weak var btTrash: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        weak var weakself = self;
        navigationView.set(style: .back, title: "Thông Tin") {
            weakself?.pop()
        }
        tbView.setIdentifier("BookRefInfoCell")
        tbView.setIdentifier("BookRefInfoAddress")
        
        loadData()
        
        tbView.backgroundColor = template.backgroundColor
        
        
        btAdd.isHidden = group.isMine()
        btAdd.drawRound()
        navigationView.bringSubview(toFront: btTrash)
        
        btTrash.isHidden = (userInstance.user.id != group.user_id)
    }
    @IBAction func trashTouch(_ sender: Any) {
        weak var weakself = self;
        view.dialog(title: "Xác nhận", desc: "Bạn có muốn xoá không", type: .warningConfirm, acceptBlock: {
            weakself?.delete()
        }) {
            
        }
    }
    
    func loadData()
    {
        let request = ReferenceGroupDetail_Request()
        request.reference_group_id = group.id
        weak var weakself  = self;
        services.referenceGroupDetail(request: request, success: { (respone) in
            weakself?.items.removeAll()
            weakself?.items.append(contentsOf: respone.1)
            weakself?.tbView.reloadData()
        }) { (error) in
            
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if(section == 0)
        {
            return items.count
        }
        else
        {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if(indexPath.section == 0)
        {
            let cell = tbView.dequeueReusableCell(withIdentifier: "BookRefInfoCell") as! BookRefInfoCell
            cell.set(items[indexPath.row])
            return cell
        }
        else
        {
            let cell = tbView.dequeueReusableCell(withIdentifier: "BookRefInfoAddress") as! BookRefInfoAddress
            cell.set(group)
            return cell

            
        }
        return UITableViewCell()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = BookRefInfoHeaderView.init(frame: CGRect.init())
        if(section == 0)
        {
            header.lbTitle.text = "Bộ sách GK " + group.name
            header.lbPrice.text = group.price.priceValue()
        }
        else
        {
            header.lbTitle.text = "Thông tin người đăng"
            header.lbPrice.text = ""
        }
        return header
    }
    @IBAction func touchIn(_ sender: Any) {
        let chat = ChatViewController()
        chat.target = group.user()
        push(chat)
    }
    
    func delete()
    {
        let request = ReferenceGroupDelete_Request()
        request.reference_group_id = self.group.id
        weak var weakself = self;
        services.referenceGroupDelete(request: request, success: {
            
            weakself?.view.info(title: "Thông báo", desc: "Xoá thành công")
            weakself?.pop()
        }) { (error) in
            
        }
    }
    
}
