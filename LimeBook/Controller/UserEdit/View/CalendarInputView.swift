//
//  CalendarInputView.swift
//  Mobile_68
//
//  Created by Lê Dũng on 7/7/18.
//  Copyright © 2018 Ledung. All rights reserved.
//

import UIKit
protocol CaIVDelegate
{
    func caivDidSelece(_ date : Date)
    
}

class CalendarInputView: GreenView {
    
    @IBOutlet weak var shadowView: UIView!
    var delegate : CaIVDelegate!

    @IBOutlet weak var datePickerView: UIDatePicker!
    

    override func initStyle() {
       // shadowView.dropShadow()
    }


    
    @IBAction func selectTouch(_ sender: Any)
    {
        delegate.caivDidSelece(datePickerView.date)
    }
    
}
