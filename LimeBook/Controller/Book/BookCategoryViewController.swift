//
//  BookCategoryViewController.swift
//  LimeBook
//
//  Created by Lê Dũng on 9/8/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit
extension BookCategoryViewDelegate {
    func bookCategoryDidSelect(_ cat : [BookCategory])
    {
        
    }
}


 protocol BookCategoryViewDelegate {
    func bookCategoryDidSelect(_ cat : [BookCategory])
}

class BookCategoryViewController: MasterViewController, UITableViewDelegate, UITableViewDataSource {
    var delegate : BookCategoryViewDelegate!

    var categoris : [BookCategory] = []
    
    
    
    
    

    func loadData()
    {
        services.categoryList( success: { (response) in
            self.categoris.removeAll()
            self.categoris.append(contentsOf: response)
            self.tbView.reloadData()
        }) { (error) in
            
        }
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.categoris.count
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbView.dequeueReusableCell(withIdentifier: "BookCatCell") as! BookCatCell
        cell.set(self.categoris[indexPath.row])
        return cell ;
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if((numberSelect() == 3) && (!self.categoris[indexPath.row].selected))
        {
            view.dialog(title: "Lỗi", desc: "Bạn chỉ được chọn tối đa 3 danh mục", type: .warning, acceptBlock: {
                
            }) {
                
            }
        }
        else
        {
            self.categoris[indexPath.row].toggleSeleted()
            self.tbView.reloadData()
        }
    }
    
    func numberSelect() -> Int
    {
        return  self.categoris.count{$0.selected == true}
    }
    
    override func viewDidLoad() {
        loadData()
        super.viewDidLoad()
        tbView.setIdentifier("BookCatCell")
        self.navigationView.set(style: .back, title: "Chọn Danh Mục") {
            self.pop()
        }
    }
    
    func categorySelected()->[BookCategory]
    {
        return categoris.filter{$0.selected == true}

    }

    @IBOutlet weak var tbView: UITableView!
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func touchIn(_ sender: Any)
    {
        delegate.bookCategoryDidSelect(categorySelected())
        self.pop()

    }
    

}
