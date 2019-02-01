//
//  BookRefSelectedViewController.swift
//  MiBook
//
//  Created by Lê Dũng on 1/20/19.
//  Copyright © 2019 limerence. All rights reserved.
//

import UIKit


protocol BookRefSelectedViewControllerDelegate : class {
    func BookRefSelectedViewControllerSelect(_ bookRefer : BookReference)
}

class BookRefSelectedViewController: MasterViewController, BookRefSelectedHeaderDelegate, UITableViewDelegate,UITableViewDataSource {
    
    
    var bookRefer : BookReference!
    
    weak var delegate : BookRefSelectedViewControllerDelegate?
    @IBOutlet weak var tbView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        tbView.setIdentifier("BookRefSelectedCell")
        tbView.setIdentifier("BookRefSelectedTypeCell")
        
        weak var weakself = self;
        navigationView.set(style: .back, title: "Chọn Bộ Sách") {
            weakself?.pop()
        }
        tbView.reloadData()
        btAdd.backgroundColor = template.primaryColor
        btAdd.setTitleColor(.white, for: .normal)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbView.dequeueReusableCell(withIdentifier: "BookRefSelectedCell") as! BookRefSelectedCell
        cell.set(bookRef.bookRefList[indexPath.section].child[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView =  BookRefSelectedHeader.init(frame: CGRect.init())
        headerView.set(bookRef.bookRefList[section])
        headerView.delegate = self
        return headerView
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return bookRef.bookRefList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let ref = bookRef.bookRefList[section]
        if(ref.isSelected)
        {
            return ref.child.count
        }
        return 0
    }
    
    
    
    func BookRefSelectedHeaderTouchin(_ value: BookReference) {
        let index = bookRef.bookRefList.index{$0.id == value.id}
        if(value.child.count > 0)
        {
            
            bookRefer = bookRef.bookRefList[index!]
            
            let indexPath = IndexPath.init(row: 0, section: index!)
            collapse()
            value.isSelected = true
            tbView.reloadData()
            tbView.scrollToRow(at: indexPath, at: .top, animated: true)
        }

    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 48
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let book = bookRef.bookRefList[indexPath.section].child[indexPath.row]
        book.isSelected = !book.isSelected
        tableView.reloadRows(at: [indexPath], with: .fade)
    }
    @IBOutlet weak var btAdd: UIButton!
    
    func collapse()
    {
        for item in bookRef.bookRefList
        {
            item.isSelected = false;
        }
    }
    @IBAction func touchIn(_ sender: Any)
    {
        if(bookRefer == nil)
        {
            view.warning(title: "Lỗi", desc: "Vui lòng chọn bộ sách giao khoa")
            return
        }
        else
        {
            var isSelect = false
            for item in bookRefer.child
            {
                if(item.isSelected)
                {
                    isSelect = true ;
                }
            }
            if(!isSelect)
            {
                view.warning(title: "Lỗi", desc: "Vui lòng chọn sách")
                return
            }
        }
        
        
        let copyBookRef : BookReference = BookReference()
        copyBookRef.name = bookRefer.name
        copyBookRef.id = bookRefer.id
        
        for item in bookRefer.child
        {
            if(item.isSelected)
            {
                copyBookRef.child.append(item)
            }
        }
        delegate?.BookRefSelectedViewControllerSelect(copyBookRef)
        collapse()
        pop()
    }
    
}


