//
//  BaseViewController.swift
//  SwiftPad-test
//
//  Created by Sansi Mac on 2018/6/20.
//  Copyright © 2018年 Sansi Mac. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.cyan
        setupUI()
        addChildVC()
        montageAction()
    }

    //MARK: --- setupUI
    func setupUI() {
        view.addSubview(topBar)
        view.addSubview(leftBar)
        leftBar.addSubview(montageBtn)
        leftBar.addSubview(deviceBtn)
    }
    
    //MARK: --- action 方法
    @objc func montageAction(){
        let vc = childViewControllers[0] as! MontageViewController
        if view.viewWithTag(1000) != nil {
            view.bringSubview(toFront: vc.view)
            return
        }
        vc.view.frame = CGRect(x: leftBar.frame.maxX, y: topBar.frame.maxY, width: kScreenWidth-leftBar.bounds.size.width, height: view.bounds.size.height-kStatusNavBarH)
        vc.setupUI()
        view.addSubview(vc.view)
    }
    @objc func deviceAction(){
        let vc = childViewControllers[1]
        if view.viewWithTag(1001) != nil {
            view.bringSubview(toFront: vc.view)
            return
        }
        vc.view.frame = CGRect(x: leftBar.frame.maxX, y: topBar.frame.maxY, width: kScreenWidth-leftBar.frame.size.width, height: view.bounds.size.height-kStatusNavBarH)
        view.addSubview(vc.view)
    }
    func addChildVC() {
        let montageVC = MontageViewController()
        montageVC.view.tag = 1000
        addChildViewController(montageVC)
        
        let vc = UIViewController()
        vc.view.backgroundColor = UIColor.red
        vc.view.tag = 1001
        addChildViewController(vc)
    }
    
    //MARK: --- 懒加载
    lazy var topBar:UIView = {
        let topBar = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kStatusNavBarH))
        topBar.backgroundColor = UIColor.white
        return topBar
    }()
    lazy var leftBar:UIView = {
        let leftBar = UIView(frame: CGRect(x: 0, y: topBar.frame.maxY, width: 50, height: kScreenHeight-kStatusNavBarH))
        leftBar.backgroundColor = UIColor.black
        return leftBar
    }()
    lazy var montageBtn:UIButton = {
        let montageBtn = UIButton(frame: CGRect(x: 10, y: 100, width: 30, height: 30))
        montageBtn.backgroundColor = UIColor.brown
        montageBtn.setTitle("拼接器", for: .normal)
        montageBtn.titleLabel?.font = UIFont.systemFont(ofSize: 8)
        montageBtn.addTarget(self, action: #selector(montageAction), for: .touchUpInside)
        return montageBtn
    }()
    lazy var deviceBtn:UIButton = {
        let btn = UIButton(frame: CGRect(x: 10, y: montageBtn.frame.maxY+100, width: 30, height: 30))
        btn.backgroundColor = UIColor.brown
        btn.setTitle("设备", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 8)
        btn.addTarget(self, action: #selector(deviceAction), for: .touchUpInside)
        return btn
    }()
}
