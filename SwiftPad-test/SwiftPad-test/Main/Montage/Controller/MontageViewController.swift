//
//  MontageViewController.swift
//  SwiftPad-test
//
//  Created by Sansi Mac on 2018/6/20.
//  Copyright © 2018年 Sansi Mac. All rights reserved.
//

import UIKit

class MontageViewController: UIViewController , UIPopoverPresentationControllerDelegate{
    var originalPoint: CGPoint?
    var moveView: MoveView?
    var longPressGesture: UILongPressGestureRecognizer?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isTranslucent = false
        view.backgroundColor = UIColor.green
        NotificationCenter.default.addObserver(self, selector: #selector(presentMenuView), name: NSNotification.Name(rawValue: "MenuViewAction"), object: nil)
    }

    //MARK: --- setupUI
    func setupUI() {
        view.addSubview(playerWindowView)
        view.addSubview(signalSourceView)
        view.addSubview(sceneListView)
        longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressAction))
        view.addGestureRecognizer(longPressGesture!)
    }
    //MARK: --- 懒加载
    lazy var signalSourceView:SignalSourceView = {
        let aView = SignalSourceView(frame: CGRect(x: 10, y: playerWindowView.frame.maxY + 10, width: view.bounds.size.width - 20, height: view.bounds.size.height - 40 - playerWindowView.frame.size.height - 10 - 10))
        aView.backgroundColor = UIColor.brown
        return aView
    }()
    lazy var sceneListView:SceneListView = {
        let aView = SceneListView(frame: CGRect(x: playerWindowView.frame.maxX + 10, y: 40, width: view.bounds.size.width - playerWindowView.frame.maxX - 10 - 10, height: playerWindowView.frame.size.height))
        aView.backgroundColor = UIColor.red
        return aView
    }()
    lazy var playerWindowView:PlayerWindowView = {
        let aView = PlayerWindowView(frame: CGRect(x: 10, y: 40, width: view.bounds.size.width*0.7, height: view.bounds.size.height*0.55))
        aView.backgroundColor = UIColor.purple
        return aView
    }()


}

extension MontageViewController {
    //MARK: --- action 方法
    @objc func longPressAction(longPress:UILongPressGestureRecognizer){
        let point = longPress.location(in: longPress.view)
        switch longPress.state {
        case .began:
            let isInSignalSourceView = signalSourceView.frame.contains(point)
            if isInSignalSourceView {
                originalPoint = point
                let point = view.convert(originalPoint!, to: signalSourceView.collectionView)
                let selectedIndexPath = signalSourceView.collectionView.indexPathForItem(at: point)
                if selectedIndexPath != nil {
                    let cell = signalSourceView.collectionView.cellForItem(at: (selectedIndexPath)!)
                    let rect = signalSourceView.collectionView.convert((cell?.frame)!, to: view)
                    moveView = MoveView(frame: rect)
                    self.view.addSubview(moveView!)
                    moveViewScaleAnimate()
                }
            }
        case .changed:
            if moveView != nil{
                let offsetX = point.x - (originalPoint?.x)!
                let offsetY = point.y - (originalPoint?.y)!
                let originalCenter = moveView?.center
                moveView?.center = CGPoint(x: (originalCenter?.x)! + offsetX, y: (originalCenter?.y)! + offsetY)
                originalPoint = point
            }
        case .ended:
            if moveView != nil {
                let offsetX = point.x - (originalPoint?.x)!
                let offsetY = point.y - (originalPoint?.y)!
                let originalCenter = moveView?.center
                moveView?.center = CGPoint(x: (originalCenter?.x)! + offsetX, y: (originalCenter?.y)! + offsetY)
                moveViewToPlayerWindow(touchPoint: point)
            }
        default:
            break
        }
    }
    func moveViewScaleAnimate()  {
        UIView.animate(withDuration: 0.2, animations: {
            self.moveView?.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }) { (finished) in
            UIView.animate(withDuration: 0.1, animations: {
                self.moveView?.transform = CGAffineTransform.identity
            })
        }
    }
    func moveViewToPlayerWindow(touchPoint:CGPoint) {
        let rect = playerWindowView.convert(playerWindowView.playView.frame, to: view)
        if rect.contains(touchPoint) {
            let thePoint = view.convert(touchPoint, to: playerWindowView.playView)
            playerWindowView.playView.judgeContainsPoint(thePoint)
        }
        moveView?.removeFromSuperview()
        moveView = nil
    }
    //
    @objc func presentMenuView(notification: Notification) {
        print("TTTTTTTTT====")
        let signalView = notification.object as! SignalView
        if signalView != nil {
            let popVC = GHPopMenuController()
            popVC.modalPresentationStyle = .popover
            popVC.popoverPresentationController?.sourceView = signalView
            popVC.popoverPresentationController?.backgroundColor = UIColor.yellow
            popVC.popoverPresentationController?.permittedArrowDirections = .any
            popVC.popoverPresentationController?.sourceRect = signalView.bounds
            popVC.popoverPresentationController?.delegate = self
            present(popVC, animated: true) {
            }
        }
        
    }
    //MARK: --- UIPopoverPresentationControllerDelegate
    func popoverPresentationControllerShouldDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) -> Bool {
        return true
    }
}

extension MontageViewController {
    //MARK: ---
    
}

