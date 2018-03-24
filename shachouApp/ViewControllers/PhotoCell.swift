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
    
    func configure(image: UIImage, hasDeleteButton:Bool = false) {
        self.imageView.image = image
        self.backgroundColor = .white
        
        self.imageView.contentMode = .scaleAspectFill
        
        //        self.imageView.layoutEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        self.imageView.snp.remakeConstraints {
            $0.left.equalToSuperview()
            $0.right.equalToSuperview().inset(6)
            $0.top.bottom.equalToSuperview().inset(18)
        }
    }
    
    func remakeCametaAlbumDesign() {
        self.imageView.tintColor = .black
        self.imageView.contentMode = .center
        //        self.imageView.snp.remakeConstraints {
        //            $0.edges.equalToSuperview().inset(40)
        ////        }
        //        self.imageView.imageinse
        //        self.imageView.layoutEdgeInsets = UIEdgeInsets(top: -18, left: -18, bottom: -18, right: -18)
        self.imageView.backgroundColor = .brown
        //        self.backgroundColor = UIColor.app.cameraButtonBackgroundColor
    }
    
}

