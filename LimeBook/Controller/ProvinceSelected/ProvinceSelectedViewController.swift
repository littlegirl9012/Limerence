//
//  ProvinceSelectedViewController.swift
//  Mobile_68
//
//  Created by Lê Dũng on 7/19/18.
//  Copyright © 2018 Ledung. All rights reserved.
//

import UIKit

protocol ProvinceControllerDelegate {
    func provinceControllerDidSelect(_ province : DHMProvince, district : DHMDistrict)
}

class ProvinceSelectedViewController: MasterViewController , UITableViewDelegate , UITableViewDataSource, ProvinceCellDelegate, NavigationViewDelegate
{
    

    var delegate : ProvinceControllerDelegate!
    @IBOutlet weak var tbView: UITableView!
    
    
    var provinSelected : DHMProvince!
    var provinceObject : [DHMProvince] = []
    var displayObject : [DHMProvince] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tbView.setIdentifier("ProvinceCell")
        tbView.setIdentifier("DistrictCell")

        tbView.estimatedRowHeight = 50;
        addressInstance.getProvinceDistrict()
        
        provinceObject.append(contentsOf: addressInstance.provinceList)
        for item in provinceObject
        {
            item.child.removeAll()
            let child = addressInstance.getChild(item)
            if(child != nil)
            {
                item.child.append(contentsOf: child!)
            }
        }
        displayObject.append(contentsOf: provinceObject)
        tbView.reloadData()
        navigationView.set(style: .back, title: "Tỉnh thành/ Quận huyện") {
            self.navigationController?.popViewController(animated: false)
        }
        
        navigationView.enableSearch(true)
        navigationView.delegate = self;
        navigationView.setSearchPlaholder("Tìm kiếm..")
    }
    func navigationViewClearTouch() {
        displayObject.removeAll()
        displayObject.append(contentsOf: provinceObject)
        tbView.reloadData()
    }
    
    func navigationViewSearching(_ searchText: String) {
        
        
        displayObject = provinceObject.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        tbView.reloadData()
        
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let object = displayObject[indexPath.section].child[indexPath.row];
        let cell = tbView.dequeueReusableCell(withIdentifier: "DistrictCell") as! DistrictCell
        cell.set(object )
        return cell

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        delegate.provinceControllerDidSelect(displayObject[indexPath.section ], district: displayObject[indexPath.section].child[indexPath.row])
        self.navigationController?.popViewController(animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return displayObject.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let province = displayObject[section]
        if(province.IsSelect)
        {
            return province.child.count
        }
        return 0
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tbView.dequeueReusableCell(withIdentifier: "ProvinceCell") as! ProvinceCell
        cell.set(displayObject[section])
        cell.delegate = self;
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    
    func collapse()
    {
        for item in displayObject
        {
            item.IsSelect = false;
        }
    }

    
    func provinceCellDidSelect(_ value: DHMProvince) {
        view.endEditing(true)
        let index = displayObject.index{$0.id == value.id}
        if(value.child.count > 0)
        {
            self.provinSelected = value ;
            let indexPath = IndexPath.init(row: 0, section: index!)
            collapse()
            value.IsSelect = true
            tbView.reloadData()
            tbView.scrollToRow(at: indexPath, at: .top, animated: true)
            

        }
    }
}
