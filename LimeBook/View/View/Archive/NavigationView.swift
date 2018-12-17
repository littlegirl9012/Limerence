//
//  NavigationView.swift
//  MiBook
//
//  Created by Lê Dũng on 7/10/17.
//  Copyright © 2017 Ledung. All rights reserved.
//

import UIKit



enum NavigationStyle : String
{
    case menu = "GMenu"
    case back = "GBack"
    case none = ""
}


protocol NavigationViewDelegate {
    func navigationViewDidSearch(_ searchText : String)
    func navigationViewSearching(_ searchText : String)
}




class NavigationView: GreenView , UITextFieldDelegate{
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var searchView: UIView!
    
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var tfSearcg: UITextField!
    @IBOutlet weak var btSearch: GreenButtonCenter!
    @IBOutlet weak var wSearch: NSLayoutConstraint!
    @IBOutlet weak var lbTitle: UILabel!
    var delegate : NavigationViewDelegate!
    var completion : (()->Void)!

    override func initStyle()
    {
        statusView.backgroundColor = template.primaryColor
        contentView.backgroundColor = template.primaryColor
        statusView.backgroundColor = "44424A".hexColor()
        contentView.backgroundColor = "44424A".hexColor()

        lbTitle.textColor = .white;
        
        weak var weakself = self;

    }
    @IBAction func leftTouch(_ sender: Any)
    {
        self.completion()
    }
    
    func set(style : NavigationStyle, title : String, completion : @escaping (()->Void))
    {
        
        switch style {
        case .back: break
        case .menu:  break
        case .none: leftButton.isHidden = true; break;

        }
        lbTitle.text = title
        self.completion = completion
    }
    
    func enableSearch (_ isEnable : Bool)
    {
        if(isEnable)
        {
            wSearch.constant = 44
        }
        else
        {
            wSearch.constant = 0
        }
        
        searchView.isHidden = !isEnable
    }
    
    func setSearchPlaholder( _ text : String)
    {
        tfSearcg.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
    }
    
    @IBAction func editingChange(_ sender: Any)
    {
        self.delegate.navigationViewSearching(tfSearcg.text!)

    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        self.delegate.navigationViewDidSearch(tfSearcg.text!)
        return true
    }

    func setTitle(_ value : String)
    {
        lbTitle.text = value
    }
    func dissmissSearch()
    {
        tfSearcg.resignFirstResponder()
    }
    
}
