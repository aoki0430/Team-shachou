//
//  MyShopVC.swift
//  shachouApp
//
//  Created by 相楽昌希 on 2018/03/07.
//  Copyright © 2018年 Team-shachou. All rights reserved.
//

import UIKit
import SnapKit
import Photos
import DKImagePickerController

class MyShopVC: UIViewController {
    
    let ImageBackView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 4
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let ShopNameLabel: UILabel = {
        let label = UILabel()
        label.text = "お店１"
        label.textAlignment = .center
        label.layer.cornerRadius = 4
        label.backgroundColor = UIColor.white
        return label
    }()
    
    let ShopCallLabel: UILabel = {
        let label = UILabel()
        label.text = "電話:0120-117-117"
        label.textAlignment = .center
        label.layer.cornerRadius = 4
        label.backgroundColor = UIColor.white
        return label
    }()
    
    let ShopAccessLabel: UILabel = {
        let label = UILabel()
        label.text = "住所:東京都調布市調布ヶ丘１"
        label.textAlignment = .center
        label.layer.cornerRadius = 4
        label.backgroundColor = UIColor.white
        return label
    }()
    
    let ShopInfoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.text = "詳細:チェックシャツの\n洋服をたくさん売っているお店です"
        label.textAlignment = .center
        label.layer.cornerRadius = 4
        label.backgroundColor = UIColor.white
        return label
    }()
    
    let button1: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.brown
        button.setTitle("編集", for: [])
        button.layer.borderWidth = 0.1
        button.layer.cornerRadius = 5
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: UIFont.Weight(rawValue: 1))
        button.addTarget(self, action: #selector(screen1), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(ImageBackView)
        self.view.addSubview(ShopNameLabel)
        self.view.addSubview(ShopCallLabel)
        self.view.addSubview(ShopAccessLabel)
        self.view.addSubview(ShopInfoLabel)
        self.view.addSubview(button1)
        self.navigationItem.title = "お店1" //JSON形式でお店の名前欲しい
//        rightBarButton = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(MyShopVC.screen1))
        
        ImageBackView.snp.makeConstraints{
            $0.height.equalTo(300)
            $0.width.equalToSuperview()
            $0.top.equalToSuperview().offset(65)
        }
        
        ShopNameLabel.snp.makeConstraints{
            $0.height.equalTo(70)
            $0.width.equalToSuperview()
            $0.top.equalTo(ImageBackView.snp.bottom).offset(2)
        }
        
        ShopCallLabel.snp.makeConstraints{
            $0.height.equalTo(70)
            $0.width.equalToSuperview()
            $0.top.equalTo(ShopNameLabel.snp.bottom).offset(2)
        }
        
        ShopAccessLabel.snp.makeConstraints{
            $0.height.equalTo(70)
            $0.width.equalToSuperview()
            $0.top.equalTo(ShopCallLabel.snp.bottom).offset(2)
        }
        
        ShopInfoLabel.snp.makeConstraints{
            $0.bottom.equalToSuperview().offset(2)
            $0.width.equalToSuperview()
            $0.top.equalTo(ShopAccessLabel.snp.bottom).offset(2)
        }
        
        button1.snp.makeConstraints{
            $0.bottom.equalToSuperview().offset(-10)
            $0.right.equalToSuperview().offset(-10)
            $0.width.equalTo(150)
            $0.height.equalTo(30)
        }
    }
    
    @objc func screen1() {// selectorで呼び出す場合Swift4からは「@objc」をつける。
        let nextVC = MyShopEditVC()
        let naviVC = UINavigationController(rootViewController: nextVC)
        nextVC.view.backgroundColor = UIColor.gray
        self.present(naviVC, animated: true, completion: nil)

    
    @objc func cameraBtnDidTap() {
        let pickerController = DKImagePickerController()
        
        pickerController.didSelectAssets = { (assets: [DKAsset]) in
            print("didSelectAssets")
            for asset in assets {
                asset.fetchFullScreenImage(true, completeBlock: { (image, info) in
                    if let image = image {
                        self.imageView.image = image
                    }
                })
            }
        }
        
        self.present(pickerController, animated: true) {}
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
