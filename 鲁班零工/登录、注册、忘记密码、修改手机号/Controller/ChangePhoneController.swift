//
//  ChangePasswordController.swift
//  鲁班零工
//
//  Created by 张昊 on 2019/11/18.
//  Copyright © 2019 张兴栋. All rights reserved.
//

import UIKit

class ChangePhoneController: ZXDBaseViewController,UITextFieldDelegate {
    
    lazy var phoneTextField:UITextField = {
        let phoneTextField = UITextField(frame: AutoFrame(x: 50, y: 54, width: 180, height: 34))
        phoneTextField.placeholder = "请输入手机号码"
        phoneTextField.font = FontSize(height: 15)
        phoneTextField.textColor = UIColor.init(rgb: 0x333333);
        phoneTextField.borderStyle = .none
        phoneTextField.delegate = self
        phoneTextField.keyboardType = UIKeyboardType.numberPad
        phoneTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        let leftView = UIView(frame: AutoFrame(x: 0, y: 0, width: 28, height: 34))
        let imageView = UIImageView(frame: AutoFrame(x: 0, y: 8.5, width: 10, height: 30))
        imageView.image = UIImage(named: "register_phone")
        leftView.addSubview(imageView)
        phoneTextField.leftView = leftView
        phoneTextField.leftViewMode = UITextField.ViewMode.always
        imageView.sizeToFit()
        return phoneTextField
    }()
    
    lazy var verificationCodeField:UITextField = {
        let verificationCodeField = UITextField(frame: AutoFrame(x: 50, y: 114, width: 180, height: 34))
        verificationCodeField.placeholder = "请输入验证码"
        verificationCodeField.font = FontSize(height: 15)
        verificationCodeField.textColor = UIColor.init(rgb: 0x333333);
        verificationCodeField.borderStyle = .none
        verificationCodeField.delegate = self
        verificationCodeField.clearButtonMode = UITextField.ViewMode.whileEditing
        let leftView = UIView(frame: AutoFrame(x: 0, y: 0, width: 28, height: 34))
        let imageView = UIImageView(frame: AutoFrame(x: 0, y: 8.5, width: 28, height: 34))
        imageView.image = UIImage(named: "register_verification")
        imageView.sizeToFit()
        leftView.addSubview(imageView)
        verificationCodeField.leftView = leftView
        verificationCodeField.leftViewMode = UITextField.ViewMode.always
        return verificationCodeField
    }()
    
    lazy var getVerificationButton:UIButton = {
     let getVerificationButton =  UIButton(frame: AutoFrame(x: 247, y: 116, width: 90, height: 30))
         getVerificationButton.backgroundColor = UIColor(rgb: 0xFFD301)
         getVerificationButton.titleLabel?.font = FontSize(height: 13)
         getVerificationButton.setTitle("获取验证码", for: .normal)
         getVerificationButton.layer.cornerRadius = 15
         getVerificationButton.layer.masksToBounds = true
         getVerificationButton.setTitleColor(.init(rgb: 0x333333), for: .normal)
        getVerificationButton.addTarget(self, action: #selector(getVerificationButtonAction(button:)), for: .touchUpInside)
        return getVerificationButton
    }()

    lazy var submissionButton:UIButton = {
        let submissionButton =  UIButton(frame: AutoFrame(x: 37.5, y: 211, width: 300, height: 45))
        submissionButton.backgroundColor = UIColor(rgb: 0xFFD301)
        submissionButton.titleLabel?.font = FontSize(height: 17)
        submissionButton.setTitle("提交", for: .normal)
        submissionButton.layer.cornerRadius = 22.5
        submissionButton.layer.masksToBounds = true
        submissionButton.setTitleColor(.init(rgb: 0x333333), for: .normal)
        submissionButton.addTarget(self, action: #selector(submissionButtonButtonAction(button:)), for: .touchUpInside)
        return submissionButton
    }()
    
    @objc func getVerificationButtonAction(button:UIButton) {
        
    }
    
    @objc func submissionButtonButtonAction(button:UIButton) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "修改手机号码"
        view.addSubview(phoneTextField)
        view.addSubview(verificationCodeField)
        view.addSubview(submissionButton)
        view.addSubview(getVerificationButton)
        
        for i in 0...1 {
            let line = UIView(frame: AutoFrame(x: 38, y: CGFloat(100+i*60), width: 300, height: 0.5))
            line.backgroundColor = .init(rgb: 0xeeeeee)
            view.addSubview(line)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        verificationCodeField.endEditing(true)
        phoneTextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        verificationCodeField.endEditing(true)
        phoneTextField.endEditing(true)
        return true
    }
}
