import SwiftyJSON
import Alamofire

final class  TopModel {
    var shop = Shop()
    var shops = [Shop]()
    
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
        
        let url = "sendurl"
        Alamofire.request(urltopmodel, method: .post, parameters: params).responseJSON { response in
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
    
    func getShopInfo(completion: @escaping () -> Void) {
        
        Alamofire.request(urltopmodel, method: .get).responseJSON { [weak self] response in
            guard let strongSelf = self else { return }
            switch response.result {
            case let .success(value):
                let json = JSON(value)
                print(json)
                strongSelf.shops.removeAll()
                json.arrayValue.forEach { json in
                    strongSelf.shops.append(Shop(json))
                }
                print(self?.shops)
                completion()
            case let .failure(error):
                print(error)
                completion()
            }
            
        }
        
    }
    
}

