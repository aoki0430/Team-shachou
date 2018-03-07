import Foundation
import SwiftyUserDefaults
//MyPagePresenterを参照

final class MyShopPresenter {
    private let model = MyShopModel()
    
    var shopImageURL: URL? {
        return self.model.shop?.imageURL
    }
    
    var shopName: String {
        return self.model.shop?.shopname
    }
    
    var concept: String {
        return self.model.shop?.concept
    }
    
    func fetch(completion: @escaping () -> Void) {
        self.model.fetchShop {
            completion()
        }
    }
}
