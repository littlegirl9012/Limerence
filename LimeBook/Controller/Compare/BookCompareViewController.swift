//
//  BookCompareViewController.swift
//  MiBook
//
//  Created by Lê Dũng on 2/14/19.
//  Copyright © 2019 limerence. All rights reserved.
//

import UIKit

class BookCompareViewController: MasterViewController, UITableViewDelegate, UITableViewDataSource
{
    

    var data : [Book] = []
    var book : Book!
    @IBOutlet weak var tbVIew: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tbVIew.setIdentifier("BookCompareCell")
        
        
        tbVIew.backgroundColor = template.backgroundColor
        weak var weakself = self;
        navigationView.set(style: .back, title: "So Sánh Giá Bán") {
            weakself?.pop()
        }
        loadData()
    }

    func loadData()
    {
        let request = BookStoreSearch_Request()
        request.title = book.title
        request.keyword = book.keyword

        request.author = book.author
        weak var weakself = self
        data.append(self.book)
        services.bookStoreSearch(request, success: { (response) in
            weakself?.data.append(contentsOf: response)
            
            weakself?.tbVIew.reloadData()
        }) { (error) in
            
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbVIew.dequeueReusableCell(withIdentifier: "BookCompareCell") as! BookCompareCell
        cell.set(data[indexPath.row])
        return cell

    }

}
