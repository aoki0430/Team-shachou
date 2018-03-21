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
    
    let cameraBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .black
        btn.setTitle("カメラまなだよ！", for: .normal)
        return btn
    }()
    
    let imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "お店1"
        
        self.view.addSubview(cameraBtn)
        self.view.addSubview(imageView)
        
        cameraBtn.addTarget(self, action: #selector(cameraBtnDidTap), for: .touchUpInside)
        
        cameraBtn.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        imageView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
    }
    
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
