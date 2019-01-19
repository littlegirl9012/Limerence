//
//  DrawViewController.swift
//  MiBook
//
//  Created by Lê Dũng on 1/8/19.
//  Copyright © 2019 limerence. All rights reserved.
//

import UIKit

class DrawViewController: MasterViewController, UITableViewDelegate, UITableViewDataSource {

    var rootNode : MKNode!
    @IBOutlet weak var tbView: UITableView!
    @IBOutlet weak var demoView: UIView!
    
    var headerCell = DrawCell.init(header: true)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tbView.register(DrawCell.self, forCellReuseIdentifier: "Cell")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbView.dequeueReusableCell(withIdentifier: "Cell") as! DrawCell
        cell.setObject()
        cell.setReference(headerCell)
        return cell
    }
    
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        headerCell.updateHeader()
        return headerCell
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
}
