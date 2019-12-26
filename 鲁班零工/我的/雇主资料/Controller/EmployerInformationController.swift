//
//  EmployerInformationController.swift
//  鲁班零工
//
//  Created by 张昊 on 2019/11/15.
//  Copyright © 2019 张兴栋. All rights reserved.
//

import UIKit

class EmployerInformationModel: NSObject {
    var phone: String?
    var name: String?
    var id: String?
    var empType: String?
    var card :String?
    var naem: String?
    var cardImageb: String?
    var cardImagez: String?
    var businessLicense: String?
    
    init(dict:[String: Any]) {
        super.init()
        phone = dict["phone"] as? String
        name = dict["name"] as? String
        id = dict["id"] as? String
        empType = dict["empType"] as? String
        card = dict["card"] as? String
        naem = dict["naem"] as? String
        cardImageb = dict["cardImageb"] as? String
        cardImagez = dict["cardImagez"] as? String
        businessLicense = dict["businessLicense"] as? String
    }
}

class EmployerInformationController: ZXDBaseViewController,UITextFieldDelegate {
    
    lazy var middleView:UIView = {
        let view = UIView(frame: AutoFrame(x: 0, y: 201.5, width: 375, height: 5))
        view.backgroundColor = UIColor.init(rgb: 0xf0f0f0)
        return view
    }()
    
    var imageView1:UIImageView!
    var imageView2:UIImageView!
    var imageView3:UIImageView!
    
    var textField1:UITextField!
    var textField2:UITextField!
    var textField3:UITextField!
    var textField:UITextField!
    
    var infoModel:EmployerInformationModel!
    
    var textFiledArray:NSMutableArray!
     func reloadUI() {
        textField1.text = infoModel.empType
        textField2.text = infoModel.naem
        textField3.text = infoModel.card
        textField.text = infoModel.phone
        let str:String = infoModel.cardImagez ?? ""
        let str2:String = infoModel.cardImageb ?? ""
        let str3:String = infoModel.businessLicense ?? ""
        imageView1.sd_setImage(with: URL.init(string:rootUrl.appending(str))) { (image, error, types, urls) in
            
        }
        imageView2.sd_setImage(with: URL.init(string:rootUrl.appending(str2))) { (image, error, types, urls) in
            
        }
        imageView3.sd_setImage(with: URL.init(string:rootUrl.appending(str3))) { (image, error, types, urls) in
                   
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
         title = "雇主资料"
        weak var weakSelf = self
        ZXD_NetWorking.post(withUrl: rootUrl.appending("/updateMemberNews/login/Emp"), params: ["userId":UserDefaults.standard.object(forKey: "userId") ?? ""], success: { (response ) in
            let dictResps:[String:Any] = response as! [String : Any]
            let code:String = dictResps["code"] as! String
            if (code == "0") {
                weakSelf?.infoModel = EmployerInformationModel(dict: dictResps["data"] as! [String : Any])
                weakSelf?.reloadUI()
            }
        }, fail: { (eorr) in
            
        }, showHUD: true)
        view.addSubview(middleView)
        textFiledArray = NSMutableArray.init()
        
        let titlearray = ["雇主类型","真实姓名","身份证号","手机号码"]
        let spaceArray = ["17.5","68.5","119","170"]
        let spaceArray2 = ["50","100.5","151","170"]
        for i in 0..<4 {
            let stri:NSString = spaceArray[i] as NSString
            let stri2:NSString = spaceArray2[i] as NSString
            lefLabelInSuperView(superView: view, space:CGFloat(stri.floatValue), title: titlearray[i])
            if (i < 3) {
                lineViewInSuperView(superView: view, space: CGFloat(stri2.floatValue))
            }
        }
        
        textField1 = rightTextFieldInSuperView(superView: view, space: 17.5, title: "请输入雇主类型")
        textField2 = rightTextFieldInSuperView(superView: view, space: 68.5, title: "请输入真实姓名")
        textField3 = rightTextFieldInSuperView(superView: view, space: (68.5+50.5), title: "请输入身份证号")
        
        textField = rightTextFieldInSuperView(superView: view, space: (68.5+50.5*2), title: "请输入手机号码")
        var frame:CGRect = textField.frame
        frame.origin.x = frame.origin.x - 15
        textField.frame = frame;
        textField.text = "13040****67"
       
        let button:UIButton = UIButton(frame: AutoFrame(x: 200, y: 151, width: 175, height: 50))
        button.setImage(UIImage(named: "issue_arrows"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 130*ScalePpth, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(phoneButtonAction(button:)), for: .touchUpInside)
        view.addSubview(button)
        addBottomView()
    }
    
    @objc func phoneButtonAction(button:UIButton) {
      navigationController?.pushViewController(ChangePhoneController.init(), animated: true)
    }
    
    func lefLabelInSuperView(superView:UIView,space:CGFloat,title:String) {
        let label = UILabel(frame: AutoFrame(x: 15, y: space, width: 100, height: 15))
        label.textColor = .init(rgb: 0x333333)
        label.text = title;
        label.font = FontSize(height: 15)
        superView.addSubview(label)
    }
    
    func rightTextFieldInSuperView(superView:UIView,space:CGFloat,title:String) -> UITextField {
        let rightTextField = UITextField(frame: AutoFrame(x: 127, y: space, width: 230, height: 15))
        rightTextField.textColor = UIColor.init(rgb: 0x333333)
        rightTextField.delegate = self
        rightTextField.placeholder = title
        rightTextField.textAlignment = .right
        rightTextField.borderStyle = .none
        rightTextField.isEnabled = false
        superView.addSubview(rightTextField)
        textFiledArray.add(rightTextField)
        return rightTextField
    }
    
    func lineViewInSuperView(superView:UIView,space:CGFloat) {
        let line = UIView(frame: AutoFrame(x: 0, y: space, width: 375, height: 0.5))
        line.backgroundColor = UIColor(rgb: 0xeeeeee)
        superView.addSubview(line)
    }
    
    func addBottomView() {
        let bottomView = UIView(frame: AutoFrame(x: 0, y: 206.5, width: 375, height: 397))
        bottomView.backgroundColor = .init(rgb: 0xffffff)
        view.addSubview(bottomView)
        let label = UILabel(frame: AutoFrame(x: 15, y: 23.5, width: 120, height: 15))
        label.font = FontSize(height: 15)
        label.textColor = .init(rgb: 0x333333)
        label.text = "身份证照片"
        bottomView.addSubview(label)
        
        let label2 = UILabel(frame: AutoFrame(x: 15, y: 181.5, width: 120, height: 15))
        label2.font = FontSize(height: 15)
        label2.textColor = .init(rgb: 0x333333)
        label2.text = "营业执照"
        bottomView.addSubview(label2)
        
        let line = UIView(frame: AutoFrame(x: 0, y: 165, width: 375, height: 0.5))
        line.backgroundColor = UIColor(rgb: 0xeeeeee)
        bottomView.addSubview(line)
        
        imageView1 = UIImageView(frame: AutoFrame(x: 35, y: 65.5, width: 125, height: 80))
        imageView1.backgroundColor = .init(rgb: 0xcccccc)
        bottomView.addSubview(imageView1)
        
        imageView2 = UIImageView(frame: AutoFrame(x: 200, y: 65.5, width: 125, height: 80))
        imageView2.backgroundColor = .init(rgb: 0xcccccc)
        bottomView.addSubview(imageView2)
        
        imageView3 = UIImageView(frame: AutoFrame(x: 35, y: 223, width: 125, height: 80))
        imageView3.backgroundColor = .init(rgb: 0xcccccc)
        bottomView.addSubview(imageView3)
        
//        let submitButton = UIButton(frame: AutoFrame(x: 37.5, y: 331.5, width: 300, height: 45))
//        submitButton.backgroundColor = .init(rgb: 0xFFD301)
//        submitButton.layer.masksToBounds = true
//        submitButton.layer.cornerRadius = 22.5*ScalePpth
//        submitButton.titleLabel?.font = FontSize(height: 17)
//        submitButton.setTitle("提交", for: .normal)
//        submitButton.setTitleColor(.init(rgb: 0x333333), for: .normal)
//        bottomView.addSubview(submitButton)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for i in 0..<4 {
            let textField:UITextField = textFiledArray![i] as! UITextField
            textField.endEditing(true)
        }
    }
}
