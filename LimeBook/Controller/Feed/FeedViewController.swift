//
//  FeedViewController.swift
//  LimeBook
//
//  Created by Lê Dũng on 8/29/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

class FeedViewController: MasterViewController, UITableViewDelegate, UITableViewDataSource {
    
    var books :[Book] = []
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbView.dequeueReusableCell(withIdentifier: "FeedBookCell") as! FeedCell
        cell.set(self.books[indexPath.row])
        return cell
    }
    
    func loadData()
    {
        let request = BookUser_Request()
        request.user_id = userInstance.user.id
        
        services.bookUserAll(request, success: { (response) in
            self.books.removeAll()
            self.books.append(contentsOf: response)
            self.tbView.reloadData()
        }) { (error) in
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail = NewsDetailViewController()
        detail.book = self.books[indexPath.row]
        push(detail)
    }
    

    var user : User!
    @IBOutlet weak var tbView: UITableView!
    override func viewDidLoad() {

        let sf = UIView()
        sf.frame = CGRect.init(x: 12, y: 10, width: 2, height: 500)
        
        tbView.addSubview(sf)
        
        super.viewDidLoad()

        tbView.setIdentifier("FeedBookCell");
        loadData()
        view.backgroundColor = template.backgroundColor
        self.navigationView.set(style: .back, title: "Timeline") {
            self.pop()
        }
        
        tbView.bringSubview(toFront: sf)
        
    }

}
