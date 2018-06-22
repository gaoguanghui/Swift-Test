//
//  PlayView.swift
//  SwiftPad-test
//
//  Created by Sansi Mac on 2018/6/21.
//  Copyright © 2018年 Sansi Mac. All rights reserved.
//

import UIKit

struct RectPath {
    var x: Int = 0
    var y: Int = 0
    
}

class PlayView: UIView {//播放界面
    var cellW: CGFloat = 0//根据行数列数平分宽高
    var cellH: CGFloat = 0
    var pathArray = [RectPath]()//每个cell对应一个
    var originalPoint: CGPoint?//用于拖动时的处理
    var panSignalView: SignalView?//正在拖动的信号源播放视图
    var isPanSignalView = false//是否是拖动信号源播放视图
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    convenience init(frame: CGRect, rectPath: RectPath) {
        self.init(frame: frame)
        setupUI(rectPath)
        cellW = frame.size.width/CGFloat(rectPath.y)
        cellH = frame.size.height/CGFloat(rectPath.x)
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressAction))
        longPress.minimumPressDuration = 0.2
        addGestureRecognizer(longPress)
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        tap.numberOfTapsRequired = 2
        addGestureRecognizer(tap)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: --- 重写响应者链的 hitTest方法
    //重写响应者链  让子视图超出父视图的部分也可以响应操作
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        if view == nil {
            for subView in subviews {
                let point = subView.convert(point, from: self)
                if subView.bounds.contains(point) {
                    print("=============================")
                    return subView
                }
            }
        }
        return view
    }
    //MARK: --- UI设置
    func setupUI(_ rectPath:RectPath)  {
        //根据行数和列数 来添加cell边框
        let theCellW = (frame.size.width - CGFloat(rectPath.y+1))/CGFloat(rectPath.y)
        let theCellH = (frame.size.height - CGFloat(rectPath.x+1))/CGFloat(rectPath.x)
        for theX in 0...rectPath.x {
            let rowLine = UIView(frame: CGRect(x: 0, y: CGFloat(theX) * theCellH + CGFloat(theX), width: frame.size.width, height: 1))
            rowLine.backgroundColor = UIColor.red
            addSubview(rowLine)
        }
        for theY in 0...rectPath.y{
            let columnLine = UIView(frame: CGRect(x: CGFloat(theY) * theCellW + CGFloat(theY), y: 0, width: 1, height: frame.size.height))
            columnLine.backgroundColor = UIColor.white
            addSubview(columnLine)
        }
        var path = RectPath(x: 0, y: 0)
        
        for X in 0...(rectPath.x-1){
            path.x = X
            for Y in 0...(rectPath.y-1){
                path.y = Y
                pathArray.append(path)
            }
        }
    }
    
    //MARK: ---
    //判断一个播放视图与那几个cell有交集 然后填充满有交集cell中
    func judgeContainsRect(_ view: SignalView) {
        var containsArray = [RectPath]()
        for path in pathArray {
            let rect = CGRect(x: CGFloat(path.y)*cellW, y: CGFloat(path.x)*cellH, width: cellW, height: cellH)
            if rect.intersects(view.frame) {
                containsArray.append(path)
            }
        }
        let rect = createRectView(firstPath: containsArray.first!, finalPath: containsArray.last!)
        UIView.animate(withDuration: 0.25) {
            view.frame = rect
        }
        
    }
    //判断拖动的点在哪个cell上 然后填充满该cell
    func judgeContainsPoint(_ convertPoint: CGPoint) {
        var containsArray = [RectPath]()
        for path in pathArray {
            let rect = CGRect(x: CGFloat(path.y)*cellW, y: CGFloat(path.x)*cellH, width: cellW, height: cellH)
            if rect.contains(convertPoint) {
                containsArray.append(path)
            }
        }
        let rect = createRectView(firstPath: containsArray.first!, finalPath: containsArray.last!)
        let view = SignalView(frame: rect)
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 1
        view.backgroundColor = UIColor.black
        addSubview(view)
    }
    //创建播放源视图并添加到playView上
    func createRectView(firstPath: RectPath, finalPath: RectPath) -> CGRect {
        //排序
        //找出path.x的最小值，乘以cellH 就是rect的y值
        //找出path.y的最小值 乘以cellW 就是要填充的rect的x值，
        //找出path.x最大值和最小值，相减后再加1 再乘以cellH 即rect的高
        //找出path.y最大值和最小值，相减后再加1 再乘以cellW 即为rect的宽
        //如果只有一个path,那就是自身减自身
        let frameX = cellW*CGFloat((firstPath.y))
        let frameY = cellH*CGFloat((firstPath.x))
        let frameH = CGFloat(((finalPath.x)-(firstPath.x))+1)*cellH
        let frameW = CGFloat(((finalPath.y)-(firstPath.y))+1)*cellW
        let rect = CGRect(x: frameX, y: frameY, width: frameW, height: frameH)
        return rect
    }
}

extension PlayView {
    //MARK: --- acton 方法
    @objc func tapAction(tap:UITapGestureRecognizer){
        let point = tap.location(in: self)
        //双击到某个播放源视图 填充满所占的cells
        for view in subviews.reversed() {
            if view.frame.contains(point) && view.isKind(of: SignalView.self) {
                judgeContainsRect(view as! SignalView)
            }
        }
        
    }
    @objc func longPressAction(longPress:UILongPressGestureRecognizer) {
        let point = longPress.location(in: longPress.view)
        print("==========pan==\(point)")
        switch longPress.state {
        case .began:
            originalPoint = point
            for view in self.subviews.reversed() {
                if view.frame.contains(point) && view.isKind(of: SignalView.self) {
                    panSignalView = view as? SignalView
                    isPanSignalView = true
                    UIView.animate(withDuration: 0.1, animations: {
                        self.panSignalView?.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                    }) { (finished) in
                        UIView.animate(withDuration: 0.1, animations: {
                            self.panSignalView?.transform = CGAffineTransform.identity
                        })
                    }
                    break
                }
            }
        case .changed:
            if isPanSignalView {
                let offsetX = point.x - (originalPoint?.x)!
                let offsetY = point.y - (originalPoint?.y)!
                let originalCenter = panSignalView?.center
                panSignalView?.center = CGPoint(x: (originalCenter?.x)! + offsetX, y: (originalCenter?.y)! + offsetY)
                originalPoint = point
            }
        case .ended:
            if isPanSignalView {
                let offsetX = point.x - (originalPoint?.x)!
                let offsetY = point.y - (originalPoint?.y)!
                let originalCenter = panSignalView?.center
                panSignalView?.center = CGPoint(x: (originalCenter?.x)! + offsetX, y: (originalCenter?.y)! + offsetY)
                
                var containsArray = [RectPath]()
                for path in pathArray {
                    let rect = CGRect(x: CGFloat(path.y)*cellW, y: CGFloat(path.x)*cellH, width: cellW, height: cellH)
                    if rect.intersects((panSignalView?.frame)!) {
                        containsArray.append(path)
                    }
                }
                if containsArray.count == 0 {
                    panSignalView?.removeFromSuperview()
                    panSignalView = nil
                }
            }
            isPanSignalView = false
            print("=========panEnd==")
            let scrollView = superview as! PlayerWindowView
            scrollView.isScrollEnabled = true
        case .cancelled:
            isPanSignalView = false
            let scrollView = superview as! PlayerWindowView
            scrollView.isScrollEnabled = true
            print("========= panCanceled==")
        default:
            break
        }
    }
}

