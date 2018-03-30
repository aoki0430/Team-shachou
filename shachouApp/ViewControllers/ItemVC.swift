
import UIKit
import SnapKit
import ZoomTransitioning

class ItemVC: UIViewController {
    let model : ItemModel
    
    init(itemID: Int) {
        model = ItemModel(itemID)
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var largeImageView = UIImageView()
    
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
        self.fetchItem()
        self.view.addSubview(ImageView)
        self.view.addSubview(ItemNameLabel)
        self.view.addSubview(SizeLabel)
        self.view.addSubview(ItemTextLabel)
        
        ImageView.snp.makeConstraints{
            $0.height.equalTo(250)
            $0.width.equalToSuperview()
            $0.top.equalToSuperview().offset(65)
        }
        
        ItemNameLabel.snp.makeConstraints{
            $0.height.equalTo(70)
            $0.width.equalToSuperview()
            $0.top.equalTo(ImageView.snp.bottom).offset(2)
        }
        
        SizeLabel.snp.makeConstraints{
            $0.height.equalTo(70)
            $0.width.equalToSuperview()
            $0.top.equalTo(ItemNameLabel.snp.bottom).offset(2)
        }
        
        ItemTextLabel.snp.makeConstraints{
            $0.height.equalTo(70)
            $0.width.equalToSuperview()
            $0.top.equalTo(SizeLabel.snp.bottom).offset(2)
        }
        
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

extension ItemVC: ZoomTransitionSourceDelegate {
    
    func transitionSourceImageView() -> UIImageView {
        return ImageView
    }
    
    func transitionSourceImageViewFrame(forward: Bool) -> CGRect {
        return ImageView.convert(ImageView.bounds, to: view)
    }
    
    func transitionSourceWillBegin() {
        ImageView.isHidden = true
    }
    
    func transitionSourceDidEnd() {
        ImageView.isHidden = false
    }
    
    func transitionSourceDidCancel() {
        ImageView.isHidden = false
    }
}


// MARK: - ZoomTransitionDestinationDelegate
extension ItemVC: ZoomTransitionDestinationDelegate {
    
    func transitionDestinationImageViewFrame(forward: Bool) -> CGRect {
        if forward {
            let x: CGFloat = 0.0
            let y = topLayoutGuide.length
            let width = view.frame.width
            let height = width * 2.0 / 3.0
            return CGRect(x: x, y: y, width: width, height: height)
        } else {
            return largeImageView.convert(largeImageView.bounds, to: view)
        }
    }
    
    func transitionDestinationWillBegin() {
        largeImageView.isHidden = true
    }
    
    func transitionDestinationDidEnd(transitioningImageView imageView: UIImageView) {
        largeImageView.isHidden = false
        largeImageView.image = imageView.image
    }
    
    func transitionDestinationDidCancel() {
        largeImageView.isHidden = false
    }
}
