//
//  SignalSourceView.swift
//  SwiftPad-test
//
//  Created by Sansi Mac on 2018/6/20.
//  Copyright © 2018年 Sansi Mac. All rights reserved.
//

import UIKit

class SignalSourceView: UIView , UICollectionViewDelegate, UICollectionViewDataSource{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    override func layoutSubviews() {
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: --- setupUI
    func setupUI() {
        addSubview(collectionView)
    }
    
    //MARK: --- 懒加载
    lazy var collectionView:UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 100, height: 100)
       let collectionView = UICollectionView(frame: CGRect(x: 10, y: 40, width: frame.size.width-20, height: frame.size.height-40-10), collectionViewLayout: flowLayout)
        collectionView.register(SignalSourceCollectionCell.self, forCellWithReuseIdentifier: "SignalSourceCollectionCell")
        collectionView.backgroundColor = UIColor.clear
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()

}

extension SignalSourceView{
    //MARK: --- collection delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SignalSourceCollectionCell", for: indexPath)
        cell.backgroundColor = UIColor.cyan
        return cell
    }
}

extension SignalSourceView {
    
}
