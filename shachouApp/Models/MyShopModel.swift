import SwiftyJSON
import Alamofire

final class MyShopModel {
    var shopID: Int
    var shareImage = UIImage()
    var urls = [String]()
    var selectedListIDs = [Int]()
    var selectedIndexes = [Int]()
    
    init(_ shopID: Int) {
        self.shopID = shopID
    }
    
    func sendShopInfo(shopID: Int,
                      shopname: String,
                      address: String,
                      tel: Int, text: String,
                      Image: URL,
                      completion: @escaping (_ success: Bool) -> Void) {
        
        let params = [
            "id": shopID,
            "shopname": shopname,
            "addr": address,
            "tel": tel,
            "text": text,
            "image": Image,
            ] as [String : Any]
        
        let url = "sendurl"
        Alamofire.request(url, method: .post, parameters: params).responseJSON { response in
            switch response.result {
            case let .success(value):
                completion(true)
                
            case let .failure(error):
                print(error)
                completion(false)
            }
            
        }
        
    }
    
    func getShopInfo(completion: @escaping () -> Void) {
        
        Alamofire.request(urlShops + "/\(shopID)", method: .get).responseJSON { [weak self] response in
            guard let strongSelf = self else { return }
            switch response.result {
            case let .success(value):
                let json = JSON(value)
                print(json)
                strongSelf.shopID =
//                guard let shopname = json[""] else { return }
                completion()
                //                guard let allHeaderFields = response.response?.allHeaderFields else { return }
                //                let header = JSON(allHeaderFields)
                //                guard let email = json["data"]["email"].string else { return }
                //                keychain["email"] = email
                //                Defaults[.id] = (json["data"].dictionary!["id"]?.intValue)!
                //                print(Defaults[.id])
                //                completion(true)
                
            case let .failure(error):
                print(error)
                completion()
            }
            
        }
        
    }
    
}

