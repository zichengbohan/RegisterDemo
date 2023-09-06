//
//  ViewController.swift
//  registerDemo
//
//  Created by xbm on 2023/9/6.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Home"
        view.backgroundColor = .white;
        
        let goRegisterBt = UIButton(type: .system);
        goRegisterBt.setTitle("Go Register", for: .normal);
        goRegisterBt.translatesAutoresizingMaskIntoConstraints = false // 确保可以使用自动布局
        goRegisterBt.addTarget(self, action: #selector(goRegisterClicked), for: .touchUpInside)
        view.addSubview(goRegisterBt);
        
        // 创建约束
        let centerXConstraint = NSLayoutConstraint(
            item: goRegisterBt,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: view,
            attribute: .centerX,
            multiplier: 1.0, // 控制按钮水平居中
            constant: 0.0 // 控制按钮在中心的偏移
        );
        let centerYConstraint = NSLayoutConstraint(
            item: goRegisterBt,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: view,
            attribute: .centerY,
            multiplier: 1.0, // 控制按钮垂直居中
            constant: 0.0 // 控制按钮在中心的偏移
        );
        
        let widthConstraint = NSLayoutConstraint(
            item: goRegisterBt,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1.0,
            constant: 100.0 // 设置按钮的宽度
        );
        
        let heightConstraint = NSLayoutConstraint(
            item: goRegisterBt,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1.0,
            constant: 40.0 // 设置按钮的高度
        );
        
        NSLayoutConstraint.activate([centerXConstraint, centerYConstraint, widthConstraint, heightConstraint])

        
    }
    
    @objc func goRegisterClicked() {
        let registerVC = RegisterVC();
        navigationController?.pushViewController(registerVC, animated: true);
    }


}

