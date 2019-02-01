//
//  BookRefNoteCell.swift
//  MiBook
//
//  Created by Lê Dũng on 1/25/19.
//  Copyright © 2019 limerence. All rights reserved.
//

import UIKit

protocol BookRefNoteCellDelegate : class{

    func BookRefNoteCellChangePrice(_ value : String)
    func BookRefNoteCellChangeNote(_ value : String)
}

class BookRefNoteCell: UITableViewCell{
    
    weak var delegate : BookRefNoteCellDelegate?
    
    
    @IBOutlet weak var noteHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        noteHeight.constant = 0
        contentView.backgroundColor = template.backgroundColor
    }

    @IBOutlet weak var tfPrice: UITextField!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBOutlet weak var tfNote: UITextField!
    
    func set(_ ref : RefType)
    {
        if(ref == .gift)
        {
            noteHeight.constant = 0
        }
        else
        {
            noteHeight.constant = 48
        }
    }
    
    @IBAction func priceChange(_ sender: Any) {
        delegate?.BookRefNoteCellChangePrice(tfPrice.text!)
    }
    
    @IBAction func noteChange(_ sender: Any) {
        delegate?.BookRefNoteCellChangeNote(tfNote.text!)
    }
    
}
