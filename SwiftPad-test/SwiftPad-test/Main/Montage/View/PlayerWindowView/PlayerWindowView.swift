//
//  PlayerWindowView.swift
//  SwiftPad-test
//
//  Created by Sansi Mac on 2018/6/20.
//  Copyright © 2018年 Sansi Mac. All rights reserved.
//

import UIKit

//播放界面背景墙
class PlayerWindowView: UIScrollView , UIScrollViewDelegate, UIGestureRecognizerDelegate{
    override init(frame: CGRect) {
        super.init(frame: frame)
        minimumZoomScale = 0.4
        maximumZoomScale = 10.0
        delegate = self
        setupUI()
        setupGesture()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
//        print(contentSize)
//        print(frame)
    }
    
    //MARK: --- 设置UI
    func setupUI() {
        addSubview(playView)
    }
    //MARK: --- 设置手势
    func setupGesture(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        tap.numberOfTapsRequired = 2
        addGestureRecognizer(tap)
    }
    //MARK: --- 懒加载
    lazy var playView:PlayView = {
       let view = PlayView(frame: CGRect(x: 30, y: 50, width: frame.size.width-60, height: frame.size.height-100), rectPath: RectPath(x: 2, y: 3))
        view.backgroundColor = UIColor.gray
        return view
    }()
}

extension PlayerWindowView {
    //MARK: --- scrollViewDelegate
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return playView
    }
    func scrollViewDidZoom(_ scrollView: UIScrollView) {//缩放重点  中心点缩放
        contentSize = CGSize(width: playView.frame.size.width + 100, height: playView.frame.size.height + 200)
        playView.frame = CGRect(x: 30, y: 50, width: playView.frame.size.width, height: playView.frame.size.height)
        let offsetX = (frame.size.width > contentSize.width) ? (frame.size.width - contentSize.width)*0.5 : 0.0
        let offsetY = (frame.size.height > contentSize.height) ? (frame.size.height - contentSize.height)*0.5 : 0.0
        playView.center = CGPoint(x: scrollView.contentSize.width*0.5 + offsetX, y: scrollView.contentSize.height*0.5 + offsetY)
        isScrollEnabled = true
    }
}

extension PlayerWindowView {
    //MARK: --- 手势 方法
    @objc func tapAction(tap:UITapGestureRecognizer){
        //复原位
        zoomScale = 1.0
        contentSize = CGSize(width: 0, height: 0)
        UIView.animate(withDuration: 0.25, animations: {
            self.playView.frame = CGRect(x: 30, y: 50, width: self.frame.size.width-60, height: self.frame.size.height-100)
        }) { (finished) in
            
        }
    }
}

extension PlayerWindowView {
    //MARK: --- UIGestureRecognizerDelegate
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isKind(of: SignalView.self))! {
            print("========= ssss")
            isScrollEnabled = false
        }else{
            print("------------ooooo")
            isScrollEnabled = true
        }
        return true
    }
}
