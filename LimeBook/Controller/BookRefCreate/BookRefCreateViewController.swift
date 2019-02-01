//
//  BookRefCreateViewController.swift
//  MiBook
//
//  Created by Lê Dũng on 1/20/19.
//  Copyright © 2019 limerence. All rights reserved.
//

import UIKit

enum RefType : Int
{
    case gift = 0
    case trading = 1
}

class BookRefCreateViewController: MasterViewController, UITableViewDelegate,UITableViewDataSource, BookRefSelectedViewControllerDelegate, BookRefHeaderViewDelegate, BookRefAddressCellDelegate, ProvinceControllerDelegate, BookRefHeaderRadioVIewDelegate, BookRefNoteCellDelegate{
    
    
    
    @IBOutlet weak var btCreate: UIButton!
    
    var province : DHMProvince?
    var district : DHMDistrict?
    
    var price = 0.0
    var note = ""
    var phone = ""
    
    let headerRadioView = BookRefHeaderRadioVIew.init(frame: CGRect.init())
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(section == 0)
        {
            if(bookRefer != nil)
            {
                return bookRefer.child.count
            }
        }
        if(section == 1)
        {
            return 1
        }
        if(section == 2)
        {
            return 1
        }
        return 0
    }
    
    var bookRefer : BookReference!
    
    @IBOutlet weak var tbView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weak var weakself = self;
        navigationView.set(style: .back, title: "Tạo Bộ Sách Giáo Khoa")
        {
            weakself?.pop()
        }
        
        tbView.backgroundColor = template.backgroundColor
        tbView.setIdentifier("BookRefItemCell")
        tbView.setIdentifier("BookRefAddressCell")
        tbView.setIdentifier("BookRefNoteCell")
        headerRadioView.delegate = self ;
        
        tbView.backgroundColor = template.backgroundColor
        
        
        btCreate.backgroundColor = template.primaryColor
        btCreate.setTitleColor(.white, for: .normal)
        
        phone = userInstance.user.phone
        if(userInstance.user.province_id != -1)
        {
            province = DHMProvince()
            province?.id = userInstance.user.province_id
            province?.name = userInstance.user.province_name
            
            district = DHMDistrict()
            district?.id = userInstance.user.district_id
            district?.name = userInstance.user.district_name
            
            tbView.reloadData()
        }

        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == 0 )
        {
            let cell = tbView.dequeueReusableCell(withIdentifier: "BookRefItemCell") as! BookRefItemCell
            cell.set(bookRefer.child[indexPath.row])
            return cell
        }
        
        
        if(indexPath.section == 1)
        {
            let cell = tbView.dequeueReusableCell(withIdentifier: "BookRefNoteCell") as! BookRefNoteCell
            cell.set(headerRadioView.refType)
            cell.delegate = self;
            return cell
        }
        
        if(indexPath.section == 2)
        {
            let cell = tbView.dequeueReusableCell(withIdentifier: "BookRefAddressCell") as! BookRefAddressCell
            cell.set(province: province, district: district)
            cell.delegate = self;
            return cell
        }
        
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let bookRefHeader = BookRefHeaderView()
        bookRefHeader.btAdd.isUserInteractionEnabled = false
        
        if(section == 0)
        {
            var title = ""
            bookRefHeader.btAdd.isUserInteractionEnabled = true
            if(bookRefer == nil)
            {
                title = "Chọn bộ sách giáo khoa"
            }
            else
            {
                title = bookRefer.name
            }
            bookRefHeader.set(_title: title, section: section)
            bookRefHeader.delegate = self;
        }
        
        if(section == 1)
        {
            return headerRadioView
        }
        
        if(section == 2)
        {
            bookRefHeader.set(_title: "Địa chỉ", section: 1)
            bookRefHeader.hidenRightView()
        }
        
        return bookRefHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func bookRefHeaderViewTouchIn(_ section: Int) {
        let bookRefSelect = BookRefSelectedViewController()
        bookRefSelect.delegate = self
        push(bookRefSelect)
    }
    
    func BookRefSelectedViewControllerSelect(_ bookRefer: BookReference) {
        self.bookRefer = bookRefer
        tbView.reloadData()
    }
    
    
    func BookRefAddressCellSelectAddress() {
        let provinceSel = ProvinceSelectedViewController()
        provinceSel.delegate = self;
        push(provinceSel)
    }
    
    func provinceControllerDidSelect(_ province: DHMProvince, district: DHMDistrict) {
        self.district = district
        self.province = province
        tbView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func BookRefHeaderRadioVIewChangeState(_ state: RefType) {
        tbView.reloadData()
    }
    
    @IBAction func createTouch(_ sender: Any)
    {
        if(bookRefer == nil)
        {
            view.warning(title: "Lỗi", desc: "Vui lòng chọn bộ sách giáo khoa")
            return
        }
        
        if(province == nil)
        {
            view.warning(title: "Lỗi", desc: "Vui lòng chọn địa phương")
            return
        }
        
        if(phone.trim().length == 0)
        {
            view.warning(title: "Lỗi", desc: "Vui lòng nhập số điện thoại")
            return
        }
        
        
        if((headerRadioView.refType == .trading))
        {
            if(price == 0)
            {
                view.warning(title: "Lỗi", desc: "Vui lòng nhập giá bán lại")
                return
            }
        }
        
        bookRefGroupInsert()
    }

    
    func bookRefGroupInsert()
    {
        let request = ReferenceGroupCreate_Request()
        request.province_id = province!.id;
        request.district_id = district!.id;
        request.user_id = userInstance.user.id;
        request.price = self.price;
        request.note = self.note;
        request.reference_type_id = bookRefer.id;
        
        
        
        for item in bookRefer.child
        {
            request.book_reference.append(item.dictionary(ignore: ["child"]) as NSDictionary)
        }
        
        weak var weakself = self
        services.referenceGroupCreate(request: request, success: { () in
            weakself?.view.dialog(title: "Thông báo", desc: "Đăng sách thành công", type: .info, acceptBlock: {
                
                weakself?.pop()
            }, cancelBlock: {
                
            })
        }) { (error) in
            
        }

        
    }
    func BookRefAddressCellSelectChangePhone(_ vallue: String) {
        phone = vallue
    }
    
    func BookRefNoteCellChangeNote(_ value: String) {
        note = value
    }
    
    func BookRefNoteCellChangePrice(_ value: String) {
        price = value.doubleValue()

    }
}

