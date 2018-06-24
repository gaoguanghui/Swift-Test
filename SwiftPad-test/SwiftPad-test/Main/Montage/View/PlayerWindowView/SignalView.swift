//
//  SignalView.swift
//  SwiftPad-test
//
//  Created by Sansi Mac on 2018/6/22.
//  Copyright © 2018年 Sansi Mac. All rights reserved.
//

import UIKit

enum PanRegion {
    case leftTop
    case top
    case topRight
    case right
    case rightBottom
    case bottom
    case leftBottom
    case left
}
//enum panDirection {
//    case ss
//}

class SignalView: UIView {//一个信号源View

    var lastScale: CGFloat = 0.0
    var panRegion: PanRegion?
    let spaceLine: CGFloat = 1.0
    let cellWH: CGFloat = 30.0
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        setupUI()
        setupGesture()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //
    func setupUI(){
        let leftTopView = UIView(frame: CGRect(x: 0, y: 0, width: cellWH, height: cellWH))
        leftTopView.backgroundColor = UIColor.red
        addSubview(leftTopView)

        let topView = UIView(frame: CGRect(x: cellWH+spaceLine, y: 0, width: bounds.size.width-spaceLine*2-2*cellWH, height: cellWH))
        topView.backgroundColor = UIColor.orange
        addSubview(topView)

        let topRightView = UIView(frame: CGRect(x: bounds.size.width-cellWH, y: 0, width: cellWH, height: cellWH))
        topRightView.backgroundColor = UIColor.red
        addSubview(topRightView)

        let rightView = UIView(frame: CGRect(x: bounds.size.width-cellWH, y: cellWH+spaceLine, width: cellWH, height: bounds.size.height-2*spaceLine-2*cellWH))
        rightView.backgroundColor = UIColor.orange
        addSubview(rightView)
        
        let rightBottomView = UIView(frame: CGRect(x: bounds.size.width-cellWH, y: bounds.size.height-cellWH, width: cellWH, height: cellWH))
        rightBottomView.backgroundColor = UIColor.red
        addSubview(rightBottomView)

        let bottomView = UIView(frame: CGRect(x: cellWH+spaceLine, y: bounds.size.height-cellWH, width: bounds.size.width-2*spaceLine-2*cellWH, height: cellWH))
        bottomView.backgroundColor = UIColor.orange
        addSubview(bottomView)

        let leftBottomView = UIView(frame: CGRect(x: 0, y: bounds.size.height-cellWH, width: cellWH, height: cellWH))
        leftBottomView.backgroundColor = UIColor.red
        addSubview(leftBottomView)

        let leftView = UIView(frame: CGRect(x: 0, y: cellWH+spaceLine, width: cellWH, height: bounds.size.height-2*spaceLine-2*cellWH))
        leftView.backgroundColor = UIColor.orange
        addSubview(leftView)
    }
    //
    func setupGesture(){
        //捏合来缩放视频源视图大小
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(pinchView))
        addGestureRecognizer(pinch)
    }
    //
    @objc func pinchView(pinch:UIPinchGestureRecognizer){
        if pinch.state == .changed {
            pinch.view?.frame = CGRect(x: (pinch.view?.center.x)! - (pinch.view?.bounds.size.width)!*pinch.scale/2.0, y: (pinch.view?.center.y)! - (pinch.view?.bounds.size.height)!*pinch.scale/2.0, width: (pinch.view?.bounds.size.width)!*pinch.scale, height: (pinch.view?.bounds.size.height)!*pinch.scale)
            pinch.scale = 1.0
        }
    }
    //根据点判断方向
    func judgeDirectionWithPoint(_ point: CGPoint){
        if CGRect(x: 0, y: 0, width: cellWH, height: cellWH).contains(point) {
            panRegion = .leftTop
        }else if CGRect(x: cellWH+spaceLine, y: 0, width: bounds.size.width-spaceLine*2-2*cellWH, height: cellWH).contains(point) {
            panRegion = .top
        }else if CGRect(x: bounds.size.width-cellWH, y: 0, width: cellWH, height: cellWH).contains(point) {
            panRegion = .topRight
        }else if CGRect(x: bounds.size.width-cellWH, y: cellWH+spaceLine, width: cellWH, height: bounds.size.height-2*spaceLine-2*cellWH).contains(point) {
            panRegion = .right
        }else if CGRect(x: bounds.size.width-cellWH, y: bounds.size.height-cellWH, width: cellWH, height: cellWH).contains(point) {
            panRegion = .rightBottom
        }else if CGRect(x: cellWH+spaceLine, y: bounds.size.height-cellWH, width: bounds.size.width-2*spaceLine-2*cellWH, height: cellWH).contains(point) {
            panRegion = .bottom
        }else if CGRect(x: 0, y: bounds.size.height-cellWH, width: cellWH, height: cellWH).contains(point) {
            panRegion = .leftBottom
        }else if CGRect(x: 0, y: cellWH+spaceLine, width: cellWH, height: bounds.size.height-2*spaceLine-2*cellWH).contains(point) {
            panRegion = .left
        }else{
            panRegion = .none
        }
    }
}
