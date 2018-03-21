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
        label.tintColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byCharWrapping
        return label
    }()
    
    // 以下メモ用のview
    private let memoView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let memoTopLine: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    private let memoTitleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .black
        label.textColor = .white
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.textAlignment = .center
//        label.font = UIFont(name: "HiraginoSans-W3", size: 9)
        label.text = "メモ"
        return label
    }()
    
    private let memoContentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
//        label.font = UIFont(name: "HiraginoSans-W3", size: 9)
        label.numberOfLines = 0
        return label
    }()
    
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
        bgView.addSubview(memoView)
        memoView.addSubview(memoTopLine)
        memoView.addSubview(memoTitleLabel)
        memoView.addSubview(memoContentLabel)
        
        makeConstraints()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeConstraints() {

        bgView.snp.remakeConstraints {
            $0.edges.equalToSuperview().inset(1)
        }
        
        photoIV.snp.remakeConstraints {
            $0.top.left.equalToSuperview().inset(8)
            $0.bottom.lessThanOrEqualToSuperview().inset(8)
            $0.size.equalTo(80)
        }
        
        shopNameLabel.snp.remakeConstraints {
            $0.top.equalTo(photoIV)
            $0.left.equalTo(photoIV.snp.right).offset(13)
            $0.right.equalToSuperview().inset(8)
            $0.height.greaterThanOrEqualTo(18)
//                        $0.height.equalTo(36)
        }

        memoView.snp.remakeConstraints {
            $0.top.greaterThanOrEqualTo(photoIV.snp.bottom).offset(8)
            $0.top.greaterThanOrEqualTo(shopNameLabel.snp.bottom).offset(8)
            $0.left.right.bottom.equalToSuperview()
        }
        
        memoTopLine.snp.remakeConstraints {
            $0.height.equalTo(1)
            $0.left.equalToSuperview().inset(50)
            $0.top.right.equalToSuperview()
        }
        
        memoTitleLabel.snp.remakeConstraints {
            $0.width.equalTo(35)
            $0.height.equalTo(17)
            $0.centerY.equalTo(memoContentLabel)
            $0.left.equalToSuperview().inset(16)
        }
        
        memoContentLabel.snp.remakeConstraints {
            $0.height.greaterThanOrEqualTo(14)
            $0.top.equalTo(memoTopLine).offset(9)
            $0.left.equalTo(memoTitleLabel.snp.right).offset(8)
            $0.right.bottom.equalToSuperview().inset(8)
        }
        
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
    
   
