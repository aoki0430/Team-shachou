import SwiftyJSON
import Alamofire

final class  TopModel {
    var shop = Shop()
    var shops = [Shop]()
    
    func getShopInfo(completion: @escaping () -> Void) {
        
        Alamofire.request(urlGetAllShop, method: .get).responseJSON { [weak self] response in
            guard let strongSelf = self else { return }
            switch response.result {
            case let .success(value):
                let json = JSON(value)
                print(json)
                strongSelf.shops.removeAll()
                json.arrayValue.forEach { json in
                    strongSelf.shops.append(Shop(json))
                }
                print(self?.shops as Any)
                completion()
            case let .failure(error):
                print(error)
                completion()
            }
            
        }
        
    }
    
}

