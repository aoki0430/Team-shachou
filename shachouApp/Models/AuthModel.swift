import Alamofire
import SwiftyJSON
import SwiftyUserDefaults

final class AuthModel {
    
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

    func SignUp(name: String?,
                pwd: String?,
                completion: @escaping (_ success: Bool) -> Void) {
        guard let name = name else { return }
        guard let pwd = pwd else { return }
        
        let params = [
            "name": name,
            "pwd": pwd,
        ]
        
        Alamofire.request(urlAuthSignUp, method: .post, parameters: params).responseJSON { response in
            switch response.result {
            case let .success(value):
                let json = JSON(value)
                print(json)
                completion(true)
                Defaults[.shopid] = json["id"].intValue
                Defaults[.isShopAccount] = true
                
            case let .failure(error):
                print(error)
                completion(false)
            }
        }
    }
}

