//
//  CartViewController.swift
//  MiBook
//
//  Created by Lê Dũng on 1/6/19.
//  Copyright © 2019 limerence. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces




class CartViewController: MasterViewController, UITableViewDelegate, UITableViewDataSource, CartBookViewViewDelegate, GMSAutocompleteViewControllerDelegate, CartAcceptViewDelegate, CartAddressCellDelegate {
    @IBOutlet weak var tbView: UITableView!
    var placeSelected : GMSPlace!
    var phone = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        
        weak var weakself = self;
        navigationView.set(style: .back, title: "Giỏ Hàng") {
            weakself?.pop()
        }
        
        tbView.setIdentifier("CartItemCell")
        tbView.setIdentifier("CartAddressCell")
        
        tbView.backgroundColor = template.backgroundColor
        phone = userInstance.user.phone
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(cart.order.count == indexPath.section)
        {
            let cell = tbView.dequeueReusableCell(withIdentifier: "CartAddressCell") as! CartAddressCell
    
            cell.delegate = self;
            cell.setPlace(placeSelected)
            cell.tfPhone.text = phone
            return cell ;
        }
        else
        {
            let cell = tbView.dequeueReusableCell(withIdentifier: "CartItemCell") as! CartItemCell
            cell.set(cart.order[indexPath.section].product[indexPath.row])
            return cell
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if(section == cart.order.count)
        {
            return nil
        }
        let headerView = CartHeaderView.init(frame: CGRect.init())
        headerView.set(cart.order[section])
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(section == cart.order.count)
        {
            return 10
        }

        return 64
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if(section == cart.order.count)
        {
            let cartAccept = CartAcceptView.init(frame: CGRect.init())
            cartAccept.delegate = self;
            return cartAccept
        }

        let footerView = CartFooterView.init(frame: CGRect.init())
        footerView.set(cart.order[section])
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if(section == cart.order.count)
        {
            return 72
        }
        if(section == cart.order.count + 1)
        {
            return 56
        }


        return 72
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return cart.order.count + 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == cart.order.count)
        {
            return 1
        }

        return cart.order[section].product.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(indexPath.section == cart.order.count)
        {
            return
        }
        
        let book = cart.order[indexPath.section].product[indexPath.row]
        let defView = CartBookView.init(frame: CGRect.init())
        view.alertBox(defView, ratio: 0.90)
        defView.delegate = self ;
        defView.setBook(book)
    }
    
    func CartBookViewClose() {
        view.hideAlertBox()
    }
    func CartBookViewDelete(_ book: Book) {
        cart.remove(book)
        tbView.reloadData()
        view.hideAlertBox()

    }
    
    
    func googleAutoComplete()
    {
        let controller = GMSAutocompleteViewController.init()
        controller.navigationController?.navigationBar.barTintColor = template.naviColor
        
        let filter = GMSAutocompleteFilter()
        filter.country = "VN"
        filter.type = .address
        controller.autocompleteFilter = filter

        controller.delegate = self;
        present(controller) {
            
        }
    }
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        
        viewController.dismiss()
    }
    
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        self.placeSelected = place
        viewController.dismiss()
        tbView.reloadData()
        
        
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        
//        if((indexPath.section == cart.order.count) && (placeSelected == nil))
//        {
//            return 40
//        }
//        return UITableViewAutomaticDimension
//    }
    
    func cartRequest()
    {
        let request = OrderInsert_Request()
        request.user_id = userInstance.user.id
        request.phone = phone
        request.address = placeSelected.formattedAddress ?? ""
        for item in cart.order
        {
            request.orders.append(item.prepareRequest())
        }
        
        weak var weakself = self;
        services.ordersInsert(request: request, success: {
            weakself?.view.info(title: "Đặt hàng hoàn tất", desc: "Bạn có thể xem trạng thái đơn hàng trong ở trang cá nhân")
            cart.clear()
            weakself?.tbView.reloadData()
        }) { (error) in
            
        }
    }
    
    func cartAcceptViewTouch()
    {
        if(placeSelected == nil)
        {
            view.warning(title: "Thông báo lỗi", desc: "Vui lòng nhập địa chỉ nhận hàng")
            return
        }
        
        weak var weakself = self;
        view.dialogView(title: "Xác nhận ", desc: "Bạn có chắc chắn mua hàng không", type: .infoConfirm, acceptBlock: {
            weakself?.cartRequest()
        }) {
        }
    }
    
    func cartAddressCellTouchAddress() {
        googleAutoComplete()
    }
    
    func cartAddressChangePhone(_ value: String) {
        phone = value;
    }
}
