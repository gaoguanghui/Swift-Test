//
//  SceneListView.swift
//  SwiftPad-test
//
//  Created by Sansi Mac on 2018/6/20.
//  Copyright © 2018年 Sansi Mac. All rights reserved.
//

import UIKit

class SceneListView: UIView, UITableViewDelegate, UITableViewDataSource {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    override func layoutSubviews() {
    }
    //MARK: --- setupUI
    func setupUI() {
        addSubview(tableView)
    }
    
    //MARK: --- 懒加载
    lazy var tableView:UITableView = {
       let tableView = UITableView(frame: CGRect(x: 0, y: 40, width: frame.size.width, height: frame.size.height-40), style: .plain)
        tableView.register(SceneTableViewCell.self, forCellReuseIdentifier: "SceneTableViewCell")
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension SceneListView{
    //MARK: --- tableView数据源、代理
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SceneTableViewCell", for: indexPath)
        cell.textLabel?.text = String(indexPath.row)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
