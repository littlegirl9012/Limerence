//
//  UserEditViewController.swift
//  LimeBook
//
//  Created by Lê Dũng on 9/17/18.
//  Copyright © 2018 limerence. All rights reserved.
//

import UIKit

class UserEditViewController: MasterViewController, UniversityViewControllerDelegate, CaIVDelegate, GIVDelegate {

    @IBOutlet weak var headerInfo: MasterHeaderView!
    @IBOutlet weak var passwordConfirm: EditSingleLineView!
    @IBOutlet weak var infoView: GCleanView!
    
    @IBOutlet weak var securityView: GCleanView!
    @IBOutlet weak var headerPassword: MasterHeaderView!
    @IBOutlet weak var password: EditSingleLineView!
    
    @IBOutlet weak var name: EditSingleLineView!
    @IBOutlet weak var phone: EditSingleLineView!
    @IBOutlet weak var gender: EditSingleLineView!
    @IBOutlet weak var dob: EditSingleLineView!
    @IBOutlet weak var univerField: EditSingleLineView!
    var univerSelected  : University!
    @IBOutlet weak var univerHeaderView: MasterHeaderView!
    
    @IBOutlet weak var univerVIew: UIView!
    var dateSelect : Date!
    var genderSelect : Int! ;
    let genderInput  = GenderInputView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 160))
    let calendarInput  = CalendarInputView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 216))

    @IBAction func updateTouch(_ sender: Any) {
        
        let error = getError()
        if(error != nil)
        {
            view.warning(title: "Lỗi", desc: error!)
            return
        }
        
        
        
        
        let request  = UserUpdateInfo_Request()
        request.user_id = userInstance.user.id
        request.aliasname = (name.tfContent.text?.trim())!
        request.gender = genderSelect
        request.dob =  dateSelect.stringValue()
        request.phone = (phone.tfContent.text?.trim())!
        if(univerSelected != nil)
        {
            request.university_id = univerSelected.id
        }

        view.showHud()
        services.userUpdateInfo(request: request, success: { (response) in
            self.view.hideHub()
            self.view.info(title: "Thông báo", desc: "Thay đổi thông tin thành công")
            
            userInstance.updateUser(response[0])

        }) { (errror) in
            self.view.hideHub()
        }
        
    }
    
    func getError () ->String?
    {
        if(name.isEmpty())
        {
            return "Vui lòng nhập tên"
        }
        
        if(phone.isEmpty())
        {
            return "Vui lòng nhập số điện thoại"
        }

        if(gender.isEmpty())
        {
            return "Vui lòng nhập giới tính"
        }

        if(dob.isEmpty())
        {
            return "Vui lòng nhập ngày sinh"
        }

        return nil
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        self.genderSelect = userInstance.user.gender
        dateSelect = userInstance.user.dob.vnDate()

        infoView.drawRadius(4)
        
        univerVIew.drawRadius(4)
        univerHeaderView.set("Trường học")

        view.backgroundColor = template.backgroundColor
        headerInfo.set("Thông tin người dùng")
        self.navigationView.set(style: .back, title: "Thay Đổi Thông Tin Cá Nhân") {
            self.pop()
        }
        
        name.set("Tên", userInstance.user.aliasname)
        phone.set("Điện thoại", userInstance.user.phone)
        gender.set("Giới tính", userInstance.user.genderDisplay())
        dob.set("Ngày sinh", userInstance.user.dob)
        
        univerField.set("Trường Học", "")

        dob.hidenLine()
        
        dob.setInput(calendarInput)
        gender.setInput(genderInput)
        calendarInput.delegate = self;
        genderInput.delegate = self;
    
        weak var weakself = self;
        univerField.setTouch {
            let university = UniversityViewController()
            university.delegate = self;
            weakself?.push(university)
        }
        
    }
    
    func UniversityViewControllerDidSelect(_ university: University) {
        univerField.set("Trường Học", university.name)

    }
    
    func givDidSelect(_ genderValue: Int) {
        self.genderSelect = genderValue
        if(genderValue == 0)
        {
            gender.setContent("Nam")
        }
        else
        {
            gender.setContent("Nữ")
        }
        gender.dismiss()
    }
    func caivDidSelece(_ date: Date) {
        self.dateSelect = date;
        dob.dismiss()
        dob.setContent(date.stringValue())
    }
}
