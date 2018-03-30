import Alamofire
import SwiftyJSON
import SwiftyUserDefaults
import Kingfisher

final class AuthModel {
    var shop = Shop()
    var shops = [Shop]()
    
//    func Login(email: String?,
//               password: String?,
//               completion: @escaping (_ success: Bool, _ error: String) -> Void) {
//
//        guard let email = email else { return }
//        guard let password = password else { return }
//
//        let params = [
//            "email": email,
//            "password": password,
//        ]
//        Alamofire.request(urlAuthSignIn, method: .post, parameters: params).responseJSON { response in
//            switch response.result {
//            case let  .success(value):
//                let json = JSON(value)
//                print(debug: json)
//                if let error = json["errros"].array?.first?.string {
//                    completion(false, error)
//                    return
//                }
//
//                guard let allHeaderFields = response.response?.allHeaderFields else { return }
//                let header = JSON(allHeaderFields)
//                keychain["email"] = email
//                Defaults[.id] = (json["data"].dictionary!["id"]?.intValue)!
//                print(Defaults[.id])
//                completion(true, "")
//
//            case let .failure(error):
//                print(debug: error)
//            }
//        }
//    }

    func UserSignUp(name: String?,
                pwd: String?,
                completion: @escaping (_ success: Bool) -> Void) {
        guard let name = name else { return }
        guard let pwd = pwd else { return }
        
        let params = [
            "name": name,
            "pwd": pwd,
        ]
        
        Alamofire.request(urlUserSignUp, method: .post, parameters: params).responseJSON { response in
            switch response.result {
            case let .success(value):
                let json = JSON(value)
                print(json)
                completion(true)
                
            case let .failure(error):
                print(error)
                completion(false)
            }
        }
    }
    
    func ShopSignUp(name: String?,
                    pwd: String?,
                    completion: @escaping (_ success: Bool) -> Void) {
        guard let name = name else { return }
        guard let pwd = pwd else { return }
        
        let params = [
            "name": name,
            "pwd": pwd,
            ]
        
        Alamofire.request(urlShopSignUp, method: .post, parameters: params).responseString { response in
            switch response.result {
            case let .success(value):
                let json = JSON(value)
                print(json)
                completion(true)
                
            case let .failure(error):
                print(error)
                completion(false)
            }
        }
    }
    
    func CreateShop(shopname: String,
                    image: UIImage,
                    completion: @escaping (_ succes:Bool) -> Void) {
        guard let data = UIImagePNGRepresentation(image) else { return }
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                // 送信する値の指定をここでします
                multipartFormData.append(data, withName: "image", fileName: "image", mimeType: "image/png")
                multipartFormData.append(shopname.data(using: String.Encoding.utf8)!, withName: "shopname")
        },
            
            to: urlCreateShop,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        switch response.result {
                        case let .success(value):
                            let json = JSON(value)
                            print(json)
//                            self.shops.removeAll()
//                            json.arrayValue.forEach { json in
//                                self.shops.append(Shop(json))
//                            }
                            self.shop = Shop(json)
                            Defaults[.shopid] = self.shop.id
                            Defaults[.isShopAccount] = true
                            completion(true)
                            
                        case let .failure(error):
                            print(error)
                            completion(false)
                        }
                    }
                case .failure(let encodingError):
                    // 失敗
                    print(encodingError)
                    completion(false)
                }
        }
        )
    }
}

