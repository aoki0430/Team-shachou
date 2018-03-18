//
//  MyShopVC.swift
//  shachouApp
//
//  Created by 相楽昌希 on 2018/03/07.
//  Copyright © 2018年 Team-shachou. All rights reserved.
//

import UIKit
import SnapKit

class MyShopVC: UIViewController {
    
    let cameraBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .black
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "お店1"
        
        self.view.addSubview(cameraBtn)
        cameraBtn.addTarget(self, action: #selector(cameraBtnDidTap), for: .touchUpInside)
        
        cameraBtn.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
    }
    
    @objc func cameraBtnDidTap() {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
