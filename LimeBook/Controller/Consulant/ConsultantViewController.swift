//
//  ConsultantViewController.swift
//  LimeBook
//
//  Created by Lê Dũng on 8/23/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

class ConsultantViewController: MasterViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tbView: UITableView!
    
    var consultants :  [User] = []
    override func viewDidLoad()
    {
        super.viewDidLoad()
        

        tbView.setIdentifier("UserCell")
    }

    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    
    func loadData()
    {
        
        let request = UserConsultant_Request()
        request.consultant_id = 1
        
        services.userConsultant(request, success: { (response) in
            self.consultants.removeAll()
            self.consultants.append(contentsOf: response)
            self.tbView.reloadData()
        }) { (response) in
            
        }
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tbView.dequeueReusableCell(withIdentifier: "UserCell") as! UserCell
        cell.set(consultants[indexPath.row])
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chat = ChatViewController()
        chat.target = consultants[indexPath.row]
        self.push(chat)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return consultants.count
    }

    
    
    
}
