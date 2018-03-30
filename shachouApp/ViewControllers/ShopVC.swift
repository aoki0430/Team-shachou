import UIKit
import SnapKit
import ZoomTransitioning

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
    
//    let coverView : UIView = {
//        let view = UIView()
//        view.backgroundColor = .brown
//
//        return view
//    }()
    
//    let scrollView: UIScrollView = {
//        let scrollView = UIScrollView()
//        scrollView.backgroundColor = .brown
//        return scrollView
//    }()
    
    var ImageView: UIImageView = {
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
        view.shadowColor = .black
        view.layer.shadowRadius = 4
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
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
        let size = (UIScreen.main.bounds.size.width / 2) - 20
        layout.itemSize = CGSize(width: size ,height: 150)
        let margin: CGFloat = 3.0
        layout.minimumLineSpacing = margin
        layout.minimumInteritemSpacing = margin / 2
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
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imageCollectionView.delegate = self
        self.imageCollectionView.dataSource = self
        self.imageCollectionView.register(PhotoCell.self, forCellWithReuseIdentifier: "PhotoCell")
        self.imageCollectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header")
        
        self.fetchShop()
//        self.view.addSubview(scrollView)
//        self.scrollView.addSubview(coverView)
        self.view.addSubview(ImageView)
//        self.coverView.addSubview(mainInfoView)
//        self.coverView.addSubview(self.collectionBackgroungView)
//        self.collectionBackgroungView.addSubview(self.imageCollectionView)
//        self.coverView.addSubview(imageCollectionView)
        self.view.addSubview(imageCollectionView)
        self.view.addSubview(mainInfoView)
        self.mainInfoView.addSubview(ShopNameLabel)
        self.mainInfoView.addSubview(ShopCallLabel)
        self.mainInfoView.addSubview(ShopAccessLabel)
        self.mainInfoView.addSubview(ShopInfoLabel)
        self.title = self.model.shop.shopname //JSON形式でお店の名前欲しい
        
//        scrollView.snp.makeConstraints {
//            $0.width.equalToSuperview()
//            $0.top.equalToSuperview()
//            $0.left.right.bottom.equalToSuperview()
//        }
        
//        coverView.snp.makeConstraints {
//            $0.edges.equalToSuperview()
//            $0.width.equalToSuperview()
//            $0.height.equalTo(1000)
//        }
        
        ImageView.snp.makeConstraints{
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(300)
        }
        
        mainInfoView.snp.makeConstraints {
            $0.top.equalTo(ImageView.snp.bottom).offset(15)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(80)
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
//            $0.height.equalTo(15)
        }
        
//        collectionBackgroungView.snp.remakeConstraints {
//            $0.top.equalTo(mainInfoView.snp.bottom).offset(10)
//            $0.left.right.equalToSuperview().inset(16)
////            $0.height.equalTo(130)
//        }
        
        imageCollectionView.snp.makeConstraints {
            $0.top.equalTo(ShopInfoLabel.snp.bottom).offset(25)
            $0.left.right.equalToSuperview().inset(10)
//            $0.left.equalTo(ShopInfoLabel.snp.left)
//            $0.right.equalTo(ShopInfoLabel.snp.right)
//            $0.height.equalTo(150 * model.items.count / 2)
            $0.bottom.equalToSuperview()
        }

    }
    
//    override func viewDidLayoutSubviews() {
//        imageCollectionView.snp.remakeConstraints {
//            $0.top.equalTo(mainInfoView.snp.bottom).offset(20)
//            $0.height.equalTo(imageCollectionView.contentSize)
//        }
//            tableHeight.constant = tableView.contentSize.height
//        imageCollectionView.contentSize = CGSize(width: scrollView.frame.width, height: )
//        let height = ImageView.frame.height + mainInfoView.frame.height + imageCollectionView.frame.height + 200
//        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: height)
        
//    }
    
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
        
        ImageView = cell.imageView
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

extension ShopVC: ZoomTransitionSourceDelegate {
    
    // アニメーション対象のUIImageViewを返す
    func transitionSourceImageView() -> UIImageView {
        return ImageView
    }
    
    // スクリーンに対するアニメーション開始位置を返す
    func transitionSourceImageViewFrame(forward: Bool) -> CGRect {
//        guard let selectedImageView = selectedImageView else { return CGRect.zero }
        return ImageView.convert(ImageView.bounds, to: view)
    }
    
    // 画面遷移直前
    func transitionSourceWillBegin() {
        ImageView.isHidden = true
    }
    
    // 画面遷移完了後
    func transitionSourceDidEnd() {
        ImageView.isHidden = false
    }
    
    // 画面遷移キャンセル後
    func transitionSourceDidCancel() {
        ImageView.isHidden = false
    }
}
