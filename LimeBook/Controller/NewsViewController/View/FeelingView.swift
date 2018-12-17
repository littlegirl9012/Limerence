//
//  FeelingView.swift
//  LimeBook
//
//  Created by Lê Dũng on 10/3/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

class FeelingView: GreenView {
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    var firsFeeling : Feelling!
    @IBOutlet weak var fCell: FeelingCell!

    
    func setSequence(_ value : [Feelling])
    {
        if(value.count > 1)
        {
            clearSequence()
            for iten in value
            {
                    let cell = FeelingCell()
                    cell.set(iten)
                    stackView.addArrangedSubview(cell)
            }
        }
    }
    
    func clearSequence()
    {
        stackView.removeSubsView()
    }

    override func initStyle()
    {
    }
}
