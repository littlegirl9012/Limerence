//
//  BookTypeView.swift
//  LimeBook
//
//  Created by Lê Dũng on 9/7/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit



protocol BookTypeViewDelegate {
    func bookTypeDidSelect(_ bookType : BookType)
}





class BookTypeView: GreenView , RadioViewDelegate{
    
    var delegate : BookTypeViewDelegate!
    @IBOutlet weak var rDefault: RadioView!
    @IBOutlet weak var rSell: RadioView!
    var bookType : BookType! =  BookType.general
    
    func setBook(_ type : BookType)
    {
        self.bookType = type;
        disableAll()

        switch type {
        case .general:
            rDefault.check()
            break
        case .buy:
            break
        case .sell:
            rSell.check()
            break
        case .news:
            break
        case .lend:
            break
        case .present:
            break

        case .react:
            break

        case .question:
            break
        case .web:
            break

        case .library: break
            
        }
        
        
    }
    
    
    func disableAll()
    {
        rSell.uncheck()
        rDefault.uncheck()
    }
    
    
    override func initStyle() {
        
        rDefault.delegate = self;
        rSell.delegate = self;
        
        rDefault.set(true, "Mặc định")
        rSell.set(false, "Đăng Bán")

    }

    
    func radioChangeState(_ value: Bool, sender: RadioView) {
        
        disableAll()
        sender.check()
        
        
        if(sender == rDefault)
        {
            self.bookType =  BookType.general
        }
        if(sender == rSell)
        {
            self.bookType =  BookType.sell
        }

        delegate.bookTypeDidSelect(self.bookType)
        
    }
}
