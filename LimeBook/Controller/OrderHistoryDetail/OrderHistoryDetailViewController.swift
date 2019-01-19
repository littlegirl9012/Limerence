//
//  OrderHistoryDetailViewController.swift
//  MiBook
//
//  Created by Lê Dũng on 1/13/19.
//  Copyright © 2019 limerence. All rights reserved.
//

import UIKit

class OrderHistoryDetailViewController: MasterViewController,OrderDetailHeaderStatusViewDelegate , UITableViewDelegate,UITableViewDataSource, OrderChangeStateViewDelegate{
    
    
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
        
        
        let request = OrderDetail_Request()
        request.user_id = userInstance.user.id
        request.order_id  = order.id

        
        weak var weakself = self;
        
        services.ordersDetail(request: request, success: { (response) in
            weakself?.product.append(contentsOf: response.1)
            
            weakself?.orderDetail = response.0
            weakself?.orderDetail.product.append(contentsOf: response.1)
            weakself?.tbView.reloadData()
        }) { (errror) in
            
        }
        
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        
    
        
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.section == 0)
        {
            if(order.isUserSell())
            {
                let cell = tbView.dequeueReusableCell(withIdentifier: "OrderDetailBuyCell" ) as! OrderDetailBuyCell
                if(self.orderDetail != nil)
                {
                    cell.set(self.orderDetail)

                }
                return cell;
            }
            else
            {
                let cell = tbView.dequeueReusableCell(withIdentifier: "OrderDetailInfoCell" ) as! OrderDetailInfoCell
                return cell;
            }
        }
        else
        {
            let cell = tbView.dequeueReusableCell(withIdentifier: "OrderDetailInfoCell" ) as! OrderDetailInfoCell
            cell.set(self.product[indexPath.row])
            return cell;
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(section == 2)
        {
            return 54
        }
        return 48
    }

    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = OrderDetailHeaderView.init(frame: CGRect.init())
        if(section == 0)
        {
            if(order.isUserSell())
            {
                header.setTitle(value: "Thông Tin Người Mua")
            }
            else
            {
                header.setTitle(value: "Thông Tin Người Bán")
            }
            return header
        }
        if(section == 1)
        {
            header.setTitle(value: "Thông Tin Sách")
            return header
        }

        if(section == 2)
        {
            let headerStatusView = OrderDetailHeaderStatusView.init(frame: CGRect.init())
            headerStatusView.delegate = self;
            headerStatusView.set(self.order)
            return headerStatusView
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0)
        {
            return 1
        }
        if(section == 1)
        {
            return product.count
        }
        if(section == 2)
        {
            return 0
        }

        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if(section == 1)
        {
            let footer = OrderDetailInfoPriceView.init(frame: CGRect.init())
            if(orderDetail != nil)
            {
                footer.set(orderDetail)
            }
            return footer
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if(section == 1)
        {
            return 72
        }
        return 0;
    }
    
    func orderDetailHeaderStatusViewChangeState() {
        let stateView = OrderChangeStateView.init(frame: CGRect.init())
        stateView.delegate = self;
        view.alertBox(stateView, ratio: 0.9)
    }

    func orderChangeStateViewAccept()
    {
        weak var weakself = self;
        view.hideAlertBox()

        view.dialogView(title: "Xác nhận", desc: "Đồng ý bán và giao hàng", type: .infoConfirm, acceptBlock: {
            weakself?.changeState(.accept)
        }) {
            
        }
    }
    
    func changeState(_ type : OrderStatus)
    {
        let request = OrderChange_Request()
        request.order_id = order.id
        request.status = type.rawValue
        weak var weakself = self;
        services.ordersChange(request: request, success: { (order,books) in
            weakself?.order.status = order.status
            weakself?.tbView.reloadData();
        }) { (error) in
            
        }
    }
    
    func orderChangeStateViewDeny() {
        view.hideAlertBox()
        weak var weakself = self;
        view.dialogView(title: "Xác nhận", desc: "Bạn có chắc muốn huỷ bán đơn hàng này không", type: .infoConfirm, acceptBlock: {
            weakself?.changeState(.seller_cancel)
        }) {
            
        }
    }
    func orderChangeStateViewSuccess() {
        weak var weakself = self;
        view.hideAlertBox()

        view.dialogView(title: "Xác nhận", desc: "Đã giao hàng thành công", type: .infoConfirm, acceptBlock: {
            weakself?.changeState(.success)

        }) {
            
        }

    }

    func orderChangeStateViewClose() {
        view.hideAlertBox()
    }

}
