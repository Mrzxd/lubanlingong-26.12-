//
//  SharingAwardsController.swift
//  鲁班零工
//
//  Created by 张昊 on 2019/11/15.
//  Copyright © 2019 张兴栋. All rights reserved.
//

import UIKit

class SharingAwardsController: ZXDBaseViewController {
    var bottomView:UIView!
    lazy var backGroundImageView:UIImageView = {
        let imageView = UIImageView(frame: view.bounds)
            imageView.image = UIImage(named: "share_bg")
        return imageView
    }()
    
    lazy var backButton:UIButton = {
       let button = UIButton(frame: AutoFrame(x: 0, y: 17, width: 40, height: 40))
           button.setImage(UIImage(named: "de_lefttop"), for: .normal)
        button.addTarget(self, action: #selector(leftButtonAction(button:)), for:UIControl.Event.touchUpInside)
        return button
    }()
    
    lazy var immediateleyButon:UIButton = {
       let button = UIButton(frame: AutoFrame(x: 67.5, y: 567, width: 240, height: 57))
           button.setImage((UIImage(named: "share_btn")), for: .normal)
           button.layer.cornerRadius = 28.5*ScalePpth
           button.layer.masksToBounds = true
           button.tag = 100;
           button.addTarget(self, action: #selector(cancleButtonAction(button:)), for: .touchUpInside)
        return button
    }()
    
    lazy var ruleButton:UIButton = {
        let button = UIButton(frame: AutoFrame(x: 285, y: 50, width: 103, height: 26))
        button.backgroundColor = UIColor.init(rgb: 0xFFAA26)
        button.setTitle("分享规则", for: .normal)
        button.titleLabel?.font = FontSize(height: 14)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 13*ScalePpth
        button.layer.masksToBounds = true
       return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(backGroundImageView)
        view.addSubview(backButton)
        view.addSubview(ruleButton)
        view.addSubview(immediateleyButon)
        sharedTo()
    }
    
    func sharedTo() {
        bottomView = UIView(frame: AutoFrame(x: 0, y: kScreenHeight/ScalePpth, width: 375, height: 185))
        bottomView.backgroundColor = .white
        bottomView.layer.cornerRadius = 5*ScalePpth
        bottomView.layer.masksToBounds = true
        view.addSubview(bottomView)
        let nameLabel = UILabel(frame: AutoFrame(x: 15, y: 19, width: 100, height: 12))
        nameLabel.textColor = .init(rgb: 0x333333)
        nameLabel.font = FontSize(height: 12)
        nameLabel.text = "分享到"
        bottomView.addSubview(nameLabel)
        
        let imageArray = ["share_wechat","share_moments","share_qq","share_space"]
        let titleArray = ["微信好友","微信朋友圈","QQ好友","QQ空间"]
        for i in 0..<4 {
            let button = UIButton(frame: AutoFrame(x: CGFloat(375.0/4 * CGFloat(i)), y: 55, width: 375.0/4, height: 40))
            button.layer.cornerRadius  = 20*ScalePpth
            button.layer.masksToBounds = true
            button.setImage(UIImage(named: imageArray[i]), for: .normal)
            bottomView.addSubview(button)
            
            let label = UILabel(frame: AutoFrame(x: CGFloat(375.0/4 * CGFloat(i)), y: 108, width: 375.0/4, height: 10))
            label.textColor = .init(rgb: 0x333333)
            label.font = FontSize(height: 10)
            label.text = titleArray[i]
            label.textAlignment = .center
            bottomView.addSubview(label)
        }
        
        let lineView = UIView(frame: AutoFrame(x: 0, y: 139, width: 375, height: 0.5))
        lineView.backgroundColor = .init(rgb: 0xEEEEEE)
        bottomView.addSubview(lineView)
      
        let cancleButton = UIButton(frame: AutoFrame(x: 100, y: 139.5, width: 175, height: 40))
        cancleButton.setTitle("取消", for: .normal)
        cancleButton.titleLabel?.font = FontSize(height: 13)
        cancleButton.setTitleColor(.init(rgb: 0x999999), for: .normal)
        cancleButton.addTarget(self, action: #selector(cancleButtonAction(button:)), for: .touchUpInside)
        bottomView.addSubview(cancleButton)
    }
    
    @objc func leftButtonAction(button:UIButton) {
       self.dismiss(animated: true, completion: nil)
    }
    
    @objc func cancleButtonAction(button:UIButton) {
        weak var weakSelf = self
        if button.tag == 100 {
            UIView.animate(withDuration: 0.4) {
                weakSelf!.bottomView.frame = AutoFrame(x: 0, y: 487, width: 375, height: 185)
            }
        } else {
            UIView.animate(withDuration: 0.4) {
                weakSelf!.bottomView.frame = AutoFrame(x: 0, y: kScreenHeight/ScalePpth, width: 375, height: 185)
            }
        }
    }
}
