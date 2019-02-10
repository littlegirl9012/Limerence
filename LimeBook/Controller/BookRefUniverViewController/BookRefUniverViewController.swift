//
//  BookRefUniverViewController.swift
//  MiBook
//
//  Created by Lê Dũng on 2/3/19.
//  Copyright © 2019 limerence. All rights reserved.
//

import UIKit

class BookRefUniverViewController: MasterViewController, UITableViewDelegate, UITableViewDataSource, UniversityViewControllerDelegate ,BookRefUniverCellDelegate{

    
    var dataList : [Book] = []
    
    @IBOutlet weak var btTop: UIButton!
    @IBOutlet weak var topView: UIView!
    var univerSelected  : University!
    @IBOutlet weak var tbView: UITableView!


    override func viewDidLoad() {
        super.viewDidLoad()

        btTop.setTitle("Chọn Trường", for: .normal)
        btTop.setTitleColor(.white, for: .normal)
        topView.backgroundColor = template.primaryColor
        
        if(userInstance.user.university_id != -1)
        {
            univerSelected = University()
            univerSelected.id = userInstance.user.university_id
            univerSelected.name = userInstance.user.university_name
            updateUniver()
        }
        
        
        
        weak var weakself = self;
        navigationView.set(style: .back, title: "Chia Sẻ Sách Cùng Trường") {
            weakself?.pop()
        }
        
        tbView.setIdentifier("BookRefUniverCell")
        
        tbView.backgroundColor = template.backgroundColor

    }

    @IBAction func touchIn(_ sender: Any) {
        
        let univer = UniversityViewController()
        univer.delegate = self;
        push(univer)
    }
    
    func loadData()
    {
        let request = BookUniversity_Request()
        request.university_id = univerSelected.id
        
        weak var weakself  = self;
        dataList.removeAll()
        tbView.reloadData()
        services.bookUniversity(request, success: { (response) in
            weakself?.dataList.append(contentsOf: response)
            weakself?.tbView.reloadData()
        }) { (error) in
            
        }

    }
    
    func UniversityViewControllerDidSelect(_ university: University) {
        
        self.univerSelected  = university
        updateUniver()
    }
    
    func updateUniver()
    {
        btTop.setTitle(univerSelected.name, for: .normal)
        loadData()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tbView.dequeueReusableCell(withIdentifier: "BookRefUniverCell") as! BookRefUniverCell
        cell.set(self.dataList[indexPath.row])
        cell.delegate = self;
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }

    
    func BookRefUniverCellTouchUser(_ book: Book) {
        if(book.user_id != userInstance.user.id)
        {
            let chat = ChatViewController()
            chat.target =  User()
            chat.target.aliasname = book.aliasname
            chat.target.id = book.user_id
            push(chat)
        }
    }
}
