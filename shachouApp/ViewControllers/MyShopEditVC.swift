
import UIKit
import SnapKit
import DKImagePickerController
import SwiftyUserDefaults


final class MyShopEditVC: UIViewController {
    
    let model : ShopModel
    
    init(shopID: Int) {
        model = ShopModel(shopID)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    let cameraButton: UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(cameraBtnDidTap), for: .touchUpInside)
        return btn
    }()
        
    let ImageBackView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 4
        view.backgroundColor = UIColor.white
        return view
    }()
    
    
    let ShopNameField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "お店の名前"
        textField.textAlignment = .center
        textField.backgroundColor = UIColor.white
        textField.dividerColor = UIColor.gray
        return textField
    }()

    
    let ShopCallField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "電話番号"
        textField.textAlignment = .center
        textField.backgroundColor = UIColor.white
        textField.dividerColor = UIColor.gray
        return textField
    }()

    let ShopAccessField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "住所"
        textField.textAlignment = .center
        textField.backgroundColor = UIColor.white
        textField.dividerColor = UIColor.gray
        return textField
    }()
    
    let ShopInfoField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "詳細"
        textField.textAlignment = .center
        textField.backgroundColor = UIColor.white
        textField.dividerColor = UIColor.gray
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetch()
        self.view.backgroundColor = UIColor(red: 0.2, green: 0.047, blue: 0, alpha: 1.0)
        self.view.addSubview(cameraButton)
        self.view.addSubview(ImageBackView)
        self.view.addSubview(ShopNameField)
        self.view.addSubview(ShopCallField)
        self.view.addSubview(ShopAccessField)
        self.view.addSubview(ShopInfoField)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = self.model.shop.shopname
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "完了！", style: .plain, target: self, action: #selector(screen1))
        
        cameraButton.snp.makeConstraints {
            $0.edges.equalTo(ImageBackView.snp.edges)
        }
        
        ImageBackView.snp.makeConstraints{
            $0.height.equalTo(300)
            $0.width.equalToSuperview()
            $0.top.equalToSuperview().offset(65)
        }
        
        ShopNameField.snp.makeConstraints{
            $0.height.equalTo(70)
            $0.width.equalToSuperview()
            $0.top.equalTo(ImageBackView.snp.bottom).offset(2)
        }
        
        ShopCallField.snp.makeConstraints{
            $0.height.equalTo(70)
            $0.width.equalToSuperview()
            $0.top.equalTo(ShopNameField.snp.bottom).offset(2)
        }
        
        ShopAccessField.snp.makeConstraints{
            $0.height.equalTo(70)
            $0.width.equalToSuperview()
            $0.top.equalTo(ShopCallField.snp.bottom).offset(2)
        }
        
        ShopInfoField.snp.makeConstraints{
            $0.bottom.equalToSuperview().offset(2)
            $0.width.equalToSuperview()
            $0.top.equalTo(ShopAccessField.snp.bottom).offset(2)
        }
        
    }
    
    func fetch() {
        self.model.fetchShop {
            let url = URL(string: self.model.shop.image)
            self.ImageBackView.kf.setImage(with: url)
            self.ShopNameField.text = self.model.shop.shopname
            self.ShopCallField.text = self.model.shop.tel
            self.ShopAccessField.text = self.model.shop.addr
            self.ShopInfoField.text = self.model.shop.text
        }
    }
    
    @objc func screen1() {// selectorで呼び出す場合Swift4からは「@objc」をつける。
//        guard let shopname = ShopNameField.text,
//            let address = ShopAccessField.text,
//            let tel = ShopCallField.text,
//            let text = ShopInfoField.text,
//            let image = ImageBackView.image
//            else { return }
        
//        ShopModel(Defaults[.shopid]).Editshop(shopname: shopname, address: address, tel: tel, text: text, image: image) {
////            self.dismiss(animated: true, completion: nil)
//
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func cameraBtnDidTap() {
        let pickerController = DKImagePickerController()
        
        pickerController.didSelectAssets = { (assets: [DKAsset]) in
            print("didSelectAssets")
            for asset in assets {
                asset.fetchFullScreenImage(true, completeBlock: { (image, info) in
                    if let image = image {
                        self.ImageBackView.image = image
                    }
                })
            }
        }
        
        self.present(pickerController, animated: true) {}
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


