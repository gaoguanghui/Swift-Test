//
//  MenuCollectionCell.swift
//  SwiftPad-test
//
//  Created by jinjin on 2018/6/24.
//  Copyright © 2018年 Sansi Mac. All rights reserved.
//

import UIKit

class MenuCollectionCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
    }
    
    
    lazy var label: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height))
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.orange
        return label
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
