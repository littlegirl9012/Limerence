//
//  OrderHistoryViewController.swift
//  MiBook
//
//  Created by Lê Dũng on 1/12/19.
//  Copyright © 2019 limerence. All rights reserved.
//

import UIKit

class OrderHistoryViewController: MasterViewController , UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var tbView: UITableView!
    var data : [Order] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationView.set(style: .back, title: "Lịch Sử Mua Bán") {
            self.pop()
        }
        
        tbView.setIdentifier("OrderHistoryCell")
        
        weak var weakself = self;
        tbView.delegate = self;
        tbView.dataSource = self;
        
        
        
        
        services.ordersList(success: { (response) in
            weakself?.data.removeAll()
            weakself?.data.append(contentsOf: response)
            weakself?.tbView.reloadData()
        }) { (error) in
            
        }
        
        tbView.backgroundColor = template.backgroundColor
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tbView.dequeueReusableCell(withIdentifier: "OrderHistoryCell") as! OrderHistoryCell
        cell.set(order: self.data[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let orderDetail = self.data[indexPath.row]
        
        if(orderDetail.isUserSell())
        {
            let detail = OrderHistoryDetailViewController()
            detail.order = orderDetail
                push(detail)
        }
        else
        {
            let detail = OrderHistoryDetail_Sell_ViewController()
            detail.order = orderDetail
            push(detail)

        }
    }
}
