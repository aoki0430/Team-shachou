
import UIKit
import SwiftyUserDefaults

class ItemVC: UIViewController {
    let model : ItemModel
    
    init(itemID: Int) {
        model = ItemModel(itemID)
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = UIColor(red: 0.2, green: 0.047, blue: 0, alpha: 1.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let batsuView = UIImageView()
    
    let batsubtn: UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(batsudid), for: .touchUpInside)
        btn.layer.cornerRadius = 4
        return btn
    }()
    
    let ImageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 4
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let ItemNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.layer.cornerRadius = 4
        label.backgroundColor = UIColor.white
        return label
    }()
    
    let SizeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.layer.cornerRadius = 4
        label.backgroundColor = UIColor.white
        return label
    }()
    
    let ItemTextLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.layer.cornerRadius = 4
        label.backgroundColor = UIColor.white
        return label
    }()
    
    let ShopInfoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.layer.cornerRadius = 4
        label.backgroundColor = UIColor.white
        return label
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        batsuView.image = UIImage(named: "batsu")
        self.view.backgroundColor = UIColor(red: 0.2, green: 0.047, blue: 0, alpha: 1.0)
        self.fetchItem()
        self.view.addSubview(batsuView)
        self.batsuView.addSubview(batsubtn)
        self.view.addSubview(ImageView)
        self.view.addSubview(ItemNameLabel)
        self.view.addSubview(SizeLabel)
        self.view.addSubview(ItemTextLabel)
//        if Defaults[.isShopAccount] 
        self.navigationItem.title = self.model.item.itemname

        
        batsuView.snp.makeConstraints {
            $0.size.equalTo(40)
            $0.left.equalToSuperview().inset(30)
            $0.top.equalToSuperview().inset(40)
        }
        
        batsubtn.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        ImageView.snp.makeConstraints{
            $0.height.equalTo(250)
            $0.width.equalTo(200)
            $0.top.equalToSuperview().offset(65)
            $0.centerX.equalToSuperview()
        }
        
        ItemNameLabel.snp.makeConstraints{
            $0.height.equalTo(70)
            $0.left.right.equalToSuperview().inset(5)
            $0.top.equalTo(ImageView.snp.bottom).offset(5)
        }
        
        SizeLabel.snp.makeConstraints{
            $0.height.equalTo(70)
            $0.left.right.equalToSuperview().inset(5)
            $0.top.equalTo(ItemNameLabel.snp.bottom).offset(5)
        }
        
        ItemTextLabel.snp.makeConstraints{
            $0.left.right.equalToSuperview().inset(5)
            $0.top.equalTo(SizeLabel.snp.bottom).offset(5)
        }
        
    }
    
    @objc func batsudid() {
//        let nextVC = ShopVC(shopID: Defaults[.shopid])
//        let naviVC = UINavigationController(rootViewController: nextVC)
//        self.present(naviVC, animated: true, completion: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
    func fetchItem() {
        self.model.fetchItem {
            let url = URL(string: self.model.item.image)
            self.ImageView.kf.setImage(with: url)
            self.ItemNameLabel.text = self.model.item.itemname
            self.ItemTextLabel.text = self.model.item.itemtext
            self.SizeLabel.text = self.model.item.size
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
