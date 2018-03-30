//
//  SignUpVC .swift
//  shachouApp
//
//  Created by 相楽昌希 on 2018/02/28.
//  Copyright © 2018年 Team-shachou. All rights reserved.
//
import UIKit
import SnapKit

 final class WelcomeVC: UIViewController {
    
    let TeamlogoView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "Teamlogo2")
        //image viewの色を変更
        view.image = view.image?.withRenderingMode(.alwaysTemplate)
        view.tintColor = UIColor.white
        return view
    }()
    
    let ApplogoView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "Applogo")
        return view
    }()
    
    let WelcomeView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "welcomeVC")
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let button1: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.brown
        button.setTitle("購入者として登録", for: [])
        button.layer.borderWidth = 0.1
        button.layer.cornerRadius = 25
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: UIFont.Weight(rawValue: 1))
        button.addTarget(self, action: #selector(screen1), for: .touchUpInside)
        return button
    }()

    let button2: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.brown
        button.setTitle("出店者として登録", for: [])
        button.layer.borderWidth = 0.1
        button.layer.cornerRadius = 25
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: UIFont.Weight(rawValue: 1))
        button.addTarget(self, action: #selector(screen2), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.addSubview(WelcomeView)
        self.view.addSubview(ApplogoView)
        self.view.addSubview(TeamlogoView)
        self.view.addSubview(button1)
        self.view.addSubview(button2)
        
        self.view.backgroundColor = UIColor.white
        TeamlogoView.snp.makeConstraints {
            $0.height.equalTo(70)
            $0.width.equalTo(210)
            $0.centerY.equalToSuperview().offset(-20)
            $0.centerX.equalToSuperview().offset(30)
        }
        
        ApplogoView.snp.makeConstraints {
            $0.height.equalTo(60)
            $0.width.equalTo(60)
            $0.top.equalTo(TeamlogoView.snp.top)
            $0.right.equalTo(TeamlogoView.snp.left).offset(-10)
        }

        WelcomeView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        button1.snp.makeConstraints{
            $0.height.equalTo(50)
            $0.width.equalTo(280)
            $0.bottom.equalTo(button2.snp.top).offset(-20)
            $0.centerX.equalToSuperview()
        }
        
        button2.snp.makeConstraints{
            $0.height.equalTo(50)
            $0.width.equalTo(280)
            $0.bottom.equalToSuperview().offset(-40)
            $0.centerX.equalToSuperview()
        }
    }
    

    @objc func screen1(){
        let nextvc = UserSignUpVC()
        nextvc.view.backgroundColor = UIColor.white
        self.present(nextvc, animated: true, completion: nil)
    }
    
    @objc func screen2(){
        let nextvc = ShopSignUpVC()
        nextvc.view.backgroundColor = UIColor.white
        self.present(nextvc, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning(){
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can berecreated.
    }
}

//リサイズ
extension UIImage {
    func resized(toWidth width: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}

