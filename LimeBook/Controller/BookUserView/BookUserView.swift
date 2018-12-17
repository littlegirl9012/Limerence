//
//  BookUserView.swift
//  LimeBook
//
//  Created by Lê Dũng on 11/18/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

class BookUserView: GreenView,  UITableViewDelegate,UITableViewDataSource {
    
    var book : [Book] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return book.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbView.dequeueReusableCell(withIdentifier: "BookUserViewCell") as! BookUserViewCell
        cell.set(book: self.book[indexPath.row])
        return cell
    }
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBOutlet weak var lbTitle: UILabel!
    
    override func initStyle() {
        tbView.setIdentifier("BookUserViewCell")
        tbView.delegate = self;
        tbView.dataSource = self;
        view.backgroundColor = UIColor.white
        drawRadius(4)
        tbView.backgroundColor = UIColor.white
    }
    
    @IBAction func closeTouch(_ sender: Any)
    {
        superview!.hideAlertBox()
    }
    
    @IBOutlet weak var tbView: UITableView!
    
    func loadData(_ user : User)
    {
        
        weak var weakself = self;
        lbTitle.text = "Tủ Sách Của \(user.aliasname)"
        let request = BookUser_Request()
        request.user_id = user.id
        request.last_id = 0
        services.bookUser(request, success: { (response) in
            weakself?.book.append(contentsOf: response)
            weakself?.tbView.reloadData()
        }) { (error) in
            
        }
    }

}
