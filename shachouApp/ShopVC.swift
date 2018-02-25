import UIKit
import SnapKit
import Kingfisher
import Photos
import DKImagePickerController
import GrowingTextView
import SwiftyUserDefaults

final class ShopVC: UIViewController {

    var images:[UIImage] = []
    
    /* View */
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .red
        return scrollView
    }()
    
    let headerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "defaultImage2")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    // ここからmainInfoViewとそのsubViews
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
    
    let shopNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HiraginoSans-W6", size: 14)
        label.textAlignment = .center
        return label
    }()
    
    //TODO: リファクタリング
    let horizontalLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 195/255, alpha: 1.0)
        return view
    }()
    
    let accessIconImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "station"))
        imageView.tintColor = .red
        return imageView
    }()
    
    let accessLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HiraginoSans-W3", size: 10)
        return label
    }()
    
    let genreIconImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "restaurant"))
        imageView.tintColor = .red
        return imageView
    }()
    
    let genreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HiraginoSans-W3", size: 10)
        return label
    }()
    
    // TODO: ボタンのサイズ調整
    // TODO: ShopVCとほぼ共通なのでリファクタリング？
    let callBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.white
        btn.layer.cornerRadius = 5.0
        btn.layer.borderColor = UIColor.red.cgColor
        btn.layer.borderWidth = 2.0
        
        let iv = UIImageView()
        iv.image = UIImage(named: "phone")
        iv.tintColor = .red
        
        let label = UILabel()
        label.text = "お店に電話する"
        label.textColor = .red
        label.font = UIFont(name: "HiraginoSans-W6", size: 14)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        
        btn.addSubview(iv)
        btn.addSubview(label)
        
        iv.snp.makeConstraints {
          
            $0.size.equalTo(26)
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().inset(16)
        }
        
        label.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalTo(iv.snp.right).offset(15)
        }
        
        btn.addTarget(self, action: #selector(callBtnDidTap), for: .touchUpInside)
        
        return btn
    }()
    
    let shareBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.white
        btn.layer.cornerRadius = 5.0
        btn.layer.borderColor = UIColor.red.cgColor
        btn.layer.borderWidth = 2.0
        
        let iv = UIImageView()
        iv.image = UIImage(named: "share")
        iv.tintColor = UIColor.red
        
        let label = UILabel()
        label.text = "シェア"
        label.textColor = UIColor.red
        label.font = UIFont(name: "HiraginoSans-W6", size: 14)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        
        btn.addSubview(iv)
        btn.addSubview(label)
        
        iv.snp.makeConstraints {
            $0.size.equalTo(20)
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().inset(16)
        }
        
        label.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalTo(iv.snp.right).offset(10)
            $0.right.equalToSuperview().inset(16)
        }
        
        //TODO: シェアアクションを追加
        btn.addTarget(self, action: #selector(shareDidTap), for: .touchUpInside)
        
        return btn
    }()
    
    // めも欄
    let commentView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 4
        view.backgroundColor = .white
        //以下影（shadow）
        view.layer.shadowRadius = 4
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        return view
    }()
    
    private lazy var commentTextView: GrowingTextView = {
        let textView = GrowingTextView()
        textView.font = UIFont(name: "HiraginoSans-W3", size: 16)
        textView.isUserInteractionEnabled = true
        // 長押しで選択できるようにする
        textView.isEditable = false
        
        // タップでコメントを入力する画面に飛ぶ
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(commentTextViewDidTap(_:)))
        textView.addGestureRecognizer(tapRecognizer)
        
        // プレースホルダー
        let attr = [NSAttributedStringKey.foregroundColor : UIColor.red, //色を決める
            NSAttributedStringKey.font: UIFont(name: "HiraginoSans-W3", size: 16) //ここでフォント・サイズを決める
        ]
        textView.attributedPlaceHolder = NSAttributedString(string: "メモを書く", attributes: attr as Any as? [NSAttributedStringKey : Any])
        return textView
    }()
    
    let colectionBackgroungView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 4
        view.backgroundColor = .white
        //以下影（shadow）
        view.layer.shadowRadius = 4
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        return view
    }()
    
    // 写真表示用のView
    let imageCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let size = UIScreen.main.bounds.size.width / 3 - 1
        layout.itemSize = CGSize(width: size,height: size+22)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        
        //以下影（shadow）
        collectionView.layer.shadowRadius = 4
        collectionView.layer.shadowOpacity = 0.1
        collectionView.layer.shadowOffset = CGSize(width: 0, height: 3)
        
        return collectionView
    }()
    
    // ここからlocationInfoViewとそのsubViews
    let locationInfoView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 2
        view.backgroundColor = .white
        //以下影（shadow）
        view.layer.shadowRadius = 2
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        return view
    }()
    
    let locationTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HiraginoSans-W6", size: 12)
        label.textColor = UIColor(red: 158/255, green: 158/255, blue: 162/255, alpha: 1.0)
        label.text = "お店の位置情報"
        return label
    }()
    
    
    // mapに重ねる透明ボタン
    let mapBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(), for: .normal)
        btn.addTarget(self, action: #selector(mapViewDidTap), for: .touchUpInside)
        return btn
    }()
    
//    let addressView = InfoDetailView(title: "住所", content: "", showUnderLine: true)
    
    // 住所をコピーするボタン
//    let copyAddressBtn: UIButton = {
//        let btn = UIButton()
//        btn.backgroundColor = UIColor.clear
//        btn.layer.cornerRadius = 5
//        btn.addTarget(self, action: #selector(copyAddressBtnDidTap), for: .touchUpInside)
//        return btn
//    }()
    
//    let accessView = InfoDetailView(title: "アクセス", content: "", showUnderLine: false)
    
    // ここからdetailInfoViewとそのsubViews
    let detailInfoView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 2
        view.backgroundColor = .white
        //以下影（shadow）
        view.layer.shadowRadius = 2
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        return view
    }()
    
    let detailTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HiraginoSans-W6", size: 12)
        label.textColor = UIColor(red: 158/255, green: 158/255, blue: 162/255, alpha: 1.0)
        label.text = "お店の詳細情報"
        return label
    }()
    
//    let priceView = InfoDetailView(title: "価格", content: "", showUnderLine: true)
//
//    let hoursView = InfoDetailView(title: "営業時間", content: "", showUnderLine: true)
//
//    let phoneView = InfoDetailView(title: "電話番号", content: "", showUnderLine: true)
//
    // 電話番号の横に置くCallボタン
//    let phoneViewBtn: UIButton = {
//        let btn = UIButton()
//        btn.backgroundColor = UIColor.clear
//        btn.layer.cornerRadius = 5
//
//        let iv = UIImageView()
//        iv.image = UIImage(named: "phone")
//        iv.tintColor = .red
//
//        btn.addSubview(iv)
//
//        iv.snp.makeConstraints {
//            $0.centerY.equalToSuperview()
//            $0.size.equalTo(18)
//            $0.left.equalToSuperview().inset(16)
//        }
//
//        //TODO: 画像を差し替えた後、削除して表示
//        iv.isHidden = true
//
//        btn.addTarget(self, action: #selector(callBtnDidTap), for: .touchUpInside)
//
//        return btn
//    }()
    
//    let holidayView = InfoDetailView(title: "定休日", content: "", showUnderLine: true)
    
//    let seatsView = InfoDetailView(title: "席数", content: "", showUnderLine: false)
    
    // 一旦非表示
    //    let shopHPBtn: UIButton = {
    //        let btn = UIButton()
    //        btn.setTitle("お店のHPへ", for: .normal)
    //        btn.setTitleColor(UIColor.app.grpDeepOrange, for: .normal)
    //        btn.backgroundColor = .clear
    //        btn.titleLabel?.font = UIFont(name: "HiraginoSans-W3", size: 12)
    //        btn.addTarget(self, action: #selector(shopHPBtnDidTap), for: .touchUpInside)
    //        return btn
    //    }()
    
    let editButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .red
        btn.layer.cornerRadius = 5.0
        btn.layer.borderColor = UIColor.red.cgColor
        btn.layer.borderWidth = 2.0
        btn.setTitle("メモの追加・編集", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont(name: "HiraginoSans-W3", size: 12)
        btn.setTitleColor(.red, for: .normal)
        btn.layer.cornerRadius = 5
        btn.addTarget(self, action: #selector(editDidTap), for: .touchUpInside)
        return btn
    }()
    
    // フッター
    let footerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.isHidden = true //フィジビリで非表示
        return view
    }()
    
    let checkInBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("チェックイン", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .red
        btn.titleLabel?.font = UIFont(name: "HiraginoSans-W6", size: 14)
        btn.layer.cornerRadius = 5
        return btn
    }()
    
    //ナビゲーションバーの背景
    let navigationBarBGView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    //ナビゲーションバーが透明のときの、戻るボタンのまるい背景
    let backButtonBGView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.2)
        view.layer.cornerRadius = 18
        return view
    }()
    
    // 独自戻るボタン
    private lazy var backButtonItem: UIBarButtonItem = {
        let barItem = UIBarButtonItem(image: #imageLiteral(resourceName: "back-icon"), style: .plain, target: self, action: #selector(backButtonDidTap))
        return barItem
    }()
    
    let naviBarShareButtonBGView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.2)
        view.layer.cornerRadius = 18
        return view
    }()
    
    private lazy var naviBarShareButtonItem: UIBarButtonItem = {
        let barItem = UIBarButtonItem(image: #imageLiteral(resourceName: "share"), style: .plain, target: self, action: #selector(shareDidTap))
        barItem.tintColor = .white
        return barItem
    }()
    
    init(shopID: Int, _ checkInID: Int, _ listID: Int, completion: @escaping (_ needReload: Bool) -> Void) {
//        model = ShopModel(shopID, checkInID, listID)
//        self.completion = completion
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = .white
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
        UIApplication.shared.statusBarStyle = .default //ステータスバーの色は黒
    }
    
    @objc func didSwipe(sender: UISwipeGestureRecognizer) {
        self.navigationController?.popViewController(animated: true)
    }
    
    /* ライフサイクル */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ショップ情報をfetch
        self.fetchShop()
        
//        self.scrollView.delegate = self
        
        // photo
//        self.imageCollectionView.delegate = self
        self.imageCollectionView.dataSource = self
        self.imageCollectionView.register(CheckInPhotoCell.self, forCellWithReuseIdentifier: "CheckInPhotoCell")
        
        // Viewを設定する
        self.addSubviews()
        self.makeConstraints()
        
        // フィジビリで非表示
        //        //fooretViewの上枠線を作成
        //        let topBorder = CALayer()
        //        topBorder.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 0.5)
        //        topBorder.backgroundColor = UIColor.lightGray.cgColor
        //        footerView.layer.addSublayer(topBorder)
        
        // スクリーンショット
        NotificationCenter.default.addObserver(self, selector: #selector(screenshotDidShot), name: .UIApplicationUserDidTakeScreenshot, object: nil)
        
        //遷移先のbackBtnの文字を消す
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        //スワイプでListVCに戻る
        let rightSwipe = UISwipeGestureRecognizer(target: self, action:#selector(didSwipe))
        rightSwipe.direction = .right
        view.addGestureRecognizer(rightSwipe)
        
        // 戻るボタンの位置を調整する
        self.navigationItem.leftBarButtonItems = [self.backButtonItem]
        
        // シェアボタンを配置
        self.navigationItem.rightBarButtonItem = self.naviBarShareButtonItem
    }
    
    override func viewWillAppear(_: Bool) {
        
        // ナビゲーションバー
        changeNavigationBarColor()
        
        if self.scrollView.contentOffset.y <= UIScreen.main.bounds.size.width * 0.56 - 130 {
            //TODO: changeNavigationbarColor()で同じ処理しているがなぜか文字が残ってしまう
            //↓ 再現動画
            // https://github.com/NiCOLA-inc/gurupoke-iOS/issues/1505
            // MapDetailVCから戻ってきた時にタイトルが残ってしまうのを防止
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.clear] //タイトル文字色
            
        }
        
//        switch model.editType {
//        case ShopModel.EditType.deleted:
//            navigationController?.popViewController(animated: true)
//            completion!(true)
//            break
//        case ShopModel.EditType.edited:
//            fetchShop()
//            completion!(true)
//            break
//        default:
//            break
//        }

        // CheckInVCから戻ってきた時に、押せるようにする
        self.checkInBtn.isEnabled = true
        self.editButton.isEnabled = true
        
        // listEmptyViewからどうかで条件分岐
        if self.listID != 0 {
            self.changeSaveMode()
        } else {
            self.checkInBtn.addTarget(self, action: #selector(self.checkInDidTap), for: .touchUpInside)
        }
        
        // タブバーを非表示にする
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @objc private func backButtonDidTap() {
        self.navigationController?.popViewController(animated: true)
    }
    
//    @objc private func commentTextViewDidTap(_ sender: UITapGestureRecognizer) {
//        let navigationController = UINavigationController(rootViewController: InputShopCommentVC(model: self.model))
//        self.present(navigationController, animated: true, completion: nil)
//    }
    
//    @objc private func copyAddressBtnDidTap() {
//        // 連続タップ防止
//        self.copyAddressBtn.isEnabled = false
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3.8) {
//            self.copyAddressBtn.isEnabled = true
//        }
//        let board = UIPasteboard.general
//        board.string = self.addressView.contentLabel.text!
//        let pop = NotificationPopView()
//        pop.show(text: "住所をコピーしました")
//    }
    
//    @objc private func callBtnDidTap(){
//        // 二重タップを禁止する
//        self.callBtn.isEnabled = false
//        if number == "不明" || number == "" {
//            Alert.show(message: "電話番号が見つかりません")
//        } else {
//            let url = NSURL(string: "telprompt://" + number)!
//            if #available(iOS 10.0, *) {
//                UIApplication.shared.open(url as URL)
//            } else {
//                UIApplication.shared.openURL(url as URL)
//            }
//        }
//        // 1秒後タップできるようにする
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) {
//            self.callBtn.isEnabled = true
//        }
//    }
    
//    @objc func checkInDidTap() {
//        // 二重タップを禁止する
//        self.checkInBtn.isEnabled = false
//        if Defaults[.isGuest] {
//            let guestWelcomeVC = GuestWelcomeVC()
//            self.present(guestWelcomeVC, animated: true, completion: nil)
//            self.checkInBtn.isEnabled = true
//        } else {
//
//            // 距離を計算し、500m以内であればチェックイン
//            let location = CLLocation(latitude: self.model.shop.latitude, longitude: self.model.shop.longitude)
//            let distance = Location.shared.distanceFromCurrentLocation(to: location)
//
//            if distance > 500 {
//                Alert.show(title: "チェックインするには\n来店する必要があります。", message:"お店の近くにいますか？")
//                self.checkInBtn.isEnabled = true
//                return
//            }
//
//            if let completion = pinCompletion {
//
//                let checkInModel = CheckInModel()
//                checkInModel.fetchLists { [weak self] in
//
//                    let vc = CheckInVC(id: (self?.model.shop.id)!, visitedCount: (self?.model.shop.visitedCount)!, completion: completion)
//                    vc.model = checkInModel
//                    vc.model.selectedShop = (self?.model.shop)!
//                    vc.isFromShopVC = true
//                    //                vc.shareLink = self?.model.shop.shopURL
//                    self?.navigationController?.pushViewController(vc, animated: true)
//                }
//            }
//        }
//
//    }
    
//    @objc func screenshotDidShot() {
//        scrPop.btn.addTarget(self, action: #selector(scrShareDidTap), for: .touchUpInside)
//
//        //画像を取得
//        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0.0)
//        let context = UIGraphicsGetCurrentContext()!
//        view.layer.render(in: context)
//        let capturedImage = UIGraphicsGetImageFromCurrentImageContext()!
//        UIGraphicsEndImageContext()
//        model.shareImage = capturedImage
//
//        scrPop.show(image: capturedImage, labelText: "撮影したスクリーンショットをシェアしますか？", btnText: "シェア")
//    }
//
//    @objc func scrShareDidTap() {
//        scrPop.removeFromSuperview()
//
//        let backgroundView: UIView = {
//            let view = UIView()
//            view.backgroundColor = UIColor.app.popUpBackgroundButtonColor
//            return view
//        }()
//        // TODO: メソッド化
//        let pop = ScreenshotPopView(url: model.shop.shopURL, image: model.shareImage)
//        pop.completion = {
//            pop.removeFromSuperview()
//            backgroundView.removeFromSuperview()
//        }
//        pop.copyCompletion = { [weak self] in
//            self?.showPastePop()
//        }
//
//        UIApplication.shared.keyWindow?.addSubview(backgroundView)
//        backgroundView.addSubview(pop)
//        let bounds = UIScreen.main.bounds
//        let height = bounds.size.height
//
//        backgroundView.snp.makeConstraints {
//            $0.edges.equalToSuperview()
//        }
//        pop.snp.makeConstraints {
//            $0.edges.equalToSuperview()
//        }
//        pop.alpha = 0.0
//        pop.layer.y = height*2
//        UIView.animate(withDuration: 0.4, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
//            pop.alpha = 1.0
//            UIView.animate(withDuration: 0.25, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
//                pop.center.y = height/2 - 20
//            }, completion: nil)
//            UIView.animate(withDuration: 0.1, delay: 0.25, options: UIViewAnimationOptions.curveEaseInOut, animations: {
//                pop.center.y = height/2 + 10
//            }, completion: nil)
//            UIView.animate(withDuration: 0.05, delay: 0.35, options: UIViewAnimationOptions.curveEaseInOut, animations: {
//                pop.center.y = height/2
//            }, completion: nil)
//            // 再度タップできるようにする
//            self.shareBtn.isEnabled = true
//            self.naviBarShareButtonItem.isEnabled = true
//        }, completion: nil)
//    }
//
//    func showPastePop() {
//        let pop = NotificationPopView()
//        pop.show(text: "クリップボードにコピーしました")
//    }
//
    @objc func shareDidTap() {
        // 二重タップを禁止する
        self.shareBtn.isEnabled = false
        self.naviBarShareButtonItem.isEnabled = false
        
        let backgroundView: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor.app.popUpBackgroundButtonColor
            return view
        }()
        
        UIApplication.shared.keyWindow?.addSubview(backgroundView)
        
        let bounds = UIScreen.main.bounds
        let height = bounds.size.height
        
        if Defaults[.isGuest] {
            // TODO: メソッド化
            let pop = SharePopView(tokenUrl: self.model.shop.shopURL, shops: [self.model.shop])
            pop.completion = {
                pop.removeFromSuperview()
                backgroundView.removeFromSuperview()
            }
            pop.copyCompletion = { [weak self] in
                self?.showPastePop()
            }
            backgroundView.addSubview(pop)
            
            backgroundView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
            pop.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
            pop.alpha = 0.0
            pop.layer.y = height*1.5
            UIView.animate(withDuration: 0.4, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                pop.alpha = 1.0
                UIView.animate(withDuration: 0.25, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                    pop.center.y = height/2 - 20
                }, completion: nil)
                UIView.animate(withDuration: 0.1, delay: 0.25, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                    pop.center.y = height/2 + 10
                }, completion: nil)
                UIView.animate(withDuration: 0.05, delay: 0.35, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                    pop.center.y = height/2
                }, completion: nil)
                // 再度タップできるようにする
                self.shareBtn.isEnabled = true
                self.naviBarShareButtonItem.isEnabled = true
            }, completion: nil)
        } else {
            model.fetchShareLink(shop: model.shop) { [weak self] tokenUrl in
                // TODO: メソッド化
                let pop = SharePopView(tokenUrl: tokenUrl, shops: [(self?.model.shop)!])
                pop.completion = {
                    pop.removeFromSuperview()
                    backgroundView.removeFromSuperview()
                }
                pop.copyCompletion = { [weak self] in
                    self?.showPastePop()
                }
                backgroundView.addSubview(pop)
                
                backgroundView.snp.makeConstraints {
                    $0.edges.equalToSuperview()
                }
                pop.snp.makeConstraints {
                    $0.edges.equalToSuperview()
                }
                pop.alpha = 0.0
                pop.layer.y = height*1.5
                UIView.animate(withDuration: 0.4, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                    pop.alpha = 1.0
                    UIView.animate(withDuration: 0.25, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                        pop.center.y = height/2 - 20
                    }, completion: nil)
                    UIView.animate(withDuration: 0.1, delay: 0.25, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                        pop.center.y = height/2 + 10
                    }, completion: nil)
                    UIView.animate(withDuration: 0.05, delay: 0.35, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                        pop.center.y = height/2
                    }, completion: nil)
                    // 再度タップできるようにする
                    self?.shareBtn.isEnabled = true
                    self?.naviBarShareButtonItem.isEnabled = true
                }, completion: nil)
            }
        }
    }
    
    // 一旦非表示
    //    @objc private func shopHPBtnDidTap() {
    //        let url = URL(string: self.model.shop.shopURL)
    //
    //        if let url = url {
    //            let safariViewController = SFSafariViewController(url: url)
    //            self.present(safariViewController, animated: true)
    //        }
    //    }
    
    private func fetchShop() {
        // ShopEditで編集した時に重複するため、配列を初期化
        self.images.removeAll()
        self.model.selectedIndexes.removeAll()
        self.model.selectedListIDs.removeAll()
        if Defaults[.isGuest] {
            model.fetchShopForGuest { [weak self] in
                guard let `self` = self else { return } // TODO:リファクタリング
                
                // TODO: リファクタリング
                if self.model.shop.contactNum != "" {
                    self.number = self.model.shop.contactNum
                } else if self.model.shop.reservationNum != "" {
                    self.number = self.model.shop.reservationNum
                } else {
                    self.number = ""
                }
                
                // 投稿画像 > Yelp の優先度で画像を表示
                if !self.model.shop.imageURLs.isEmpty {
                    self.headerImageView.kf.cancelDownloadTask()
                    self.headerImageView.kf.setImage(with: self.model.shop.imageURLs[0])
                } else {
                    //電話番号からYelpの画像を取得する
                    if !self.number.isEmpty {
                        YelpAPIManager.fetchImage(phoneNum: self.number, completion: { imageURLString in
                            if let imageURL = URL(string: imageURLString) {
                                self.headerImageView.kf.cancelDownloadTask()
                                self.headerImageView.kf.setImage(with: imageURL, placeholder: nil, options: nil, progressBlock: nil) { (image, error, cacheType, url) in
                                    self.images.append(self.headerImageView.image!)
                                    self.imageCollectionView.reloadData()
                                }
                            }
                        })
                    }
                }
                
                self.shopNameLabel.text = self.model.shop.name
                self.title = self.model.shop.name
                self.accessLabel.text = "最寄駅：\(self.model.shop.access)"
                self.genreLabel.text = "ジャンル：\(self.model.shop.genre)"
                
                //マップの設定
                let camera = GMSCameraPosition.camera(withLatitude: self.model.shop.latitude, longitude: self.model.shop.longitude, zoom: 16.0)
                self.mapView.camera = camera
                
                let marker = GMSMarker()
                marker.position = CLLocationCoordinate2D(latitude: self.model.shop.latitude, longitude: self.model.shop.longitude)
                marker.map = self.mapView
                
                self.addressView.configure(content: self.model.shop.address)
                self.accessView.configure(content: self.model.shop.access)
                self.priceView.configure(content: self.model.shop.userBudget)
                self.hoursView.configure(content: self.model.shop.hours)
                self.phoneView.configure(content: self.number)
                self.holidayView.configure(content: self.model.shop.holidays)
                self.seatsView.configure(content: self.model.shop.numOfSeats)
                
                self.model.fetchListsForGuest { [weak self] in
                    self?.model.shop.lists.forEach {
                        for (index, element) in (self?.model.lists.enumerated())! {
                            if $0.id == element.id {
                                if self?.model.shop.visitedCount == 1 {
                                    //1回行った時は「行きたい」ラベルを追加
                                    self?.model.selectedIndexes.append(index + 1)
                                } else {
                                    self?.model.selectedIndexes.append(index)
                                }
                                self?.model.selectedListIDs.append(element.id)
                            }
                        }
                    }
                }
                
                //メモの設定
                
                //                // メモがあれば表示させる
                if self.model.shop.comment != "" && self.model.shop.comment != "<null>" {
                    self.commentTextView.text = self.model.shop.comment
                    //                    self.remakeConstraints()
                } else {
                    self.commentTextView.text = ""
                }
                
                // 写真の設定
                //初期化する
                self.images = []
                self.model.shop.imageURLs.forEach {
                    guard let url = $0 else { return }
                    let imageView = UIImageView()
                    imageView.kf.cancelDownloadTask()
                    imageView.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: nil) { (image, error, cacheType, url) in
                        self.images.append(imageView.image!)
                        self.imageCollectionView.reloadData()
                    }
                }
            }
        } else {
            model.fetchShop { [weak self] in
                guard let `self` = self else { return } // TODO:リファクタリング
                
                // TODO: リファクタリング
                if self.model.shop.contactNum != "" {
                    self.number = self.model.shop.contactNum
                } else if self.model.shop.reservationNum != "" {
                    self.number = self.model.shop.reservationNum
                } else {
                    self.number = ""
                }
                
                // 投稿画像 > Yelp の優先度で画像を表示
                if !self.model.shop.imageURLs.isEmpty {
                    self.headerImageView.kf.cancelDownloadTask()
                    self.headerImageView.kf.setImage(with: self.model.shop.imageURLs[0])
                } else {
                    //電話番号からYelpの画像を取得する
                    if !self.number.isEmpty {
                        YelpAPIManager.fetchImage(phoneNum: self.number, completion: { imageURLString in
                            if let imageURL = URL(string: imageURLString) {
                                self.headerImageView.kf.cancelDownloadTask()
                                self.headerImageView.kf.setImage(with: imageURL, placeholder: nil, options: nil, progressBlock: nil) { (image, error, cacheType, url) in
                                    self.images.append(self.headerImageView.image!)
                                    self.imageCollectionView.reloadData()
                                }
                            }
                        })
                    }
                }
                
                self.shopNameLabel.text = self.model.shop.name
                self.title = self.model.shop.name
                self.accessLabel.text = "最寄駅：\(self.model.shop.access)"
                self.genreLabel.text = "ジャンル：\(self.model.shop.genre)"
                
                //マップの設定
                let camera = GMSCameraPosition.camera(withLatitude: self.model.shop.latitude, longitude: self.model.shop.longitude, zoom: 16.0)
                self.mapView.camera = camera
                
                let marker = GMSMarker()
                marker.position = CLLocationCoordinate2D(latitude: self.model.shop.latitude, longitude: self.model.shop.longitude)
                marker.map = self.mapView
                
                self.addressView.configure(content: self.model.shop.address)
                self.accessView.configure(content: self.model.shop.access)
                self.priceView.configure(content: self.model.shop.userBudget)
                self.hoursView.configure(content: self.model.shop.hours)
                self.phoneView.configure(content: self.number)
                self.holidayView.configure(content: self.model.shop.holidays)
                self.seatsView.configure(content: self.model.shop.numOfSeats)
                
                self.model.fetchLists { [weak self] in
                    self?.model.shop.lists.forEach {
                        for (index, element) in (self?.model.lists.enumerated())! {
                            if $0.id == element.id {
                                if self?.model.shop.visitedCount == 1 {
                                    //1回行った時は「行きたい」ラベルを追加
                                    self?.model.selectedIndexes.append(index + 1)
                                } else {
                                    self?.model.selectedIndexes.append(index)
                                }
                                self?.model.selectedListIDs.append(element.id)
                            }
                        }
                    }
                }
                
                //メモの設定
                // メモがあれば表示させる
                if self.model.shop.comment != "" && self.model.shop.comment != "<null>" {
                    self.commentTextView.text = self.model.shop.comment
                    //                    self.remakeConstraints()
                } else {
                    self.commentTextView.text = ""
                }
                
                //TODO: ダウンロードできない写真があった時の対応
                
                // 写真の設定
                self.images = []
                var removedIndexes = [Int]()
                for (index, url) in self.model.shop.imageURLs.enumerated() {
                    //                self.model.shop.imageURLs.forEach {
                    guard let url = url else { return }
                    let imageView = UIImageView()
                    imageView.kf.cancelDownloadTask()
                    imageView.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: nil) { (image, error, cacheType, url) in
                        if let image = image {
                            self.images.append(image)
                            self.imageCollectionView.reloadData()
                        } else {
                            // ダウンロードのできない画像があれば、urlリストから削除する
                            var removingIndex = index
                            for removedIndex in removedIndexes {
                                if removedIndex < index {
                                    removingIndex-=1
                                }
                            }
                            self.model.shop.imageURLs.remove(at: removingIndex)
                            removedIndexes.append(index)
                        }
                    }
                }
            }
        }
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func editDidTap() {
        // 二重タップ防止
        self.editButton.isEnabled = false
        if Defaults[.isGuest] {
            let guestWelcomeVC = GuestWelcomeVC()
            self.present(guestWelcomeVC, animated: true, completion: nil)
            self.editButton.isEnabled = true
        } else {
            //            let navigationController = UINavigationController(rootViewController: ShopEditVC(model))
            
            var imagesByUser = self.images
            if self.model.shop.imageURLs.isEmpty {
                imagesByUser = []
            }
            
            let navigationController = UINavigationController(rootViewController: EditShopVC(model: model, images:imagesByUser))
            self.present(navigationController, animated: true, completion: nil)
        }
        
    }
    
    @objc private func mapViewDidTap() {
        let vc = MapDetailVC(latitude: model.shop.latitude, longitude: model.shop.longitude, title: model.shop.name)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func addSubviews() {
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.headerImageView)
        
        self.scrollView.addSubview(self.mainInfoView)
        self.mainInfoView.addSubview(self.shopNameLabel)
        self.mainInfoView.addSubview(self.horizontalLineView)
        self.mainInfoView.addSubview(self.accessIconImageView)
        self.mainInfoView.addSubview(self.accessLabel)
        self.mainInfoView.addSubview(self.genreIconImageView)
        self.mainInfoView.addSubview(self.genreLabel)
        self.mainInfoView.addSubview(self.callBtn)
        self.mainInfoView.addSubview(self.shareBtn)
        
        self.scrollView.addSubview(self.commentView)
        self.commentView.addSubview(self.commentTextView)
        
        self.scrollView.addSubview(self.colectionBackgroungView)
        self.colectionBackgroungView.addSubview(self.imageCollectionView)
        
        self.scrollView.addSubview(self.locationInfoView)
        self.locationInfoView.addSubview(self.locationTitleLabel)
        self.locationInfoView.addSubview(self.mapView)
        self.locationInfoView.addSubview(self.mapBtn)
        self.locationInfoView.addSubview(self.addressView)
        self.addressView.addSubview(self.copyAddressBtn)
        
        self.locationInfoView.addSubview(self.accessView)
        
        self.scrollView.addSubview(self.detailInfoView)
        self.detailInfoView.addSubview(self.detailTitleLabel)
        self.detailInfoView.addSubview(self.priceView)
        self.detailInfoView.addSubview(self.hoursView)
        self.detailInfoView.addSubview(self.phoneView)
        self.phoneView.addSubview(self.phoneViewBtn)
        
        self.detailInfoView.addSubview(self.holidayView)
        self.detailInfoView.addSubview(self.seatsView)
        // 一旦非表示
        //        self.detailInfoView.addSubview(self.shopHPBtn)
        
        self.scrollView.addSubview(self.editButton)
        
        self.view.addSubview(footerView)
        self.footerView.addSubview(checkInBtn)
        
        self.view.addSubview(self.navigationBarBGView)
        self.view.addSubview(self.backButtonBGView)
        self.view.addSubview(self.naviBarShareButtonBGView)
        //        self.view.addSubview(self.backButton)
    }
    
    private func makeConstraints() {
        self.scrollView.snp.makeConstraints {
            $0.width.equalToSuperview()
            
            let statusBarHeight = UIApplication.shared.statusBarFrame.size.height
            $0.top.equalToSuperview().inset(-(statusBarHeight + 44))
            
            $0.left.right.bottom.equalToSuperview()
        }
        
        self.headerImageView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(self.headerImageView.snp.width).multipliedBy(0.56)
        }
        
        // ここからmainInfo
        self.mainInfoView.snp.makeConstraints {
            $0.top.equalTo(self.headerImageView.snp.bottom).offset(-20)
            $0.left.right.equalToSuperview().inset(16)
        }
        
        self.shopNameLabel.snp.makeConstraints {
            $0.height.equalTo(14)
            $0.top.equalToSuperview().inset(24)
            $0.left.right.equalToSuperview().inset(16)
        }
        
        self.horizontalLineView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.top.equalTo(self.shopNameLabel.snp.bottom).offset(22)
            $0.left.right.equalToSuperview().inset(24)
        }
        
        self.accessIconImageView.snp.makeConstraints {
            $0.size.equalTo(16)
            $0.top.equalTo(self.horizontalLineView.snp.bottom).offset(16)
            $0.left.equalTo(self.horizontalLineView)
        }
        
        self.accessLabel.snp.makeConstraints {
            $0.centerY.equalTo(self.accessIconImageView)
            $0.left.equalTo(self.accessIconImageView.snp.right).offset(8)
            $0.right.equalToSuperview().inset(16)
        }
        
        self.genreIconImageView.snp.makeConstraints {
            $0.size.equalTo(16)
            $0.top.equalTo(self.accessIconImageView.snp.bottom).offset(8)
            $0.left.equalTo(self.horizontalLineView)
        }
        
        self.genreLabel.snp.makeConstraints {
            $0.centerY.equalTo(self.genreIconImageView)
            $0.left.equalTo(self.genreIconImageView.snp.right).offset(8)
            $0.right.equalToSuperview().inset(16)
        }
        
        self.callBtn.snp.makeConstraints {
            switch iPhoneSize.type() {
            case .iPhoneSE:
                $0.width.equalTo(110)
                $0.height.equalTo(48)
                $0.top.equalTo(self.genreIconImageView.snp.bottom).offset(16)
                $0.left.equalTo(self.horizontalLineView)
                $0.bottom.equalToSuperview().inset(24)
            case .iPhone8:
                $0.height.equalTo(48)
                $0.top.equalTo(self.genreIconImageView.snp.bottom).offset(16)
                $0.left.equalTo(self.horizontalLineView)
                $0.bottom.equalToSuperview().inset(24)
            case .iPhone8Plus:
                $0.height.equalTo(48)
                $0.top.equalTo(self.genreIconImageView.snp.bottom).offset(16)
                $0.left.equalTo(self.horizontalLineView)
                $0.bottom.equalToSuperview().inset(24)
            case .iPhoneX:
                $0.height.equalTo(48)
                $0.top.equalTo(self.genreIconImageView.snp.bottom).offset(16)
                $0.left.equalTo(self.horizontalLineView)
                $0.bottom.equalToSuperview().inset(24)
            case .other:
                $0.height.equalTo(48)
                $0.top.equalTo(self.genreIconImageView.snp.bottom).offset(16)
                $0.left.equalTo(self.horizontalLineView)
                $0.bottom.equalToSuperview().inset(24)
            }
        }
        
        self.shareBtn.snp.makeConstraints {
            switch iPhoneSize.type() {
            case .iPhoneSE:
                $0.width.equalTo(100)
                $0.height.equalTo(48)
                $0.top.equalTo(self.callBtn)
                $0.left.equalTo(self.callBtn.snp.right).offset(12)
                $0.right.equalTo(self.horizontalLineView)
            case .iPhone8:
                $0.height.equalTo(48)
                $0.top.equalTo(self.callBtn)
                $0.left.equalTo(self.callBtn.snp.right).offset(12)
                $0.right.equalTo(self.horizontalLineView)
            case .iPhone8Plus:
                $0.height.equalTo(48)
                $0.top.equalTo(self.callBtn)
                $0.left.equalTo(self.callBtn.snp.right).offset(12)
                $0.right.equalTo(self.horizontalLineView)
            case .iPhoneX:
                $0.height.equalTo(48)
                $0.top.equalTo(self.callBtn)
                $0.left.equalTo(self.callBtn.snp.right).offset(12)
                $0.right.equalTo(self.horizontalLineView)
            case .other:
                $0.height.equalTo(48)
                $0.top.equalTo(self.callBtn)
                $0.left.equalTo(self.callBtn.snp.right).offset(12)
                $0.right.equalTo(self.horizontalLineView)
            }
        }
        
        // ここから写真
        //        self.colectionBackgroungView.snp.makeConstraints {
        //            $0.top.equalTo(self.mainInfoView.snp.bottom).offset(10)
        //            $0.left.right.equalToSuperview().inset(16)
        //            $0.height.equalTo(150)
        //        }
        
        self.commentView.snp.remakeConstraints {
            $0.top.equalTo(self.mainInfoView.snp.bottom).offset(16)
            $0.left.right.equalToSuperview().inset(16)
        }
        
        self.commentTextView.snp.remakeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
        
        self.colectionBackgroungView.snp.remakeConstraints {
            $0.top.equalTo(self.commentView.snp.bottom).offset(10)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(130)
        }
        
        self.imageCollectionView.snp.makeConstraints {
            $0.right.equalToSuperview()
            $0.top.bottom.equalToSuperview()
            $0.left.equalToSuperview().inset(22)
        }
        
        // ここからlocationInfo
        self.locationInfoView.snp.makeConstraints {
            $0.top.equalTo(self.colectionBackgroungView.snp.bottom).offset(16)
            $0.left.right.equalToSuperview().inset(16)
        }
        
        self.locationTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24)
            $0.left.equalToSuperview().inset(16)
        }
        
        self.mapView.snp.makeConstraints {
            $0.height.equalTo(132)
            $0.top.equalTo(self.locationTitleLabel.snp.bottom).offset(24)
            $0.left.right.equalToSuperview()
        }
        
        self.mapBtn.snp.makeConstraints {
            $0.edges.equalTo(self.mapView)
        }
        
        self.addressView.snp.makeConstraints {
            $0.top.equalTo(self.mapView.snp.bottom)
            $0.left.right.equalToSuperview()
        }
        
        self.copyAddressBtn.snp.makeConstraints {
            $0.height.equalToSuperview()
            $0.right.equalTo(self.addressView)
            $0.left.equalTo(self.addressView.contentLabel).inset(-40)
            $0.centerY.equalToSuperview()
        }
        
        self.accessView.snp.makeConstraints {
            $0.top.equalTo(self.addressView.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview().inset(8)
        }
        
        self.detailInfoView.snp.makeConstraints {
            $0.top.equalTo(self.locationInfoView.snp.bottom).offset(16)
            $0.left.right.equalToSuperview().inset(16)
        }
        
        self.detailTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24)
            $0.left.equalToSuperview().inset(16)
        }
        
        self.priceView.snp.makeConstraints {
            $0.top.equalTo(self.detailTitleLabel.snp.bottom)
            $0.left.right.equalToSuperview()
        }
        
        self.hoursView.snp.makeConstraints {
            $0.top.equalTo(self.priceView.snp.bottom)
            $0.left.right.equalToSuperview()
        }
        
        self.phoneView.snp.makeConstraints {
            $0.top.equalTo(self.hoursView.snp.bottom)
            $0.left.right.equalToSuperview()
        }
        
        self.phoneViewBtn.snp.makeConstraints {
            $0.height.equalToSuperview()
            $0.right.equalTo(self.phoneView)
            $0.left.equalTo(self.phoneView.contentLabel).inset(-40)
            $0.centerY.equalToSuperview()
        }
        
        self.holidayView.snp.makeConstraints {
            $0.top.equalTo(self.phoneView.snp.bottom)
            $0.left.right.equalToSuperview()
        }
        
        self.seatsView.snp.makeConstraints {
            $0.top.equalTo(self.holidayView.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview().inset(16 + 8) //shopHPBtnを復活させるときは消す
        }
        // 一旦非表示
        //        self.shopHPBtn.snp.makeConstraints {
        //            $0.top.equalTo(self.seatsView.snp.bottom).offset(16)
        //            $0.left.equalToSuperview().offset(16)
        //            $0.bottom.equalToSuperview().inset(16 + 8)
        //        }
        
        self.editButton.snp.makeConstraints {
            $0.top.equalTo(self.detailInfoView.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(40)
            $0.width.equalTo(120)
            $0.bottom.equalToSuperview().inset(82 + 16) //フッター + 余白
        }
        
        self.footerView.snp.makeConstraints {
            $0.top.equalTo(bottomMargin()).inset(50)
            $0.left.bottom.right.equalToSuperview()
        }
        
        self.checkInBtn.snp.makeConstraints {
            $0.right.equalToSuperview().inset(15)
            if iPhoneSize.type() == .iPhoneX {
                $0.top.equalToSuperview().inset(10)
                $0.width.equalTo(160)
                $0.height.equalTo(40)
            } else {
                $0.top.equalToSuperview().inset(7.5)
                $0.width.equalTo(150)
                $0.height.equalTo(35)
            }
        }
        
        self.navigationBarBGView.snp.makeConstraints {
            let statusBarHeight = UIApplication.shared.statusBarFrame.size.height
            $0.top.equalToSuperview().inset(-(statusBarHeight + 44))
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(self.topMargin())
        }
        
        self.backButtonBGView.snp.makeConstraints {
            $0.size.equalTo(36)
            $0.bottom.equalTo(self.navigationBarBGView).inset(4)
            if iPhoneSize.type() == .iPhone8Plus {
                $0.left.equalToSuperview().inset(10)
            } else {
                $0.left.equalToSuperview().inset(6)
            }
        }
        
        self.naviBarShareButtonBGView.snp.makeConstraints {
            $0.size.equalTo(36)
            $0.bottom.equalTo(self.navigationBarBGView).inset(6)
            if iPhoneSize.type() == .iPhone8Plus {
                $0.right.equalToSuperview().inset(13)
            } else {
                $0.right.equalToSuperview().inset(9)
            }
        }
        
    }
    
    //    private func remakeConstraints() {
    //        self.commentView.snp.remakeConstraints {
    //            $0.top.equalTo(self.mainInfoView.snp.bottom).offset(16)
    //            $0.left.right.equalToSuperview().inset(16)
    //        }
    //
    //        self.commentTextView.snp.remakeConstraints {
    //            $0.edges.equalToSuperview().inset(10)
    //        }
    //
    //        self.colectionBackgroungView.snp.remakeConstraints {
    //            $0.top.equalTo(self.commentView.snp.bottom).offset(10)
    //            $0.left.right.equalToSuperview().inset(16)
    //            $0.height.equalTo(130)
    //        }
    //    }
    
    // ナビゲーションバーの色を適宜変える
    private func changeNavigationBarColor() {
        // 共通
        self.navigationController?.navigationBar.barTintColor = UIColor.clear
        self.navigationController?.navigationBar.isTranslucent = true
        
        if self.scrollView.contentOffset.y >= UIScreen.main.bounds.size.width * 0.56 - 130 {
            self.title = self.model.shop.name
            UIView.animate(
                withDuration: 0.3,
                delay: 0.0,
                options: [.curveEaseIn],
                animations: {
                    self.navigationBarBGView.backgroundColor = .white
                    self.backButtonItem.tintColor = UIColor.app.dustyOrange
                    UIApplication.shared.statusBarStyle = .default //ステータスバーの色は黒
                    self.navigationController?.navigationBar.titleTextAttributes =  [NSAttributedStringKey.foregroundColor : UIColor.app.matBlack]//タイトル文字色
                    self.backButtonBGView.backgroundColor = .clear
                    self.naviBarShareButtonBGView.backgroundColor = .clear
                    self.naviBarShareButtonItem.tintColor = UIColor.app.dustyOrange
            },
                completion: nil
            )
        } else {
            self.title = ""
            UIView.animate(
                withDuration: 0.3,
                delay: 0.0,
                options: [.curveEaseIn],
                animations: {
                    self.navigationBarBGView.backgroundColor = .clear
                    self.backButtonItem.tintColor = .white
                    UIApplication.shared.statusBarStyle = .lightContent //ステータスバーの色は白
                    self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.clear] //タイトル文字色
                    self.backButtonBGView.backgroundColor = UIColor(white: 0, alpha: 0.2)
                    self.naviBarShareButtonBGView.backgroundColor = UIColor(white: 0, alpha: 0.2)
                    self.naviBarShareButtonItem.tintColor = .white
            },
                completion: nil
            )
        }
    }
    
    @objc private func didTapCameraBtn() {
        // 許可状態を取得する
        let status = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        // 許可されていなければ、許可を促す
        switch status {
        case .authorized:
            self.requestAlbumAuthorization()
        case .denied:
            // TODO:
            // Alert.show(with:)はtitleなし、（エラーというタイトルはよくない）
            // Alert.show(with: , title: )はタイトルあり
            // という感じに、Alertのメソッドを変えた方がいいかも？？？
            Alert.showCameraPermission()
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: {  [weak self] authorized in
                if authorized {
                    self?.requestAlbumAuthorization()
                }
            })
        default:
            break;
        }
        
        
    }
    
    // アルバムのアクセス状態を確認して、imagePickerを表示する
    func requestAlbumAuthorization() {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized: //許可
            self.showImagePicker()
        case .denied: //拒否状態
            Alert.showLibraryPermission()
        case .notDetermined: //決めていない
            PHPhotoLibrary.requestAuthorization({ (PHAuthorizationStatus) in
                switch PHAuthorizationStatus {
                    
                case .authorized: //許可
                    self.showImagePicker()
                case .denied: //拒否
                    Alert.showLibraryPermission()
                    break;
                default:
                    break;
                }
            })
            break
        case .restricted: //使用制限で許可を変更できない
            break
        }
    }
    
    func showImagePicker() {
        let imagePickerController = DKImagePickerController()
        imagePickerController.assetType = .allPhotos
        imagePickerController.maxSelectableCount = 5
        
        imagePickerController.didSelectAssets = { (assets: [DKAsset]) in
            
            //            // 先に画像を表示する
            //            for asset in assets {
            //                asset.fetchFullScreenImage(true, completeBlock: { (image, info) in
            //                    if let image = image {
            //                        self.images.append(image)
            //                        DispatchQueue.main.async {
            //                            self.imageCollectionView.reloadData()
            //                        }
            //                    }
            //                })
            //            }
            
            // 画像をアップロードする
            for (index, asset) in assets.enumerated() {
                asset.fetchFullScreenImage(true, completeBlock: { (image, info) in
                    if let image = image {
                        
                        //TODO: リファクタリング、URLはアップロード以前に確定しているので先に保存
                        let key = "test/" + String(UInt64(Date().timeIntervalSince1970 * 1000)) + "a.jpeg"
                        let url = "https://s3-ap-northeast-1.amazonaws.com/ecry-app/" + key
                        self.model.shop.imageURLs.append(URL(string:url))
                        AWSS3Manager.upload(image: image, key: key, completion: { url in
                            
                            // 画像を表示する
                            self.images.append(image)
                            DispatchQueue.main.async {
                                self.imageCollectionView.reloadData()
                            }
                            
                            // 最後の画像のアップデートを終えたら更新する
                            if index == assets.count-1 {
                                self.model.editShop {
                                }
                                if let movingListNum = self.movingListNum {
                                    EcryTabBarController.shared.topVC.reflashList(moveListNum: movingListNum)
                                } else {
                                    EcryTabBarController.shared.topVC.reflashList()
                                }
                            }
                        })
                    }
                })
            }
        }
        present(imagePickerController, animated: true)
    }
    
//    public func changeSaveMode() {
//        self.checkInBtn.setTitle("リストに保存する", for: .normal)
//        self.checkInBtn.addTarget(self, action: #selector(self.saveShopInSelectedList), for: .touchUpInside)
//        self.checkInBtn.backgroundColor = .red
//    }
    
//    @objc private func saveShopInSelectedList() {
//        self.checkInBtn.isEnabled = false
//        self.model.saveInList(listID: self.listID) { [weak self] in
//            guard let `self` = self else { return }
//            //サーチバーから遷移してきたときのために、バックグラウンドでタブをTopVCに戻しておく
//            let tabVC = EcryTabBarController.shared
//            tabVC.selectedIndex = 0
//            // TODO: APIerror時はショップを追加しない。
//            self.checkInBtn.isEnabled = true
//            // 最初の引数は行ったかどうか,最後の引数はrank関係でとりあえず0
//            self.pinCompletion?(false, self.model.shop, [self.listID], 0)
//            self.presentingViewController?.dismiss(animated: false, completion: nil)
//            self.navigationController?.popToViewController(self.navigationController!.viewControllers[0], animated: false)
//            UIView.setAnimationsEnabled(true)
//
//            let pop = NotificationPopView()
//            pop.show(text: "お店を保存しました")
//        }
//    }
    
}

//extension ShopVC: UITableViewDelegate {
//}

//extension ShopVC: UIScrollViewDelegate {
//    // ステータスバーをタップしてスクロール直前
//    func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
//        self.isScrollingToTop = true
//        return true
//    }
//
//    // ステータスバーをタップしてスクロール直後
//    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
//        self.isScrollingToTop = false
//    }
//
//    func scrollViewDidScroll(_: UIScrollView) {
//        // iOS10以下の場合、画面遷移後も呼ばれてしまうため、
//        // ユーザーによるスクロールの場合のみアニメーションを行う
//        if self.scrollView.isDragging || self.isScrollingToTop {
//            self.changeNavigationBarColor()
//        }
//
//        // 下に引っ張ったとき、画像を拡大させる
//        if self.scrollView.contentOffset.y < 0 {
//            self.headerImageView.snp.remakeConstraints {
//                $0.width.equalToSuperview()
//                $0.top.left.right.equalToSuperview()
//
//                $0.top.equalToSuperview().inset(self.scrollView.contentOffset.y)
//                $0.height.equalTo(UIScreen.main.bounds.size.width * 0.56 - self.scrollView.contentOffset.y)
//            }
//        } else {
//            self.headerImageView.snp.remakeConstraints {
//                $0.width.equalToSuperview()
//                $0.top.left.right.equalToSuperview()
//                $0.height.equalTo(self.headerImageView.snp.width).multipliedBy(0.56)
//            }
//        }
//
//    }
//}


//UIImagePickerControllerDelegateを動かすのに必要
extension ShopVC: UINavigationControllerDelegate {
}

extension ShopVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count+1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CheckInPhotoCell", for: indexPath) as! CheckInPhotoCell
        
        switch indexPath.row {
        case images.count: // カメラボタン
            let image = UIImage(named: "camera")
            let tintedImage = image?.withRenderingMode(.alwaysTemplate)
            cell.configure(image: tintedImage!)
            cell.remakeCametaAlbumDesign()
        default: // 写真
            // UIImageに変換する
            cell.configure(image: images[indexPath.row])
        }
        return cell
    }
}


//extension ShopVC: UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//        switch indexPath.row {
//        case images.count: // カメラボタン
//            self.didTapCameraBtn()
//        default:
//            let galleryViewController = GalleryViewController(startIndex: indexPath.row, itemsDataSource: self, itemsDelegate: nil, displacedViewsDataSource: nil, configuration: [
//                GalleryConfigurationItem.deleteButtonMode(.none),
//                GalleryConfigurationItem.thumbnailsButtonMode(.none)
//                ])
//            self.presentImageGallery(galleryViewController)
//        }
//    }
//}
//
//extension ShopVC: CameraViewControllerDelegate {
//    func cameraViewControllerDidTapCancel(_ viewController: CameraViewController) {
//        viewController.dismiss(animated: true)
//    }
//
//    func cameraViewController(_ viewController: CameraViewController, didTakeImage image: UIImage) {
//        // 先に画像を表示する
//        viewController.dismiss(animated: true)
//        self.images.append(image)
//        self.imageCollectionView.reloadData()
//
//        // 画像をアップロードする
//        //TODO: リファクタリング、URLはアップロード以前に確定しているので先に保存
//        let key = "test/" + String(UInt64(Date().timeIntervalSince1970 * 1000)) + "a.jpeg"
//        let url = "https://s3-ap-northeast-1.amazonaws.com/ecry-app/" + key
//        self.model.urls.append(url)
//        AWSS3Manager.upload(image: image, key: key, completion: { url in
//            if let movingListNum = self.movingListNum {
//                EcryTabBarController.shared.topVC.reflashList(moveListNum: movingListNum)
//            } else {
//                EcryTabBarController.shared.topVC.reflashList()
//            }
//
//        })
//    }
//}
//
//extension ShopVC: GalleryItemsDataSource {
//    func itemCount() -> Int {
//        return self.images.count
//    }
//
//    func provideGalleryItem(_ index: Int) -> GalleryItem {
//        return GalleryItem.image(fetchImageBlock: {
//            $0(self.images[index])
//        })
//    }
//}


