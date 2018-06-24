//
//  GHMenuView.swift
//  SwiftPad-test
//
//  Created by jinjin on 2018/6/24.
//  Copyright © 2018年 Sansi Mac. All rights reserved.
//

import UIKit

enum GHMenuType {
    case wx
    case wy
    case tb
    case ss
}
typealias SelectBlock = (_ type: String)-> Void//(_ type: GHMenuType)-> Void

class GHMenuView: UIView , UICollectionViewDataSource, UICollectionViewDelegate{

    var selectBlock: SelectBlock?
    
    let dataArray = ["微信", "网易", "淘宝", "扫扫"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: --- setupUI()
    func setupUI() {
        addSubview(collectionView)
    }
    //MARK: --- 懒加载
    lazy var collectionView: UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        flow.itemSize = CGSize(width: bounds.size.width/CGFloat(dataArray.count), height: bounds.size.height)
        flow.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height), collectionViewLayout: flow)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MenuCollectionCell.self, forCellWithReuseIdentifier: "MenuCollectionCell")
        return collectionView
    }()
}

extension GHMenuView {
    //MARK: --- collectionView 代理/数据源
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCollectionCell", for: indexPath) as! MenuCollectionCell
        cell.label.text = dataArray[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectBlock!(dataArray[indexPath.item])
        print("===---==------\(dataArray[indexPath.item])")
    }
}
