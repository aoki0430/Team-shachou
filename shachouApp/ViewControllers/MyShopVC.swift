
import UIKit
import SnapKit
import SwiftyUserDefaults

final class MyShopVC: UIViewController {
    let model : ShopModel
    
    var numOfItem: Int {
        return model.items.count
    }
    
    init(shopID: Int) {
        model = ShopModel(shopID)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let imageCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let margin: CGFloat = 5.0
        let size = (UIScreen.main.bounds.size.width - (4 * margin)) / 2
        layout.itemSize = CGSize(width: size ,height: 200)
        layout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: 500)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imageCollectionView.backgroundColor = .black
        self.imageCollectionView.delegate = self
        self.imageCollectionView.dataSource = self
        self.imageCollectionView.register(PhotoCell.self, forCellWithReuseIdentifier: "PhotoCell")
        self.imageCollectionView.register(Header.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "Header")
        
        self.fetchShop()
        self.view.addSubview(imageCollectionView)
        self.navigationItem.title = self.model.shop.shopname
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "編集！", style: .plain, target: self, action: #selector(screen1))
        
        imageCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }
    
    func itemVC(index: Int) -> ItemVC {
        let itemVC = ItemVC(itemID: self.model.items[index].id)
        return itemVC
    }
    
    func fetchShop() {
        self.model.getAllItem {
            self.imageCollectionView.reloadData()
        }
        
    }
    
    @objc func screen1() {// selectorで呼び出す場合Swift4からは「@objc」をつける。
        self.present(MyShopEditVC(shopID: Defaults[.shopid]), animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension MyShopVC: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
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
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath) as! Header
        self.model.fetchShop {
            let url = URL(string: self.model.shop.image)
            header.ImageView.kf.setImage(with: url)
            header.ShopNameLabel.text = self.model.shop.shopname
            header.ShopInfoLabel.text = self.model.shop.text
            header.ShopAccessLabel.text = self.model.shop.addr
            header.ShopCallLabel.text = self.model.shop.tel
        }
        return header
    }
    
}

extension MyShopVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(itemVC(index: indexPath.row), animated: true)
    }
}

