//
//  MyShopEditVC.swift
//  shachouApp
//
//  Created by 相楽昌希 on 2018/03/21.
//  Copyright © 2018年 Team-shachou. All rights reserved.
//

import UIKit
import SnapKit
import Material

final class MyShopEditVC: UIViewController {
    
    let ImageBackView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 4
        view.backgroundColor = UIColor.white
        return view
    }()
    
    
    let ShopNameField: TextField = {
        let textField = TextField()
        textField.placeholder = "お店の名前"
        textField.textAlignment = .center
        textField.backgroundColor = UIColor.white
        textField.placeholderActiveColor = UIColor.gray //textFieldの中の文字色
        textField.dividerColor = UIColor.gray
        textField.dividerActiveColor = UIColor.gray
        return textField
    }()

    
    let ShopCallField: TextField = {
        let textField = TextField()
        textField.placeholder = "電話番号"
        textField.textAlignment = .center
        textField.backgroundColor = UIColor.white
        textField.placeholderActiveColor = UIColor.gray
        textField.dividerColor = UIColor.gray
        textField.dividerActiveColor = UIColor.gray
        return textField
    }()

    let ShopAccessField: TextField = {
        let textField = TextField()
        textField.placeholder = "住所"
        textField.textAlignment = .center
        textField.backgroundColor = UIColor.white
        textField.placeholderActiveColor = UIColor.gray
        textField.dividerColor = UIColor.gray
        textField.dividerActiveColor = UIColor.gray
        return textField
    }()
    
    let ShopInfoField: TextField = {
        let textField = TextField()
        textField.placeholder = "詳細"
        textField.textAlignment = .center
        textField.backgroundColor = UIColor.white
        textField.placeholderActiveColor = UIColor.gray
        textField.dividerColor = UIColor.gray
        textField.dividerActiveColor = UIColor.gray
        return textField
    }()
    
    let button1: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.brown
        button.setTitle("完了", for: [])
        button.layer.borderWidth = 0.1
        button.layer.cornerRadius = 5
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: UIFont.Weight(rawValue: 1))
        button.addTarget(self, action: #selector(screen1), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(ImageBackView)
        self.view.addSubview(ShopNameField)
        self.view.addSubview(ShopCallField)
        self.view.addSubview(ShopAccessField)
        self.view.addSubview(ShopInfoField)
        self.view.addSubview(button1)
        self.navigationItem.title = "お店1" //JSON形式でお店の名前欲しい
        //        rightBarButton = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(MyShopVC.screen1))
        
        ImageBackView.snp.makeConstraints{
            $0.height.equalTo(300)
            $0.width.equalToSuperview()
            $0.top.equalToSuperview().offset(65)
        }
        
        ShopNameField.snp.makeConstraints{
            $0.height.equalTo(70)
            $0.width.equalToSuperview()
            $0.top.equalTo(ImageBackView.snp.bottom).offset(2)
        }
        
        ShopCallField.snp.makeConstraints{
            $0.height.equalTo(70)
            $0.width.equalToSuperview()
            $0.top.equalTo(ShopNameField.snp.bottom).offset(2)
        }
        
        ShopAccessField.snp.makeConstraints{
            $0.height.equalTo(70)
            $0.width.equalToSuperview()
            $0.top.equalTo(ShopCallField.snp.bottom).offset(2)
        }
        
        ShopInfoField.snp.makeConstraints{
            $0.bottom.equalToSuperview().offset(2)
            $0.width.equalToSuperview()
            $0.top.equalTo(ShopAccessField.snp.bottom).offset(2)
        }
        
        button1.snp.makeConstraints{
            $0.bottom.equalToSuperview().offset(-10)
            $0.right.equalToSuperview().offset(-10)
            $0.width.equalTo(150)
            $0.height.equalTo(30)
        }
    }
    
    @objc func screen1() {// selectorで呼び出す場合Swift4からは「@objc」をつける。
        let nextVC = MyShopVC()
        let naviVC = UINavigationController(rootViewController: nextVC)
        nextVC.view.backgroundColor = UIColor.gray
        self.present(naviVC, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


