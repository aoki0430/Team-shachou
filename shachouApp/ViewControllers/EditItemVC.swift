//
//  EditItemVC.swift
//  shachouApp
//
//  Created by 吉田壮志 on 2018/03/26.
//  Copyright © 2018年 Team-shachou. All rights reserved.
//

import UIKit
import SnapKit
import Material
import DKImagePickerController
import SwiftyUserDefaults

final class EditItemVC: UIViewController {
    
    let model : ItemModel
    
    init(shopID: Int) {
        model = ItemModel(shopID)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let cameraButton: UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(cameraBtnDidTap), for: .touchUpInside)
        return btn
    }()
    
    let ImageBackView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 4
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let ItemNameField: TextField = {
        let textField = TextField()
        textField.placeholder = "服の名前"
        textField.textAlignment = .center
        textField.backgroundColor = UIColor.white
        textField.placeholderActiveColor = UIColor.gray //textFieldの中の文字色
        textField.dividerColor = UIColor.gray
        textField.dividerActiveColor = UIColor.gray
        return textField
    }()
    
    let ItemSizeField: TextField = {
        let textField = TextField()
        textField.placeholder = "サイズ"
        textField.textAlignment = .center
        textField.backgroundColor = UIColor.white
        textField.placeholderActiveColor = UIColor.gray
        textField.dividerColor = UIColor.gray
        textField.dividerActiveColor = UIColor.gray
        return textField
    }()
    
    let ItemCostField: TextField = {
        let textField = TextField()
        textField.placeholder = "値段"
        textField.textAlignment = .center
        textField.backgroundColor = UIColor.white
        textField.placeholderActiveColor = UIColor.gray
        textField.dividerColor = UIColor.gray
        textField.dividerActiveColor = UIColor.gray
        return textField
    }()
    
    let ItemInformationField: TextField = {
        let textField = TextField()
        textField.placeholder = "説明"
        textField.textAlignment = .center
        textField.backgroundColor = UIColor.white
        textField.placeholderActiveColor = UIColor.gray
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
            self.view.backgroundColor = UIColor(red: 0.2, green: 0.047, blue: 0, alpha: 1.0)
            self.view.addSubview(ImageBackView)
            self.view.addSubview(cameraButton)
            self.view.addSubview(ItemNameField)
            self.view.addSubview(ItemSizeField)
            self.view.addSubview(ItemCostField)
            self.view.addSubview(ItemInformationField)
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "完了", style: .plain, target: self, action: #selector(screen1))
            self.navigationItem.title = "お店1" //JSON形式でお店の名前欲しい
            //        rightBarButton = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(MyShopVC.screen1))
            
            ImageBackView.snp.makeConstraints{
                $0.height.equalTo(300)
                $0.width.equalToSuperview()
                $0.top.equalToSuperview().offset(65)
            }
            
            cameraButton.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
            
            ItemNameField.snp.makeConstraints{
                $0.height.equalTo(70)
                $0.width.equalToSuperview()
                $0.top.equalTo(ImageBackView.snp.bottom).offset(2)
            }
    
            ItemSizeField.snp.makeConstraints{
                $0.height.equalTo(70)
                $0.width.equalToSuperview()
                $0.top.equalTo(ItemNameField.snp.bottom).offset(2)
            }
    
            ItemCostField.snp.makeConstraints{
                $0.height.equalTo(70)
                $0.width.equalToSuperview()
                $0.top.equalTo(ItemSizeField.snp.bottom).offset(2)
                }
    
            ItemInformationField.snp.makeConstraints{
                $0.bottom.equalToSuperview().offset(2)
                $0.width.equalToSuperview()
                $0.top.equalTo(ItemCostField.snp.bottom).offset(2)
            }
    
            button1.snp.makeConstraints{
                $0.bottom.equalToSuperview().offset(-10)
                $0.right.equalToSuperview().offset(-10)
                $0.width.equalTo(150)
                $0.height.equalTo(30)
            }
    }
//            @objc func screen1() {// selectorで呼び出す場合Swift4からは「@objc」をつける。
//                guard let shopname = ShopNameField.text,
//                    let address = ShopAccessField.text,
//                    let tel = ShopCallField.text,
//                    let text = ShopInfoField.text,
//                    let image = ImageBackView.image
//                    else { return }
//
//                ShopModel(Defaults[.shopid]).Editshop(shopname: shopname, address: address, tel: tel, text: text, image: image) {
//                    self.dismiss(animated: true, completion: nil)
//                }
//            }
//
            @objc func screen1() {// selectorで呼び出す場合Swift4からは「@objc」をつける。
                let nextVC = MyShopVC(shopID: Defaults[.shopid])
                let naviVC = UINavigationController(rootViewController: nextVC)
                nextVC.view.backgroundColor = UIColor.gray
                self.present(naviVC, animated: true, completion: nil)
            }
//
            @objc func cameraBtnDidTap() {
                let pickerController = DKImagePickerController()
                
                pickerController.didSelectAssets = { (assets: [DKAsset]) in
                    print("didSelectAssets")
                    for asset in assets {
                        asset.fetchFullScreenImage(true, completeBlock: { (image, info) in
                            if let image = image {
                                self.ImageBackView.image = image
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
    
