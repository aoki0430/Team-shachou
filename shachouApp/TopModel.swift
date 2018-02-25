//import UIKit
//import Alamofire
//import SwiftyJSON
//import SwiftyUserDefaults
//
//struct List {
//    let id: Int
//    let name: String
//    let url: URL?
//
//    init() {
//        id = 0
//        name = ""
//        url = nil
//    }
//
//    init(_ json: JSON) {
//        id = json["id"].intValue
//        name = json["name"].stringValue
//        url = json["url"].url
//    }
//}
//
//final class TopModel {
//    var nearShop: Shop?
//
//    func fetchShareLink(shops: [Shop], completion: @escaping (_ token: String) -> Void) {
//        guard let accessToken = accessToken, let client = client, let email = email else { return }
//        let headers = [
//            "Uid": email,
//            "Access-Token": accessToken,
//            "Client": client,
//            ]
//        let shopIDs = shops.map { $0.id }
//        let params: [String: [String: Any]] = ["share_link": ["shop_ids": shopIDs]]
//        let url = urlShareLink
//
//        print(debug: url)
//        Alamofire.request(url, method: .post, parameters: params, headers: headers).validate().responseJSON { response in
//            switch response.result {
//            case let .success(value):
//                let json = JSON(value)
//                print(debug: json)
//                completion(json["url"].string!)
//            case let .failure(error):
//                Alert.show(message: error.localizedDescription)
//                print(error)
//            }
//        }
//    }
//
//    var lists = [List]()
//    func fetchLists(completion: @escaping () -> Void, failure: @escaping () -> Void) {
//
//        guard let accessToken = accessToken, let client = client, let email = email else { return }
//
//        let headers = [
//            "Uid": email,
//            "Access-Token": accessToken,
//            "Client": client,
//            ]
//        Alamofire.request(urlLists, method: .get, headers: headers).validate().responseJSON { [weak self] response in
//            guard let strongSelf = self else { return }
//            switch response.result {
//            case let .success(value):
//                let json = JSON(value)
//                print(json)
//                strongSelf.lists = json["lists"].arrayValue.map { List($0) }
//                completion()
//            case let .failure(error):
//                // 401ならトークンが変更されているので、再ログインを促す
//                if response.response?.statusCode != 401 {
//                    Alert.show(message: error.localizedDescription)
//                } else {
//                    Alert.showLogin()
//                }
//                failure()
//            }
//        }
//    }
//
//    func fetchListsForGuest(completion: @escaping () -> Void, failure: @escaping () -> Void) {
//        //listIDを添えてあげないと表示できない
//        var url = urlGuestLists + "?"
//        Defaults[.guestLists].forEach {
//            url += "list_ids[]=\($0)&"
//        }
//
//        Alamofire.request(url, method: .get).validate().responseJSON { [weak self] response in
//            guard let strongSelf = self else { return }
//            switch response.result {
//            case let .success(value):
//                let json = JSON(value)
//                print(json)
//                strongSelf.lists = json["lists"].arrayValue.map { List($0) }
//                completion()
//            case let .failure(error):
//                // 401ならトークンが変更されているので、再ログインを促す
//                if response.response?.statusCode != 401 {
//                    Alert.show(message: error.localizedDescription)
//                } else {
//                    Alert.showLogin()
//                }
//                failure()
//            }
//        }
//    }
//}
//
