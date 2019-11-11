//
//  TableAdapter.swift
//  TableAdatperDemo
//
//  Created by hallfry on 2019/11/11.
//  Copyright © 2019 hallfry. All rights reserved.
//

/*
 适配器设计模式的一种用法
 可以减少controller的代码量，把一些重复的事情提取出来
 云信IM demo中的聊天室就是这样来处理问题的
 
 适用于一些简单的场景，尤其是共用一种cell的单元格
 */

import UIKit

class TableAdapter: NSObject {
    var dataSource = ["default obj"]
    
}

extension TableAdapter: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell()

        let title = dataSource[indexPath.row]
        cell.textLabel?.text = title
        return cell
    }
}
