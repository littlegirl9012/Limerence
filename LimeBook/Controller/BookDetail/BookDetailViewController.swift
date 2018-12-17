//
//  BookDetailViewController.swift
//  LimeBook
//
//  Created by Lê Dũng on 10/8/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

class BookDetailViewController: MasterViewController, UITableViewDelegate, UITableViewDataSource, BookInfoCellDelegate{
    func bookDidSelectRate(_ indexPath: IndexPath) {
        
    }
    
    
    

    @IBOutlet weak var tbView: UITableView!
    var book : Book!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.book.isDrawFelling = true
        self.book.isDrawExtenalComment = true ;
        self.tbView.reloadData()
        navigationView.set(style: .back, title: book.title) {
            
        
            self.pop()
        }
    }



    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tbView.dequeueReusableCell(withIdentifier:"BookInfoCell") as! BookInfoCell
        cell.set(self.book,indexPath)
        cell.delegate = self;
        return cell
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func bookInfoExten(_ indexPath: IndexPath) {
        
    }
    
    func bookInfoUpdate(_ indexPath: IndexPath) {
        
    }
    
    func commentViewRequestUserInterfaceFocusView(_ sender: Any?) {
        
    }
    func bookInfoReloadScrollToTop(_ indexPath: IndexPath) {
        
    }
    
    func bookInfoUpdateScrollToBot(_ indexPath: IndexPath) {
        
    }
    
    
    func bookInfoUpdateScrollToTop(_ indexPath: IndexPath) {
        
    }

}
