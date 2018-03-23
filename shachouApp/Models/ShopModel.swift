import UIKit
import Alamofire
import SwiftyJSON

final class ShopModel {
    let shopID: Int
    var shop = Shop()
//    var shops = [Shop]()
    
    init(_ shopID: Int) {
        self.shopID = shopID
    }
    
    func fetchShop(completion: @escaping () -> Void) {
        let url = urlshop + "/\(shopID)"
        Alamofire.request(url, method: .get).validate().responseJSON { [weak self] response in
            guard let strongSelf = self else { return }
            switch response.result {
            case let .success(value):
                let json = JSON(value)
                print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
                print(json)
                print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
//                strongSelf.shops.removeAll()
//                json.arrayValue.forEach { json in
//                    strongSelf.shops.append(Shop(json))
//                }
//                if let shops = self?.shops, let shopID = self?.shopID {
//                    strongSelf.shop = shops[shopID]
//                }
                strongSelf.shop = Shop(json)
                completion()
            case let .failure(error):
                print(error)
            }
        }
    }
}
