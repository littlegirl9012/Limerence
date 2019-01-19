//
//  OrderHistoryDetail_Sell_ViewController.swift
//  MiBook
//
//  Created by Lê Dũng on 1/17/19.
//  Copyright © 2019 limerence. All rights reserved.
//

import UIKit

class OrderHistoryDetail_Sell_ViewController: MasterViewController, UITableViewDelegate,UITableViewDataSource,OrderDetailHeaderStatusViewDelegate {

    @IBOutlet weak var tbView: UITableView!
    
    var order : Order!
    var orderDetail : Order!
    var product : [Book] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationView.set(style: .back, title: "Lịch Sử Mua Bán") {
            self.pop()
        }
        
        tbView.setIdentifier("OrderDetailInfoCell")
        tbView.setIdentifier("OrderDetailBuyCell")
        
        tbView.backgroundColor = template.backgroundColor
        
        weak var weakself = self;
        let request = OrderDetail_Request()
        request.user_id = userInstance.user.id
        request.order_id  = order.id

        services.ordersDetail(request: request, success: { (response) in
            weakself?.product.append(contentsOf: response.1)
            
            weakself?.orderDetail = response.0
            weakself?.orderDetail.product.append(contentsOf: response.1)
            weakself?.tbView.reloadData()
        }) { (errror) in
            
        }

    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbView.dequeueReusableCell(withIdentifier: "OrderDetailInfoCell" ) as! OrderDetailInfoCell
        cell.set(product[indexPath.row])
        return cell;

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0)
        {
            return product.count
        }
        else{
            return 0

        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if(section == 0)
        {
            let header = OrderDetailHeaderView.init(frame: CGRect.init())
            header.setTitle(value: "Thông Tin Sách")
            return header
        }
        else
        {
            let headerStatusView = OrderDetailHeaderStatusView.init(frame: CGRect.init())
            headerStatusView.delegate = self;
            headerStatusView.set(self.order)
            
            headerStatusView.btStatus.setTitle("Huỷ mua", for: .normal)
            headerStatusView.btStatus.backgroundColor = template.sellColor;

            return headerStatusView
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(section == 1)
        {
            return 56
        }
        return 48
    }

    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = OrderDetailInfoPriceView.init(frame: CGRect.init())
        if(section == 1)
        {
            return nil
        }
        if(orderDetail != nil)
        {
            footer.set(orderDetail)
        }
        return footer
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 72
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func orderDetailHeaderStatusViewChangeState() {
        
        weak var weakself = self;
        view.dialog(title: "Huỷ Đơn hàng", desc: "Bạn có chắc chắn muốn huỷ đơn hàng này không", type: .warningConfirm, acceptBlock: {
            weakself?.cancelOrder()
        }) {
            
        }
    }
    
    func cancelOrder()
    {
        let request = OrderChange_Request()
        request.order_id = order.id
        request.status = OrderStatus.buyer_cancel.rawValue;
        weak var weakself = self;
        services.ordersChange(request: request, success: { (order,books) in
            weakself?.order.status = order.status
            weakself?.tbView.reloadData();
        }) { (error) in
            
        }
    }
}
