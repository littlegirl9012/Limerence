//
//  BookInfoDetailCell.swift
//  LimeBook
//
//  Created by Lê Dũng on 10/14/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

protocol BookInfoDetailCellDelegate : class{
    func bookInfoDetailCellRequestUploadCell()
    func bookInfoDetailCellUserTouch(_ book : Book)

    
}

class BookInfoDetailCell: UITableViewCell {

    
    weak var delegate : BookInfoDetailCellDelegate?
    @IBOutlet weak var imgView: UIImageView!
    
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var imgGroupContainView: UIView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbContent: UILabel!
    @IBOutlet weak var userImageView: UserImageView!
    var isAdd = false;
    @IBOutlet weak var extentView: UIView!
    
    var imageGroup : ImageGroupView!
    var detailView: BookInfoView = BookInfoView()
    var book : Book!
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = template.backgroundColor
        if(mainView != nil)
        {
        }
    }

    @IBOutlet weak var lbAuthor: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(_ book : Book)
    {
        self.book = book
        if(book.book_type_n == .library)
        {
            library()
        }
        else
        {
            others()
        }
    }
    
    func library()
    {
        lbTitle.attributedText = self.book.atributeTitle
        lbAuthor.text = self.book.author
        let url = URL.init(string: self.book.image)
        if(url != nil)
        {
            imgView.af_setImage(withURL: url!)
        }
        else
        {
            imgView.image = nil
        }
    }
    
    func others ()
    {
        lbName.text = self.book.aliasname
        lbTitle.attributedText = self.book.atributeTitle
        lbContent.attributedText = self.book.attibuteConent
        userImageView.set("", url: self.book.avatar)
        
        
        imgGroupContainView.removeSubsView()
        
        if(book.images.count == 0)
        {
            imageGroup = nil
        }
        else if (book.images.count == 1)
        {
            imageGroup = ImageGroup1()
        }
        else if (book.images.count == 2)
        {
            imageGroup = ImageGroup2()

        }
        else if (book.images.count == 3)
        {
            imageGroup = ImageGroup3()

        }
        else if (book.images.count == 4)
        {
            imageGroup = ImageGroup4()
        }
        
        if(imageGroup != nil)
        {
            imageGroup.setMedia(self.book.media_model)
            self.imgGroupContainView.addSubview(imageGroup)
            self.imgGroupContainView.setLayout(imageGroup)
        }
        
    }
    
    @IBAction func detailTouch(_ sender: Any) {
        isAdd = !isAdd
        
        
        if(isAdd)
        {
            self.extentView.addSubview(self.detailView)
            self.extentView.setLayout(self.detailView)
            detailView.set(self.book)
        }
        else
        {
            self.extentView.removeSubsView()
        }
        delegate?.bookInfoDetailCellRequestUploadCell()
        
    }
    
    
    @IBAction func userTouch(_ sender: Any) {
        delegate?.bookInfoDetailCellUserTouch(self.book)
    }

    
}
