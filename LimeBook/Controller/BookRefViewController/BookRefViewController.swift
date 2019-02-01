//
//  BookRefViewController.swift
//  MiBook
//
//  Created by Lê Dũng on 1/20/19.
//  Copyright © 2019 limerence. All rights reserved.
//

import UIKit

class BookRefViewController: MasterViewController , ProvinceControllerDelegate, UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var btAdd: UIButton!
    @IBOutlet weak var btClass: UIButton!
    @IBOutlet weak var btTop: UIButton!
    var provinceSelected  : DHMProvince = DHMProvince()
    var districtSelected  : DHMDistrict = DHMDistrict()
    var referType : BookReference!

    var listData : [ReferenceGroup] = []
    
    
    
    
    @IBOutlet weak var tbView: UITableView!
    @IBOutlet weak var classView: MIDropListView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weak var weakself = self;
        
        
        tbView.setIdentifier("BookRefListCell")
        
        let address = userInstance.user.addressDisplay()
        btTop.setTitle(address, for: .normal)
        btTop.setTitleColor(.white, for: .normal)
        classView.drawRadius(4, color: template.dangerColor, thickness: 0)
        classView.rightWidth.constant = 0
        classView.backgroundColor = UIColor.clear
        classView.tfContent.textColor = UIColor.white
        classView.tfContent.backgroundColor = .clear
        
        
        var refTypeList : [String] = []
        
        for item in bookRef.bookRefList
        {
            refTypeList.append(item.name)
        }
        
        classView.setIndex(refTypeList, inView: self.view) { (response) in
        
            weakself?.referType = bookRef.bookRefList[response]
            weakself?.loadGroup()
        }
        
        referType = bookRef.bookRefList[0]
        btTop.setTitle("Chọn địa phương", for: .normal)
        topView.backgroundColor = template.primaryColor

        tbView.backgroundColor = template.backgroundColor
        
        
        if(userInstance.user.province_id != -1)
        {
            provinceSelected.id = userInstance.user.province_id
            provinceSelected.name = userInstance.user.province_name
            
            districtSelected.id = userInstance.user.district_id
            districtSelected.name = userInstance.user.district_name
            fillProvince()
        }
    }

    
    
    @IBAction func topTouch(_ sender: Any) {
        let province = ProvinceSelectedViewController()
        province.delegate = self;
        push(province)
    }
    
    func provinceControllerDidSelect(_ province: DHMProvince, district: DHMDistrict) {
        self.provinceSelected = province
        self.districtSelected = district
        fillProvince()
        
    }
    
    func fillProvince()
    {
        let disply = provinceSelected.name + ", " + districtSelected.name
        btTop.setTitle(disply, for: .normal)
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
    
    @IBAction func addTouch(_ sender: Any) {
        let bookRefAdd = BookRefCreateViewController()
        push(bookRefAdd)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadGroup()
    }
    
    func loadGroup()
    {
        if(provinceSelected.id != -1)
        {
            let request = ReferenceGroupList_Request()
            request.reference_type_id = referType.id
            request.province_id = provinceSelected.id
            request.district_id = districtSelected.id
            weak var weakself = self;
            services.referenceGroupList(request: request, success: { (response) in
                weakself?.listData.removeAll()
                weakself?.listData.append(contentsOf: response)
                weakself?.tbView.reloadData()
            }) { (error) in
                
            }
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let book = self.listData[indexPath.row]
        
        let info = BookRefInfoViewController()
        info.group = book
        push(info)
    }
}
