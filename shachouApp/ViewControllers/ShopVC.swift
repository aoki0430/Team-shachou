import UIKit
import ImageViewer

class ShopVC: UIViewController {
    let model : ShopModel
    
    var images:[UIImage] = []
    var numOfItem: Int {
        return model.items.count
    }
    
    init(shopID: Int) {
        model = ShopModel(shopID)
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .brown
        return scrollView
    }()
    
    let ImageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 4
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let collectionBackgroungView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 4
        view.backgroundColor = .white
        //以下影（shadow）
        view.shadowColor = .black
        view.layer.shadowRadius = 4
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        return view
    }()
    
    let imageCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let size = (UIScreen.main.bounds.size.width / 2) - 5
        layout.itemSize = CGSize(width:size ,height: 200)
        let margin: CGFloat = 3.0
        layout.minimumLineSpacing = margin
        layout.minimumInteritemSpacing = margin
        layout.sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
//        frame : .zero
        //以下影（shadow）
        collectionView.shadowColor = .black
        collectionView.layer.shadowRadius = 4
        collectionView.layer.shadowOpacity = 0.1
        collectionView.layer.shadowOffset = CGSize(width: 0, height: 3)

        return collectionView
    }()
    
    let ShopNameLabel: UILabel = {
        let label = UILabel()
        //        label.text = "お店１"
        label.textAlignment = .center
        label.layer.cornerRadius = 4
        label.backgroundColor = UIColor.white
        return label
    }()
    
    let InfoView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 2
        view.backgroundColor = .white
        //以下影（shadow）
        view.shadowColor = .black
        view.layer.shadowRadius = 2
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        return view
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
        
        self.imageCollectionView.delegate = self
        self.imageCollectionView.dataSource = self
        self.imageCollectionView.register(PhotoCell.self, forCellWithReuseIdentifier: "PhotoCell")
        
         self.fetchShop()
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(ImageView)
        self.scrollView.addSubview(self.collectionBackgroungView)
        self.scrollView.addSubview(self.InfoView)
        self.collectionBackgroungView.addSubview(self.imageCollectionView)
        self.InfoView.addSubview(ShopNameLabel)
        self.InfoView.addSubview(ShopCallLabel)
        self.InfoView.addSubview(ShopAccessLabel)
        self.InfoView.addSubview(ShopInfoLabel)
        self.title = self.model.shop.shopname //JSON形式でお店の名前欲しい
        scrollView.snp.makeConstraints {
            
            $0.width.equalToSuperview()
            
            let statusBarHeight = UIApplication.shared.statusBarFrame.size.height
            $0.top.equalToSuperview().inset(-(statusBarHeight + 44))
            $0.left.right.bottom.equalToSuperview()
        }
        
        
        ImageView.snp.makeConstraints{
            $0.width.equalToSuperview()
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(150)
        }
        
        collectionBackgroungView.snp.remakeConstraints {
            $0.top.equalTo(self.ImageView.snp.bottom).offset(10)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(130)
        }
        
        imageCollectionView.snp.makeConstraints {
            $0.right.equalToSuperview()
            $0.top.bottom.equalToSuperview()
            $0.left.equalToSuperview().inset(22)
        }
        
        InfoView.snp.makeConstraints {
            $0.top.equalTo(collectionBackgroungView.snp.bottom).offset(-20)
            $0.left.right.equalToSuperview().inset(16)
        }
        
        ShopNameLabel.snp.makeConstraints{
            $0.height.equalTo(70)
            $0.width.equalToSuperview()
            $0.top.equalTo(imageCollectionView.snp.bottom).offset(2)
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
            $0.left.right.equalToSuperview()
            $0.height.equalTo(50)
            $0.top.equalTo(ShopAccessLabel.snp.bottom).offset(2)
        }
        
        
    }
    
    func itemVC(index: Int) -> ItemVC {
        let itemVC = ItemVC(itemID: self.model.items[index].id)
        return itemVC
    }
    
    func fetchShop() {
        self.model.fetchShop {
            let url = URL(string: self.model.shop.image)
            self.ImageView.kf.setImage(with: url)
            self.ShopNameLabel.text = self.model.shop.shopname
            self.ShopInfoLabel.text = self.model.shop.text
            self.ShopAccessLabel.text = self.model.shop.addr
            self.ShopCallLabel.text = self.model.shop.tel
            self.imageCollectionView.reloadData()
        }
        
        self.model.getAllItem {
            self.imageCollectionView.reloadData()
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension ShopVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numOfItem
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        // 写真
            // UIImageに変換する
        cell.configure(self.model.items[indexPath.row]) { image in
            if let image = image {
                self.model.items[indexPath.row].image = image
            }
        }
        return cell
    }
}


extension ShopVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nextVC = self.itemVC(index: indexPath.row)
        let naviVC = UINavigationController(rootViewController: nextVC)
        nextVC.view.backgroundColor = UIColor.gray
        present(naviVC, animated: true, completion: nil)
//        self.navigationController?.pushViewController(naviVC, animated: true)
    }
}


