//
//  UniversityViewController.swift
//  MiBook
//
//  Created by Lê Dũng on 1/4/19.
//  Copyright © 2019 limerence. All rights reserved.
//

import UIKit

protocol UniversityViewControllerDelegate : class {
    func UniversityViewControllerDidSelect(_ university : University)
}


class UniversityViewController: MasterViewController , NavigationViewDelegate, UITableViewDelegate,UITableViewDataSource {
    
    var data : [University] = []
    var displayValue : [University] = []

    weak var delegate : UniversityViewControllerDelegate?
    
    
    @IBOutlet weak var tbView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tbView.setIdentifier("AddressCell")

        
        weak var weakself = self;
        
        services.universityList(success: { (response) in
            
            weakself?.displayValue.append(contentsOf: response)

        weakself?.data.append(contentsOf: response)
            weakself?.tbView.reloadData()
        }) { (errror) in
            
        }
        
        self.navigationView.set(style: .back, title: "Chọn Trường Đại Học") {
            weakself?.pop()
        }
        navigationView.enableSearch(true)
        navigationView.delegate = self;
        navigationView.setSearchPlaholder("Nhập tên trường đại học, cao đẳng..")
    }
    func navigationViewClearTouch() {
        displayValue.removeAll()
        displayValue.append(contentsOf: data)
        tbView.reloadData()
    }

    func navigationViewSearching(_ searchText: String) {
        
        
        displayValue = data.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        tbView.reloadData()

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbView.dequeueReusableCell(withIdentifier: "AddressCell") as! AddressCell
        cell.lbTitle.text = displayValue[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.UniversityViewControllerDidSelect(displayValue[indexPath.row])
        navigationController?.popViewController(animated: false)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayValue.count
    }
}
