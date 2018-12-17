//
//  ContactSelectViewController.swift
//  LimeBook
//
//  Created by Lê Dũng on 8/21/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit


protocol ContactSelectDelegate {
    func contactSelect(_ user : User)
}

class ContactSelectViewController: MasterViewController, UITableViewDelegate, UITableViewDataSource {
    
    var delegate : ContactSelectDelegate!
    
    var contacts : [User] = []
    
    
    
    @IBOutlet weak var tbView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        navigationView.set(style: .back, title: "") {
            self.pop()
        }
        
        tbView.setIdentifier("ContactSelectCell")
        
        navigationView.set(style: .back, title: "Chọn Người Mượn") {
            self.pop()
        }
        
        loadData()
        
    }
    
    func loadData()
    {
        services.userContacts(success: { (response) in
            self.contacts.append(contentsOf: response)
            self.tbView.reloadData()
        }) { (error) in
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pop()
        delegate.contactSelect(self.contacts[indexPath.row])

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbView.dequeueReusableCell(withIdentifier: "ContactSelectCell") as! ContactSelectCell
        cell.set(self.contacts[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contacts.count
    }
    
    

}
