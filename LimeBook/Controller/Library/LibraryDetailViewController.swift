//
//  LibraryDetailViewController.swift
//  LimeBook
//
//  Created by Lê Dũng on 9/27/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

class LibraryDetailViewController: MasterViewController,UITableViewDelegate, UITableViewDataSource{

    
    var book : Book!
    var bookDetail : Book!

    @IBOutlet weak var tbView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tbView.setIdentifier("LibraryDetailCell")
        tbView.setIdentifier("LibraryCommentCell")
        // Do any additional setup after loading the view.
        
        
        weak var weakself = self
        self.navigationView.set(style: .back, title: "Thư Viện MiBook") {
            weakself?.pop()
        }
        
        tbView.backgroundColor = template.backgroundColor
    }
    
    
    func loadDetail()
    {
        let request = BookDetail_Request()
        request.book_id = self.book.id
        request.user_id = book.user_id;
        
        services.bookDetail(request, success: { (response) in
            self.bookDetail = response;
            
        }) { (response) in
            
        }
    }

    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if(indexPath.section == 0)
        {
            let cell = tbView.dequeueReusableCell(withIdentifier: "LibraryDetailCell") as! LibraryDetailCell
            cell.set(self.book)
            return cell;

        }
        else
        {
            let cell = tbView.dequeueReusableCell(withIdentifier: "LibraryCommentCell") as! LibraryCommentCell
            return cell;            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 2
    }
    
}
