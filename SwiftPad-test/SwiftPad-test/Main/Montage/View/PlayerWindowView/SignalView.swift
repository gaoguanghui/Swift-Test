//
//  SignalView.swift
//  SwiftPad-test
//
//  Created by Sansi Mac on 2018/6/22.
//  Copyright © 2018年 Sansi Mac. All rights reserved.
//

import UIKit

class SignalView: UIView {//一个信号源View

    var lastScale: CGFloat = 0.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(pinchView))
        addGestureRecognizer(pinch)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //
    @objc func pinchView(pinch:UIPinchGestureRecognizer){
        if pinch.state == .changed {
            pinch.view?.frame = CGRect(x: (pinch.view?.center.x)! - (pinch.view?.bounds.size.width)!*pinch.scale/2.0, y: (pinch.view?.center.y)! - (pinch.view?.bounds.size.height)!*pinch.scale/2.0, width: (pinch.view?.bounds.size.width)!*pinch.scale, height: (pinch.view?.bounds.size.height)!*pinch.scale)
            pinch.scale = 1.0
        }
    }
    
}
