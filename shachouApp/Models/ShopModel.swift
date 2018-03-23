import UIKit
import Alamofire
import SwiftyJSON

final class ShopModel {
    let shopID: Int
    var shop = Shop()
    var item = Item()
    var items = [Item]()
//    var shops = [Shop]()
    
    init(_ shopID: Int) {
        self.shopID = shopID
    }
    
    func sendShopInfo(shopname: String,
                      address: String,
                      tel: Int,
                      text: String,
                      Image: URL,
                      completion: @escaping (_ success: Bool) -> Void) {
        
        let params = [
            "shopname": shopname,
            "addr": address,
            "tel": tel,
            "text": text,
            "image": Image,
            ] as [String : Any]
        
        Alamofire.request(urlEditShop, method: .post, parameters: params).responseJSON { response in
            switch response.result {
            case let .success(value):
                let json  = JSON(value)
                print(json)
                completion(true)
                
            case let .failure(error):
                print(error)
                completion(false)
            }
        }
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
    
    func getAllItem(completion: @escaping ()->Void) {
        Alamofire.request(urlGetAllItem, method: .get).responseJSON { [weak self] response in
            guard let strongSelf = self else { return }
            switch response.result {
            case let .success(value) :
                let json = JSON(value)
                print(json)
                json.arrayValue.forEach { json in
                    strongSelf.items.append(Item(json))
                }
                completion()
            case let .failure(error) :
                print(error)
                completion()
            }
            
        }
        
    }
    
    
}
