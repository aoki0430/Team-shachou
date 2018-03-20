//
//  TopVC.swift
//  shachouApp
//
//  Created by 相楽昌希 on 2018/03/07.
//  Copyright © 2018年 Team-shachou. All rights reserved.
//
import UIKit
import SnapKit

final class TopVC: UIViewController {
    
    
    private lazy var tebleView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TopCell.self, forCellReuseIdentifier: "TopCell")
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = .none
        return tableView
    }()
    
    let button1: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.brown
        button.setTitle("お店１", for: [])
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: UIFont.Weight(rawValue: 1))
        button.addTarget(self, action: #selector(goNext), for: .touchUpInside)
        return button
    }()
    
    let button2: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.brown
        button.setTitle("お店2", for: [])
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: UIFont.Weight(rawValue: 1))
        button.addTarget(self, action: #selector(goNext), for: .touchUpInside)
        return button
    }()
    
    let button3: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.brown
        button.setTitle("お店3", for: [])
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: UIFont.Weight(rawValue: 1))
        button.addTarget(self, action: #selector(goNext), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(button1)
        self.view.addSubview(button2)
        self.view.addSubview(button3)
        
        button1.snp.makeConstraints{
            $0.height.equalTo(70)
            $0.width.equalToSuperview()
            $0.top.equalToSuperview().offset(70)
        }
        
        button2.snp.makeConstraints{
            $0.height.equalTo(70)
            $0.width.equalToSuperview()
            $0.top.equalTo(button1.snp.bottom).offset(5)
        }
        
        button3.snp.makeConstraints{
            $0.height.equalTo(70)
            $0.width.equalToSuperview()
            $0.top.equalTo(button2.snp.bottom).offset(5)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func goNext(_ sender: UIButton) {
        let next2vc = ShopVC()
        next2vc.view.backgroundColor = UIColor.gray
        self.navigationController?.pushViewController(next2vc, animated: true)
        self.navigationItem.title = "お店リスト"
    }
}

extension TopVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(shopVC(index: indexPath.row), animated: true)
    }
    
    func shopVC(index: Int) -> ShopVC {
        let shopVC = ShopVC(
            coder: shop(index: index).id
        )
    }
    
    func shop(index: Int) -> Shop {
        return self.model.Shops[index]
    }
}

