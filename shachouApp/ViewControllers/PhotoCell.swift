import UIKit
import Kingfisher

final class PhotoCell: UICollectionViewCell {
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .brown
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame _: CGRect) {
        super.init(frame: .zero)
        self.addSubview(imageView)
        self.backgroundColor = .white
        
        self.clipsToBounds = true
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func configure(image: UIImage, hasDeleteButton:Bool = false) {
//        self.imageView.image = image
//        self.backgroundColor = .white
//
//        self.imageView.contentMode = .scaleAspectFill
//
//        //        self.imageView.layoutEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//
//        self.imageView.snp.remakeConstraints {
//            $0.left.equalToSuperview()
//            $0.right.equalToSuperview().inset(6)
//            $0.top.bottom.equalToSuperview().inset(18)
//        }
//    }
    func configure(_ item: Item, completion: @escaping (String?) -> ()) {
        // shopNameの設定（同時にlineHeightを設定する）
//        let lineHeight:CGFloat = 18.0
//        let paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.minimumLineHeight = lineHeight
//        paragraphStyle.maximumLineHeight = lineHeight
//        let attributedText = NSMutableAttributedString(string: item.itemname)
//        attributedText.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedText.length))
//        shopNameLabel.attributedText = attributedText
//
//
//        photoIV.image = UIImage(named: "nophoto")
//        photoIV.layer.cornerRadius = 0
//        photoIV.layer.masksToBounds = true
        
        if item.image != "" {
            let url = URL(string: item.image)
            imageView.kf.cancelDownloadTask()
            imageView.kf.setImage(with: url)
            imageView.layer.cornerRadius = 5
            imageView.layer.masksToBounds = true
            imageView.image = imageView.image?.resize(toWidth: 80)
            imageView.image = imageView.image?.resize(toHeight: 80)
        }
        
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
}

