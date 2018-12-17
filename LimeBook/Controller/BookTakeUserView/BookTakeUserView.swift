//
//  BookTakeUserView.swift
//  LimeBook
//
//  Created by Lê Dũng on 11/10/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

protocol BookTakeUserViewDelegate : class
{
    func bookTakeDidSelectUser( _ user : User)
}


class BookTakeUserView: GreenView, UITableViewDelegate, UITableViewDataSource
{
    
    @IBOutlet weak var lbTitle: UILabel!
    weak var delegate : BookTakeUserViewDelegate?
    
    var user : [User] = []
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tbView.dequeueReusableCell(withIdentifier: "UserCell") as! UserCell
        cell.set(self.user[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(self.user[indexPath.row].id == userInstance.user.id)
        {
            return;
        }
        delegate?.bookTakeDidSelectUser(self.user[indexPath.row])
    }
    

    @IBOutlet weak var tbView: UITableView!
    override func initStyle() {
        tbView.delegate = self;
        tbView.dataSource = self;
        tbView.setIdentifier("UserCell")
        drawRadius(4)
    }

    
    func loadData(_ book : Book)
    {
        let request = BookUserList_Request()
        lbTitle.text = "Thành viên sở hữu sách".capitalized
        request.book_id = book.id
        weak var weakself = self;
        services.bookUserList(request, success: { (response) in
            weakself?.user.append(contentsOf: response)
            weakself?.tbView.reloadData()
        }) { (error) in
        }
    }
    @IBAction func closeTouch(_ sender: Any) {
        superview!.hideAlertBox()
    }
}
