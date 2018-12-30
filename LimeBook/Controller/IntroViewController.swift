//
//  IntroViewController.swift
//  MiBook
//
//  Created by Lê Dũng on 12/28/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        getAppInfo()
    }


    
    func getAppInfo()
    {
        weak var weakself = self;
        services.applicationInfo(success: { (response) in
            if(response.count > 0)
            {
                apppInstance.updateInfo(response)
                weakself?.processData()
            }
        }) { (error) in
            
        }
    }
    
    func processData()
    {
        if(!apppInstance.isMatchVersion())
        {
            
        }
        if(apppInstance.is_maintenance)
        {
            app.maintenance()
        }
        else
        {
            app.login()
        }
    }

    
}
