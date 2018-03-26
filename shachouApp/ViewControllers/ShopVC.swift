import UIKit
import ImageViewer

class ShopVC: UIViewController {
    let model : ShopModel
    
    var images:[UIImage] = []
    
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
    
    let imageCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let size = UIScreen.main.bounds.size.width / 3 - 1
        layout.itemSize = CGSize(width: size,height: size+22)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        
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
        self.imageCollectionView.delegate = self
        self.imageCollectionView.dataSource = self
        self.imageCollectionView.register(PhotoCell.self, forCellWithReuseIdentifier: "PhotoCell")
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(ImageView)
        self.scrollView.addSubview(ShopNameLabel)
        self.scrollView.addSubview(ShopCallLabel)
//        self.view.addSubview(ShopAccessLabel)
//        self.view.addSubview(ShopInfoLabel)
        self.scrollView.addSubview(imageCollectionView)
        self.navigationItem.title = self.model.shop.shopname //JSON形式でお店の名前欲しい
        self.model.getAllItem {
            self.imageCollectionView.reloadData()
        }
        
        scrollView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.top.equalToSuperview()
            $0.left.right.bottom.equalToSuperview()
        }
        
        ImageView.snp.makeConstraints{
            $0.height.equalTo(300)
            $0.width.equalToSuperview()
            $0.top.equalToSuperview().offset(65)
        }
        
        imageCollectionView.snp.makeConstraints {
            $0.right.equalToSuperview()
            $0.top.equalTo(ImageView.snp.bottom).offset(30)
            $0.left.equalToSuperview().inset(22)
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
        
//        ShopAccessLabel.snp.makeConstraints{
//            $0.height.equalTo(70)
//            $0.width.equalToSuperview()
//            $0.top.equalTo(ShopCallLabel.snp.bottom).offset(2)
//        }
//
//        ShopInfoLabel.snp.makeConstraints{
//            $0.bottom.equalToSuperview().offset(2)
//            $0.width.equalToSuperview()
//            $0.top.equalTo(ShopAccessLabel.snp.bottom).offset(2)
//        }
        
        
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
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension ShopVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count+1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        
//        switch indexPath.row {
//        case images.count: // カメラボタン
//            let image = UIImage(named: "camera")
//            let tintedImage = image?.withRenderingMode(.alwaysTemplate)
//            cell.configure(image: tintedImage!)
//            cell.remakeCametaAlbumDesign()
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
        self.navigationController?.pushViewController(naviVC, animated: true)
    }
}


