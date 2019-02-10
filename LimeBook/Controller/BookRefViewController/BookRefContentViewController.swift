//
//  BookRefContentViewController.swift
//  MiBook
//
//  Created by Lê Dũng on 1/29/19.
//  Copyright © 2019 limerence. All rights reserved.
//

import SwipeableTabBarController
import UIKit

class BookRefContentViewController: MasterViewController {
    
    @IBOutlet weak var contentView: UIView!
    var tabbar : SwipeableTabBarController! = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        weak var weakself = self;
        navigationView.set(style: .back, title: "Sách Giao Khoa") {
            weakself?.pop()
        }
        tabbar = SwipeableTabBarController()

        addChildViewController(tabbar)
        
        let page0 = BookRefViewController()
        let page1 = BookRefUserViewController()
        
        tabbar.viewControllers = [page0,page1]
        
        contentView.addSubview(tabbar.view)
        contentView.setLayout(tabbar.view)
        tabbar.tabBar.isHidden = true
        tabbar.isSwipeEnabled = true
        navigationView.bringSubview(toFront: btAdd)
        
        if(device.isRStatusBar())
        {
            bottomSwitch.constant = 28
        }

    }
    @IBOutlet weak var btAdd: UIButton!
    
    @IBOutlet weak var bottomSwitch: NSLayoutConstraint!
    @IBAction func addTouch(_ sender: Any)
    {
        push(BookRefCreateViewController())
    }
    
    @IBAction func switchTouch(_ sender: Any)
    {
        if(tabbar.selectedIndex == 0)
        {
            tabbar.selectedIndex = 1
        }
        else
        {
            tabbar.selectedIndex = 0
        }
    }
}
