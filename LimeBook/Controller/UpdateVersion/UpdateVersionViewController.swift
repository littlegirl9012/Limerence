//
//  UpdateVersionViewController.swift
//  LimeBook
//
//  Created by Lê Dũng on 9/11/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

class UpdateVersionViewController: MasterViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func versionTouch(_ sender: Any)
    {
        UIApplication.shared.openURL(NSURL(string:userInstance.appInfo.appstore_link)! as URL)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    


}
