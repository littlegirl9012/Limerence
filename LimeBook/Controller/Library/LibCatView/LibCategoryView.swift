//
//  LibCategoryView.swift
//  LimeBook
//
//  Created by Lê Dũng on 9/25/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

protocol LibCategoryViewDelegate : class {
    
    func libCategoryViewDidSelect(_ value : BookCategory)
}

class LibCategoryView: GreenView , UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var tbVIew: UITableView!
    @IBOutlet weak var heightCat: NSLayoutConstraint!
    
    weak var delegate : LibCategoryViewDelegate?

    @IBOutlet weak var contentView: UIView!
    
    override func initStyle()
    {
        tbVIew.delegate = self
        tbVIew.dataSource = self;
        tbVIew.setIdentifier("LibCatCell")
        contentView.dropShadow(radius: 2, width: 1, height: 1, opacity: 0.24, shadowRadius : 6)

        isHidden = true ;
    }
    
    func toggle()
    {
        isHidden = !isHidden
    }
    func close()
    {
        isHidden = true
    }

    func refreshData()
    {
        heightCat.constant = 386.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbVIew.dequeueReusableCell(withIdentifier: "LibCatCell") as! LibCatCell
        cell.set(categoryInstance.bookCategory[indexPath.row])
        return cell 
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryInstance.bookCategory.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.libCategoryViewDidSelect(categoryInstance.bookCategory[indexPath.row])
        
    }
}
