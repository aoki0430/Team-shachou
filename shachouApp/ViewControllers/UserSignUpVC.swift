import UIKit
import SnapKit
import Material

final class UserSignUpVC: UIViewController {
    
    let WelcomeView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "welcomeVC")
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "購入者として登録"
        label.textAlignment = .center
        label.textColor = .white
        label.font = .systemFont(ofSize: 25)
        return label
    }()
    
    let mailField: TextField = {
        let text = TextField(frame: .zero)
        text.placeholder = "登録メールアドレス"
        text.placeholderActiveColor = UIColor.white
        text.textAlignment = .center
        text.backgroundColor = UIColor.white
        text.dividerColor = UIColor.white
        text.dividerActiveColor = UIColor.white
        text.keyboardType = .emailAddress
        text.autocapitalizationType = .none
        return text
    }()
    
    let passwordField: TextField = {
        let text = TextField(frame: .zero)
        text.placeholder = "パスワード(8文字以上)"
        text.placeholderActiveColor = UIColor.white
        text.textAlignment = .center
        text.backgroundColor = UIColor.white
        text.dividerColor = UIColor.white
        text.dividerActiveColor = UIColor.white
        text.isSecureTextEntry = true
        return text
    }()
    
    let button1: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.brown
        button.setTitle("登録", for: [])
        button.layer.borderWidth = 0.1
        button.layer.cornerRadius = 25
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: UIFont.Weight(rawValue: 1))
        button.addTarget(self, action: #selector(screen1), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.addSubview(WelcomeView)
        self.view.addSubview(label)
        self.view.addSubview(mailField)
        self.view.addSubview(passwordField)
        self.view.addSubview(button1)
        
        
        self.view.backgroundColor = UIColor.white
        
        
        WelcomeView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        label.snp.makeConstraints {
            $0.top.equalToSuperview().inset(100)
            $0.centerX.equalToSuperview()
        }
        
        mailField.snp.makeConstraints {
            $0.top.equalTo(label.snp.bottom).offset(60)
            $0.left.right.equalToSuperview().inset(33)
            $0.height.equalTo(40)
        }
        
        passwordField.snp.makeConstraints {
            $0.top.equalTo(mailField.snp.bottom).offset(40)
            $0.left.right.equalTo(mailField)
            $0.height.equalTo(40)
        }
        
        
        button1.snp.makeConstraints{
            $0.height.equalTo(50)
            $0.width.equalTo(280)
            $0.bottom.equalToSuperview().offset(-30)
            $0.centerX.equalToSuperview()
        }
    }
    
    @objc func screen1() {// selectorで呼び出す場合Swift4からは「@objc」をつける。
        let nextVC = TopVC()
        let naviVC = UINavigationController(rootViewController: nextVC)
        nextVC.view.backgroundColor = UIColor.white
        self.present(naviVC, animated: true, completion: nil)
    }
 
    override func didReceiveMemoryWarning(){
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can berecreated.
    }
}

