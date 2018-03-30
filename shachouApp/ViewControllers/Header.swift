import UIKit
import SnapKit

final class Header: UICollectionReusableView {
    
    let ImageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 4
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let mainInfoView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 4
        view.backgroundColor = .white
        //以下影（shadow）
        view.shadowColor = .brown
        view.layer.shadowRadius = 4
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        return view
    }()
    
    let ShopNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.layer.cornerRadius = 4
        label.backgroundColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    let ShopCallLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .center
        label.layer.cornerRadius = 4
        label.backgroundColor = UIColor.white
        return label
    }()
    
    let ShopAccessLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .center
        label.layer.cornerRadius = 4
        label.backgroundColor = UIColor.white
        return label
    }()
    
    let ShopInfoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .center
        label.layer.cornerRadius = 4
        label.backgroundColor = UIColor.white
        label.sizeToFit()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addSubviews()
        makeconstrains()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        self.addSubview(ImageView)
        self.addSubview(mainInfoView)
        self.backgroundColor = UIColor(red: 0.2, green: 0.047, blue: 0, alpha: 1.0)
        mainInfoView.addSubview(ShopNameLabel)
        mainInfoView.addSubview(ShopCallLabel)
        mainInfoView.addSubview(ShopAccessLabel)
        mainInfoView.addSubview(ShopInfoLabel)
    }
    
    func makeconstrains() {
        ImageView.snp.makeConstraints{
            
            $0.top.equalToSuperview().offset(5)
            $0.left.right.equalToSuperview().inset(5)
//            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(300)
        }
        
        mainInfoView.snp.makeConstraints {
            $0.top.equalTo(ImageView.snp.bottom).offset(5)
            $0.left.right.equalToSuperview().inset(5)
        }
        
        ShopNameLabel.snp.makeConstraints{
            $0.width.equalToSuperview()
            $0.left.right.equalToSuperview()
            $0.top.equalToSuperview().inset(10)
            $0.height.equalTo(20)
        }
        
        ShopCallLabel.snp.makeConstraints{
            $0.width.equalToSuperview()
            $0.top.equalTo(ShopNameLabel.snp.bottom).offset
            $0.left.right.equalToSuperview()
            $0.height.equalTo(15)
        }
        
        ShopAccessLabel.snp.makeConstraints{
            $0.width.equalToSuperview()
            $0.top.equalTo(ShopCallLabel.snp.bottom).offset
            $0.left.right.equalToSuperview()
            $0.height.equalTo(15)
        }
        
        ShopInfoLabel.snp.makeConstraints{
            $0.left.right.equalToSuperview()
            $0.top.equalTo(ShopAccessLabel.snp.bottom).offset
        }
    }
    
}

