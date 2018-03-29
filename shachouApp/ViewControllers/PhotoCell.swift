import UIKit
import SnapKit
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
        
        self.imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ item: Item, completion: @escaping (String?) -> ()) {

        self.imageView.contentMode = .scaleAspectFill
        
        if item.image != "" {
            let url = URL(string: item.image)
            imageView.kf.cancelDownloadTask()
            imageView.kf.setImage(with: url)
//            imageView.layer.cornerRadius = 5
            imageView.layer.masksToBounds = true
            imageView.image = imageView.image?.resize(toWidth: 100)
            imageView.image = imageView.image?.resize(toHeight: 200)
        }
        
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
}

