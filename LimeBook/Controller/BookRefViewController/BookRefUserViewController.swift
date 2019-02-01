//
//  BookRefUserViewController.swift
//  MiBook
//
//  Created by Lê Dũng on 1/29/19.
//  Copyright © 2019 limerence. All rights reserved.
//

import UIKit

class BookRefUserViewController: MasterViewController, UITableViewDelegate,UITableViewDataSource {
    var listData : [ReferenceGroup] = []
    
    
    @IBOutlet weak var tbView: UITableView!

    @IBOutlet weak var topView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        topView.backgroundColor = template.primaryColor
        tbView.setIdentifier("BookRefListCell")
        
        tbView.backgroundColor = template.backgroundColor
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadGroup()
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tbView.dequeueReusableCell(withIdentifier: "BookRefListCell") as! BookRefListCell
        cell.set(listData[indexPath.row])
        return cell ;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listData.count
    }

    func loadGroup()
    {
        weak var weakself = self;
        services.referenceUser(success: { (response) in
            weakself?.listData.removeAll()
            weakself?.listData.append(contentsOf: response)
            weakself?.tbView.reloadData()

        }) { (errror) in
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let book = self.listData[indexPath.row]
        
        let info = BookRefInfoViewController()
        info.group = book
        push(info)
    }


}
