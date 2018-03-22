import UIKit
import Alamofire
import SwiftyJSON

final class ShopModel {
    let shopID: Int
    var shop = Shop()
    
    init(_ shopID: Int) {
        self.shopID = shopID
    }
    
    func fetchShop(completion: @escaping () -> Void) {
        
        Alamofire.request(urlshopmodel, method: .get).validate().responseJSON { [weak self] response in
            guard let strongSelf = self else { return }
            switch response.result {
            case let .success(value):
                let json = JSON(value)
                print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
                print(json)
                print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
                
                strongSelf.shop = Shop(json)
                strongSelf.shop.text = json["text"].stringValue
                completion()
            case let .failure(error):
                print(error)
            }
        }
    }
}
