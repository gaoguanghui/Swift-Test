//
//  MoveView.swift
//  SwiftPad-test
//
//  Created by Sansi Mac on 2018/6/21.
//  Copyright © 2018年 Sansi Mac. All rights reserved.
//

import UIKit

class MoveView: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.red
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
