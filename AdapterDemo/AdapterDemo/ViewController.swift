//
//  ViewController.swift
//  TableAdatperDemo
//
//  Created by hallfry on 2019/11/11.
//  Copyright © 2019 hallfry. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var tableView: UITableView = {
        let tableView = UITableView()
//        tableView.backgroundColor = .red
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    var dataSource = ["first obj", "second obj", "third obj"]
    
    let adapter = TableAdapter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
//        tableView.delegate = self
//        tableView.dataSource = self
        
        // 代理对象不能是局部变量，否则函数生命周期函数结束就销毁了
//        let adapter = TableAdapter()
        adapter.dataSource = dataSource
        tableView.delegate = adapter
        tableView.dataSource = adapter
        
        
        testAdapter()
    }
}

fileprivate extension ViewController {
    func setupUI() {
        tableView.frame = view.bounds
        view.addSubview(tableView)
    }
    
    func testAdapter() {
        let adapter = Adapter()
        let money = adapter.getCNY()
        print(money)
    }
}

//extension ViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        dataSource.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell()
//
//        let title = dataSource[indexPath.row]
//        cell.textLabel?.text = title
//        return cell
//    }
//}

