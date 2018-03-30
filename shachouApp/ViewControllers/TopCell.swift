

import UIKit
import SnapKit
import Kingfisher

class TopCell: UITableViewCell {

    private let bgView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    private let photoIV: UIImageView = {
        let iv = UIImageView()
        iv.tintColor = .black
        return iv
    }()

    private let shopNameLabel: UILabel = {
        let label = UILabel()
        //        label.font = UIFont(name: "NotoSansCJKjp-Medium", size: 13)
        label.textColor = UIColor.white
        label.font = .boldSystemFont(ofSize: 25)
        label.layer.cornerRadius = 2
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byCharWrapping
        return label
    }()
    
//    private var shopInformationLabel: UILabel = {
//        let label = UILabel()
//        label.tintColor = .black
//        label.textAlignment = .center
//        label.numberOfLines = 0
//        label.lineBreakMode = NSLineBreakMode.byCharWrapping
//        label.text = "メモ"
//        return label
//    }()



    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        //        selectionStyle = .none
        let backgroundView = UIView()
        backgroundView.backgroundColor = .black
        selectedBackgroundView = backgroundView

        contentView.backgroundColor = .black

        //        contentView.addSubview(lowerView)
        //        lowerView.addSubview(bgView)
        contentView.addSubview(bgView)
        bgView.addSubview(photoIV)
        bgView.addSubview(shopNameLabel)
//        bgView.addSubview(shopInformationLabel)

        makeConstraints()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func makeConstraints() {

        bgView.snp.remakeConstraints {
            $0.edges.equalToSuperview().inset(1)
            $0.bottom.equalTo(photoIV.snp.bottom).offset(3)
//            $0.bottom.equalTo(shopInformationLabel.snp.bottom).offset(2)
        }

        photoIV.snp.remakeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(250)
            //            $0.top.left.equalToSuperview().inset(8)
            $0.bottom.lessThanOrEqualToSuperview().inset(25)
        }

        shopNameLabel.snp.remakeConstraints {
            $0.bottom.equalTo(photoIV.snp.bottom).inset(13)
            $0.left.equalTo(photoIV.snp.left).inset(13)
            $0.height.equalTo(30)
        }
//
//        shopInformationLabel.snp.remakeConstraints{
//            $0.top.equalTo(shopNameLabel.snp.bottom).offset(5)
//            $0.left.equalTo(shopNameLabel.snp.left).inset(7.5)
//            $0.height.equalTo(50)
//        }
        
//        bgView.snp.remakeConstraints {
//            $0.edges.equalToSuperview().inset(1)
//        }
//
//        photoIV.snp.remakeConstraints {
//            $0.top.left.equalToSuperview().inset(8)
//            $0.bottom.lessThanOrEqualToSuperview().inset(8)
//            $0.size.equalTo(80)
//        }
//
//        shopNameLabel.snp.remakeConstraints {
//            $0.top.equalTo(photoIV)
//            $0.left.equalTo(photoIV.snp.right).offset(13)
//            $0.right.equalToSuperview().inset(8)
//            $0.height.greaterThanOrEqualTo(18)
//            //                        $0.height.equalTo(36)
//        }



    }

    func configure(_ shop: Shop, completion: @escaping (String?) -> ()) {
        // shopNameの設定（同時にlineHeightを設定する）
        let lineHeight:CGFloat = 18.0
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = lineHeight
        paragraphStyle.maximumLineHeight = lineHeight
        let attributedText = NSMutableAttributedString(string: shop.shopname)
        attributedText.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedText.length))
        shopNameLabel.attributedText = attributedText
        
//        shopInformationLabel.text = shop.text


        photoIV.image = UIImage(named: "nophoto")
        photoIV.layer.cornerRadius = 0
        photoIV.layer.masksToBounds = true

        if shop.image != "" {
            let url = URL(string: shop.image)
            photoIV.kf.cancelDownloadTask()
            photoIV.kf.setImage(with: url)
            photoIV.layer.cornerRadius = 5
            photoIV.layer.masksToBounds = true
            photoIV.image = photoIV.image?.resize(toWidth: 80)
            photoIV.image = photoIV.image?.resize(toHeight: 80)
        }

        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
}


