import UIKit
import SnapKit

class ShopVC: UIViewController {
    let model : ShopModel
    
    init(shopID: Int) {
        model = ShopModel(shopID)
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let ImageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 4
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let ShopNameLabel: UILabel = {
        let label = UILabel()
        //        label.text = "お店１"
        label.textAlignment = .center
        label.layer.cornerRadius = 4
        label.backgroundColor = UIColor.white
        return label
    }()
    
    let ShopCallLabel: UILabel = {
        let label = UILabel()
        //        label.text = "電話:0120-117-117"
        label.textAlignment = .center
        label.layer.cornerRadius = 4
        label.backgroundColor = UIColor.white
        return label
    }()
    
    let ShopAccessLabel: UILabel = {
        let label = UILabel()
        //        label.text = "住所:東京都調布市調布ヶ丘１"
        label.textAlignment = .center
        label.layer.cornerRadius = 4
        label.backgroundColor = UIColor.white
        return label
    }()
    
    let ShopInfoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        //        label.text = "詳細:チェックシャツの\n洋服をたくさん売っているお店です"
        label.textAlignment = .center
        label.layer.cornerRadius = 4
        label.backgroundColor = UIColor.white
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchShop()
        self.view.addSubview(ImageView)
        self.view.addSubview(ShopNameLabel)
        self.view.addSubview(ShopCallLabel)
        self.view.addSubview(ShopAccessLabel)
        self.view.addSubview(ShopInfoLabel)
        self.navigationItem.title = self.model.shop.shopname //JSON形式でお店の名前欲しい
        
        ImageView.snp.makeConstraints{
            $0.height.equalTo(300)
            $0.width.equalToSuperview()
            $0.top.equalToSuperview().offset(65)
        }
        
        ShopNameLabel.snp.makeConstraints{
            $0.height.equalTo(70)
            $0.width.equalToSuperview()
            $0.top.equalTo(ImageView.snp.bottom).offset(2)
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
        
    }
    
    func fetchShop() {
        self.model.fetchShop {
            let url = URL(string: self.model.shop.image)
            self.ImageView.kf.setImage(with: url)
            self.ShopNameLabel.text = self.model.shop.shopname
            self.ShopInfoLabel.text = self.model.shop.text
            self.ShopAccessLabel.text = self.model.shop.addr
            self.ShopCallLabel.text = self.model.shop.tel
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

