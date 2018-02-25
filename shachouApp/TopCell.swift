//TODO: SelectShopCellとほぼ一緒になってしまったので、統一しても良いかもしれない

import UIKit
import SnapKit
import Kingfisher
import CoreLocation

final class TopCell: UITableViewCell {
    
    //View
    private let bgView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let photoIV: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "nophoto2")
        iv.tintColor = UIColor.app.dustyOrange
        return iv
    }()
    
    private let shopNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NotoSansCJKjp-Medium", size: 13)
        label.tintColor = UIColor.app.blackTwo
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byCharWrapping
        return label
    }()
    
    private let genreLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 9)
        label.textColor = UIColor.app.untWarmGrey
        return label
    }()
    
    private let placeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 9)
        label.textColor = UIColor.app.untWarmGrey
        return label
    }()
    
    private let genreIV: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "restaurant"))
        iv.tintColor = UIColor.app.untWarmGrey
        return iv
    }()
    
    private let placeIV: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "station"))
        iv.tintColor = UIColor.app.untWarmGrey
        return iv
    }()
    
    private let distanceIV: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "place"))
        iv.tintColor = UIColor.app.untWarmGrey
        return iv
    }()
    
    private let distanceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HiraginoSans-W3", size: 9)
        label.textColor = UIColor.app.untWarmGrey
        return label
    }()
    
    // 以下メモ用のview
    private let memoView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let memoTopLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.app.untWhiteTwo
        return view
    }()
    
    private let memoTitleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.app.dustyOrange
        label.textColor = .white
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.textAlignment = .center
        label.font = UIFont(name: "HiraginoSans-W3", size: 9)
        label.text = "メモ"
        return label
    }()
    
    private let memoContentLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.app.blackTwo
        label.font = UIFont(name: "HiraginoSans-W3", size: 9)
        label.numberOfLines = 0
        return label
    }()
    
    let checkImageView: UIImageView = {
        let view = UIImageView()
        view.isUserInteractionEnabled = false
        return view
    }()
    
    let archiveBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.app.archiveBackgroundViewColor
        view.alpha = 1.0
        return view
    }()
    
    // 以下ListVCのロングプレス用
    let cancelButton: UIButton = {
        let btn = UIButton(frame: .zero)
        btn.tintColor = .white
        
        let icon = UIImageView()
        icon.image = UIImage(named: "batsu-cancel-white")
        icon.contentMode = .scaleAspectFill
        
        btn.addSubview(icon)
        icon.snp.makeConstraints {
            $0.size.equalTo(16)
            $0.center.equalToSuperview()
        }
        
        btn.clipsToBounds = true
        return btn
    }()
    
    let archiveButton: UIButton = {
        let btn = UIButton(frame: .zero)
        btn.tintColor = .white
        
        let icon = UIImageView()
        icon.image = UIImage(named: "delete")
        icon.contentMode = .scaleAspectFill
        
        let fontSize:CGFloat = 12.0
        let iconLabelInset:CGFloat = 12.0 //アイコンとラベルの間の距離
        
        let label = UILabel()
        label.font = UIFont(name: "NotoSansCJKjp-Medium", size: fontSize)
        label.textColor = .white
        label.text = "リストから外す"
        label.sizeToFit()
        
        btn.addSubview(icon)
        btn.addSubview(label)
        
        icon.snp.makeConstraints {
            $0.size.equalTo(24)
            $0.centerY.equalToSuperview().inset(-(fontSize+iconLabelInset)/2+2)
            $0.centerX.equalToSuperview()
        }
        
        label.snp.makeConstraints {
            $0.top.equalTo(icon.snp.bottom).offset(iconLabelInset)
            $0.left.right.equalToSuperview().inset(8)
        }
        
        btn.clipsToBounds = true
        return btn
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // セル選択時のハイライト色を設定
        //        selectionStyle = .none
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.app.warmGray
        selectedBackgroundView = backgroundView
        
        backgroundColor = .clear
        
        contentView.addSubview(bgView)
        bgView.addSubview(photoIV)
        bgView.addSubview(shopNameLabel)
        bgView.addSubview(genreLabel)
        bgView.addSubview(placeLabel)
        bgView.addSubview(genreIV)
        bgView.addSubview(placeIV)
        bgView.addSubview(distanceIV)
        bgView.addSubview(distanceLabel)
        bgView.addSubview(memoView)
        memoView.addSubview(memoTopLine)
        memoView.addSubview(memoTitleLabel)
        memoView.addSubview(memoContentLabel)
        bgView.addSubview(checkImageView)
        
        self.addSubview(self.archiveBackgroundView)
        self.archiveBackgroundView.addSubview(self.cancelButton)
        self.archiveBackgroundView.addSubview(self.archiveButton)
        
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
            $0.left.equalTo(photoIV.snp.right).offset(16)
            $0.right.equalToSuperview().inset(8)
            $0.height.greaterThanOrEqualTo(18)
        }
        placeIV.snp.remakeConstraints {
            $0.top.equalTo(shopNameLabel.snp.bottom).offset(15)
            $0.left.equalTo(shopNameLabel.snp.left)
            $0.size.equalTo(16)
        }
        placeLabel.snp.remakeConstraints {
            $0.centerY.equalTo(placeIV.snp.centerY)
            $0.left.equalTo(placeIV.snp.right).offset(5)
            $0.width.equalTo(50) //TODO: 要検討
        }
        genreIV.snp.remakeConstraints {
            $0.top.equalTo(placeIV.snp.top)
            $0.left.equalTo(placeLabel.snp.right).offset(12)
            $0.size.equalTo(16)
        }
        genreLabel.snp.remakeConstraints {
            $0.centerY.equalTo(genreIV.snp.centerY)
            $0.left.equalTo(genreIV.snp.right).offset(5)
            $0.width.equalTo(60) //TODO: 要検討
        }
        
        distanceIV.snp.remakeConstraints {
            $0.top.equalTo(placeIV.snp.bottom).offset(7)
            $0.left.equalTo(shopNameLabel.snp.left)
            $0.size.equalTo(16)
            $0.bottom.lessThanOrEqualToSuperview().inset(8)
        }
        distanceLabel.snp.remakeConstraints {
            $0.centerY.equalTo(distanceIV.snp.centerY)
            $0.left.equalTo(distanceIV.snp.right).offset(5)
            $0.width.equalTo(100) //TODO: 要検討
        }
        
        memoView.snp.remakeConstraints {
            $0.top.greaterThanOrEqualTo(photoIV.snp.bottom).offset(8)
            $0.top.greaterThanOrEqualTo(distanceIV.snp.bottom).offset(8)
            $0.left.right.bottom.equalToSuperview()
        }
        
        memoTopLine.snp.remakeConstraints {
            $0.height.equalTo(1)
            $0.left.equalTo(placeIV)
            $0.top.equalToSuperview()
            $0.right.equalToSuperview().inset(10)
        }
        
        memoTitleLabel.snp.remakeConstraints {
            $0.width.equalTo(35)
            $0.height.equalTo(17)
            $0.top.equalTo(memoTopLine).inset(8)
            $0.left.equalToSuperview().inset(16)
        }
        
        memoContentLabel.snp.remakeConstraints {
            $0.height.greaterThanOrEqualTo(14)
            $0.top.equalTo(memoTitleLabel).inset(-1)
            $0.left.equalTo(memoTitleLabel.snp.right).offset(8)
            $0.right.bottom.equalToSuperview().inset(8)
        }
        
        checkImageView.snp.makeConstraints {
            $0.size.equalTo(25)
            $0.right.equalToSuperview().inset(15)
            $0.centerY.equalToSuperview()
        }
        
        self.archiveBackgroundView.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalTo(0)
        }
        
        
        cancelButton.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.left.equalToSuperview().inset(30)
        }
        archiveButton.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.right.equalToSuperview().inset(8)
        }
    }
    
    func configure(_ shop: Shop, selected: Bool?, visited: Bool = true, completion: @escaping (UIImage?) -> ()) {
        
        // shopNameの設定（同時にlineHeightを設定する）
        let lineHeight:CGFloat = 18.0
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = lineHeight
        paragraphStyle.maximumLineHeight = lineHeight
        let attributedText = NSMutableAttributedString(string: shop.name)
        attributedText.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedText.length))
        shopNameLabel.attributedText = attributedText
        
        genreLabel.text = shop.genre
        placeLabel.text = shop.access
        
        // memoの設定
        if shop.comment.isEmpty || shop.comment == "<null>" {
            memoView.isHidden = true
            
            memoView.snp.remakeConstraints {
                $0.height.equalTo(0)
            }
            
        } else {
            memoView.isHidden = false
            
            memoView.snp.remakeConstraints {
                $0.top.greaterThanOrEqualTo(photoIV.snp.bottom).offset(8)
                $0.top.greaterThanOrEqualTo(distanceIV.snp.bottom).offset(8)
                $0.left.right.bottom.equalToSuperview()
            }
            // memoContentLabelの設定
            let lineHeight:CGFloat = 14.0
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.minimumLineHeight = lineHeight
            paragraphStyle.maximumLineHeight = lineHeight
            let attributedText = NSMutableAttributedString(string: shop.comment)
            attributedText.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedText.length))
            memoContentLabel.attributedText = attributedText
        }
        
        // 投稿画像 > Yelp の優先度で画像を表示
        photoIV.image = UIImage(named: "nophoto2")
        photoIV.layer.cornerRadius = 0
        photoIV.layer.masksToBounds = true
        
        if !shop.imageURLs.isEmpty {
            photoIV.kf.cancelDownloadTask()
            photoIV.kf.setImage(with: shop.imageURLs[0])
            photoIV.layer.cornerRadius = 5
            photoIV.layer.masksToBounds = true
        } else {
            
            if let yelpImage = shop.tempYelpImage {
                photoIV.image = yelpImage
            } else {
                //電話番号からYelpの画像を取得する
                var phoneNum = ""
                if !shop.contactNum.isEmpty {
                    phoneNum = shop.contactNum
                } else if !shop.reservationNum.isEmpty {
                    phoneNum = shop.reservationNum
                }
                
                if !phoneNum.isEmpty{
                    
                    
                    
                    YelpAPIManager.fetchImage(phoneNum: phoneNum, completion: { imageURLString in
                        if let imageURL = URL(string: imageURLString) {
                            self.photoIV.kf.cancelDownloadTask()
                            self.photoIV.kf.setImage(with: imageURL)
                            self.photoIV.kf.setImage(with: imageURL, placeholder: nil, options: nil, progressBlock: nil, completionHandler: { (image, error, cacheType, url) in
                                completion(image)
                            })
                            self.photoIV.layer.cornerRadius = 5
                            self.photoIV.layer.masksToBounds = true
                        }
                    })
                }
            }
        }
        
        // 距離を計算して表示する
        //        let location = CLLocation(latitude: shop.latitude, longitude: shop.longitude)
        //        let locationManager = LocationManager.shaerd
        //        var distance = locationManager.distanceFromCurrentLocation(to: location)
        var distance = shop.distance
        // 1km以上でkm単位で小数点以下一桁、1km未満でm単位で10m基準で丸めて表示する
        
        if distance >= 1000 {
            self.distanceLabel.text = String(format: "現在地から%.1fkm", distance/1000)
        } else {
            distance = round(distance/10) * 10 // 丸める
            self.distanceLabel.text = String(format: "現在地から%.0fm", distance)
        }
        
        // シェア時のチェックボックスの処理
        if let selected = selected {
            if selected {
                checkImageView.image = UIImage(named: "checkBoxOrange")
            } else {
                checkImageView.image = UIImage(named: "checkBox")
            }
            if checkImageView.isHidden {
                checkImageView.alpha = 0.0
                checkImageView.isHidden = false
                UIView.animate(withDuration: 0.15, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                    self.checkImageView.alpha = 1.0
                }, completion: nil)
            }
        } else {
            if checkImageView.isHidden == false {
                checkImageView.alpha = 1.0
                UIView.animate(withDuration: 0.1, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                    self.checkImageView.alpha = 0.0
                }, completion: { animated in
                    self.checkImageView.isHidden = true
                })
            }
        }
    }
    
    func addLongPressEvent() {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.longPress(_:)))
        longPressGesture.minimumPressDuration = 0.2
        longPressGesture.allowableMovement = 150
        self.addGestureRecognizer(longPressGesture)
        self.selectionStyle = .none
    }
    
    func removeLongPressEvent() {
        if let recognizers = self.gestureRecognizers {
            for item in recognizers {
                self.removeGestureRecognizer(item)
            }
        }
    }
    
    // Long Press イベント
    @objc func longPress(_ sender: UILongPressGestureRecognizer){
        if sender.state == .began {
            
            cancelButton.addTarget(self, action: #selector(self.hideArchiveView), for: .touchUpInside)
            //            //archiveを押した時に、archiveのViewを消すため
            //            archiveButton.addTarget(self, action: #selector(self.hideArchiveView), for: .touchUpInside)
            
            // タップしてもセルが反応しないようにする
            let tapGestureRecognizer = UITapGestureRecognizer(target: nil, action: nil)
            self.archiveBackgroundView.addGestureRecognizer(tapGestureRecognizer)
            
            archiveBackgroundView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
            
            // 以下アニメーション
            UIView.animate(withDuration:0.2, animations: {() -> Void in
                self.layoutIfNeeded()
            })
        }
    }
    
    @objc func hideArchiveView() {
        self.archiveBackgroundView.snp.removeConstraints()
        self.archiveBackgroundView.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalTo(0)
        }
        UIView.animate(withDuration:0.2, animations: {() -> Void in
            self.layoutIfNeeded()
        })
    }
    
}

