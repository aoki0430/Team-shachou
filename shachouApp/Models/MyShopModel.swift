import SwiftyJSON
import Alamofire

final class ShopModel {
    
    func sendShopInfo(shopname: String,
                      address: String,
                      tel: Int, text: String,
                      Image: URL,
                      completion: @escaping (_ success: Bool) -> Void) {
        
        let params = [
            "shopname": shopname,
            "addr": address,
            "tel": tel,
            "text": text,
            "image": Image,
            ] as [String : Any]
        
        let url = ""
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
    
    func getShopInfo(shopname: String,
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
        
        let url = ""
        Alamofire.request(url, method: .post, parameters: params).responseJSON { response in
            switch response.result {
            case let .success(value):
                let json = JSON(value)
//                guard let shopname = json[""] else { return }
                completion(true)
                //                guard let allHeaderFields = response.response?.allHeaderFields else { return }
                //                let header = JSON(allHeaderFields)
                //                guard let email = json["data"]["email"].string else { return }
                //                keychain["email"] = email
                //                Defaults[.id] = (json["data"].dictionary!["id"]?.intValue)!
                //                print(Defaults[.id])
                //                completion(true)
                
            case let .failure(error):
                print(error)
                completion(false)
            }
            
        }
        
    }
    
}

