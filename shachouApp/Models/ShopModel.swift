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
    
    func Editshop(shopname: String,
                  address: String,
                  tel: String,
                  text: String,
                  image: UIImage,
                  completion: @escaping () -> Void) {
        
        guard let data = UIImagePNGRepresentation(image) else { return }
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                // 送信する値の指定をここでします
                multipartFormData.append(data, withName: "image", fileName: "image", mimeType: "image/png")
                multipartFormData.append(shopname.data(using: String.Encoding.utf8)!, withName: "shopname")
                multipartFormData.append(address.data(using: String.Encoding.utf8)!, withName: "addr")
                multipartFormData.append(tel.data(using: String.Encoding.utf8)!, withName: "tel")
                multipartFormData.append(text.data(using: String.Encoding.utf8)!, withName: "text")
        },
            
            to: urlEditItem,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        // 成功
                        let responseData = response
                        print(responseData )
                    }
                case .failure(let encodingError):
                    // 失敗
                    print(encodingError)
                }
        }
        )
    }
    
    func getAllItem(completion: @escaping ()->Void) {
        let url = urlGetAllItem + "/\(shopID)"
        Alamofire.request(url, method: .get).responseJSON { [weak self] response in
            guard let strongSelf = self else { return }
            strongSelf.items.removeAll()
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
