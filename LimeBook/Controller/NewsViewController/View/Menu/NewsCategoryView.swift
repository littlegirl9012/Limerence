//
//  NewsCategoryView.swift
//  LimeBook
//
//  Created by Lê Dũng on 10/6/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

protocol NewsCategoryViewDelegate : class {
    func newsCategoryDidSelect(_ value : [Int])
}

class NewsCategoryView: GreenView , UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var tbView: UITableView!
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var cHeight: NSLayoutConstraint!
    weak var delegate : NewsCategoryViewDelegate?
    
    var typeList : [LimeBookType] = []
    
    override func initStyle() {
        tbView.delegate = self;
        tbView.dataSource = self;
        tbView.setIdentifier("NewsCategoryCell")
        mainView.dropShadow()
    }
    
    func toggleHiden()
    {
        self.typeList.removeAll()
        self.typeList.append(contentsOf: categoryInstance.bookType)
        self.isHidden = !self.isHidden
        cHeight.constant = (54 * CGFloat(self.typeList.count)) + 56
        tbView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbView.dequeueReusableCell(withIdentifier: "NewsCategoryCell") as! NewsCategoryCell
        cell.set(self.typeList[indexPath.row])
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return typeList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        categoryInstance.bookType[indexPath.row].userSelect = !categoryInstance.bookType[indexPath.row].userSelect
        tbView.reloadRows(at: [indexPath], with: .fade)
    }
    
    @IBAction func acceptTouch(_ sender: Any) {
        var idS : [Int] = []
        for item in categoryInstance.bookType
        {
            if(item.userSelect)
            {
                idS.append(item.query_id)
            }
        }
        delegate!.newsCategoryDidSelect(idS)
        toggleHiden()
    }
    
    
    
}
