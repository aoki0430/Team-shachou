//
//  SignUpVC .swift
//  shachouApp
//
//  Created by 相楽昌希 on 2018/02/28.
//  Copyright © 2018年 Team-shachou. All rights reserved.
//
import UIKit
import SnapKit

class ViewController: UIViewController {

    let button1: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.blue
        button.setTitle("購入者として利用", for: [])
        button.layer.borderWidth = 0.1
        button.layer.cornerRadius = 25
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: UIFont.Weight(rawValue: 1))
        button.addTarget(self, action: #selector(screen1), for: .touchUpInside)
        return button
    }()

    let button2: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.blue
        button.setTitle("出店者として利用", for: [])
        button.layer.borderWidth = 0.1
        button.layer.cornerRadius = 25
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: UIFont.Weight(rawValue: 1))
        button.addTarget(self, action: #selector(screen2), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(button1)
        self.view.addSubview(button2)
        
        self.view.backgroundColor = UIColor.white
        
        button1.snp.makeConstraints{
            $0.height.equalTo(50)
            $0.width.equalTo(200)
            $0.centerY.equalToSuperview().offset(30)
            $0.centerX.equalToSuperview()
        }
        
        button2.snp.makeConstraints{
            $0.height.equalTo(50)
            $0.width.equalTo(200)
            $0.centerY.equalToSuperview().offset(-30)
            $0.centerX.equalToSuperview()
        }
    }

    @objc func screen1(){
        let nextvc = ViewController()
        nextvc.view.backgroundColor = UIColor.white
        self.present(nextvc, animated: true, completion: nil)
    }
    
    @objc func screen2(){
        let nextvc = ViewController()
        nextvc.view.backgroundColor = UIColor.white
        self.present(nextvc, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning(){
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can berecreated.
    }
}
