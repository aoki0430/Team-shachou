import UIKit
import Alamofire
import SwiftyJSON
//import CoreLocation //暫定

//final class ShopModel {
//    let shopID: Int
//    var shop = Shop()
//    var shareImage = UIImage()
//    var lists = [List]()
//    var urls = [String]()
//    var selectedListIDs = [Int]()
//    var selectedIndexes = [Int]()
//    let headerImages = [UIImage(named: "memo"), UIImage(named: "photo"), UIImage(named: "addList")]
//    let headerTexts = ["お店メモを追加", "お店の写真を追加", "追加したいリストをタップ"]
//    var listID = 0
//    var editType = EditType.noEdit
//    var isVisited = true
//    
//    enum EditType {
//        case edited
//        case deleted
//        case noEdit
//    }
//    
//    init(_ shopID: Int, _ checkInID: Int, _ listID: Int) {
//        self.shopID = shopID
//        self.listID = listID
//    }
//    
//    func fetchShop(completion: @escaping () -> Void) {
//        print(debug: urlShops + "/\(shopID)")
//        
//        guard let accessToken = accessToken, let client = client, let email = email else { return }
//        let headers = [
//            "Uid": email,
//            "Access-Token": accessToken,
//            "Client": client,
//            ]
//        
//        Alamofire.request(urlShops + "/\(shopID)", method: .get, headers: headers).validate().responseJSON { [weak self] response in
//            guard let strongSelf = self else { return }
//            switch response.result {
//            case let .success(value):
//                let json = JSON(value)
//                print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
//                print(json)
//                print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
//                
//                strongSelf.shop = Shop(json)
//                strongSelf.shop.rank = json["rank"].intValue
//                strongSelf.shop.visitedCount = json["visited_count"].intValue
//                strongSelf.shop.comment = json["comment"].stringValue
//                self?.editType = .noEdit
//                if strongSelf.shop.visitedCount == 0 {
//                    strongSelf.isVisited = false
//                } else {
//                    strongSelf.isVisited = true
//                }
//                
//                //                // TODO:暫定的にShopVCでのdistanceをiOS側で計算する
//                //                let locationManager = LocationManager.shaerd
//                //                let location = CLLocation(latitude: strongSelf.shop.latitude, longitude: strongSelf.shop.longitude)
//                //                strongSelf.shop.distance = locationManager.distanceFromCurrentLocation(to: location)
//                
//                
//                completion()
//            case let .failure(error):
//                Alert.show(message: error.localizedDescription)
//                print(error)
//            }
//        }
//    }
//    
//    func fetchShopForGuest(completion: @escaping () -> Void) {
//        print(debug: urlShops + "/\(shopID)")
//        Alamofire.request(urlGuestShops + "/\(shopID)", method: .get).validate().responseJSON { [weak self] response in
//            guard let strongSelf = self else { return }
//            switch response.result {
//            case let .success(value):
//                let json = JSON(value)
//                print("お店の情報")
//                print(json)
//                
//                strongSelf.shop = Shop(json)
//                strongSelf.shop.rank = json["rank"].intValue
//                strongSelf.shop.visitedCount = json["visited_count"].intValue
//                strongSelf.shop.comment = json["comment"].stringValue
//                self?.editType = .noEdit
//                if strongSelf.shop.visitedCount == 0 {
//                    strongSelf.isVisited = false
//                } else {
//                    strongSelf.isVisited = true
//                }
//                completion()
//            case let .failure(error):
//                Alert.show(message: error.localizedDescription)
//                print(error)
//            }
//        }
//    }
//    
//    //TODO: 旧メソッド、要削除
//    func shopEdit(comment: String, completion: @escaping () -> Void) {
//        var params:[String:Any]
//        if comment == "" {
//            params = [
//                "shop":
//                    [
//                        "comment": NSNull(),
//                        "image_urls": urls,
//                        "list_ids": selectedListIDs,
//                ],
//            ]
//        } else {
//            params = [
//                "shop":
//                    [
//                        "comment": comment,
//                        "image_urls": urls,
//                        "list_ids": selectedListIDs,
//                ],
//            ]
//        }
//        
//        guard let accessToken = accessToken, let client = client, let email = email else { return }
//        let headers = [
//            "Uid": email,
//            "Access-Token": accessToken,
//            "Client": client,
//            ]
//        let url = "\(urlUserShops)/\(shopID)/"
//        print(url)
//        Alamofire.request(url, method: .put, parameters: params, headers: headers).validate().responseJSON { response in
//            
//            switch response.result {
//            case .success:
//                self.editType = .edited
//                completion()
//            case let .failure(error):
//                Alert.show(message: error.localizedDescription)
//                print(debug: error)
//            }
//        }
//    }
//    
//    func editShop(completion: @escaping () -> Void) {
//        var params:[String:Any]
//        
//        var imageURLStrings = [String]()
//        
//        self.shop.imageURLs.forEach { (url) in
//            if let url = url {
//                imageURLStrings.append(url.absoluteString)
//            }
//        }
//        
//        if self.shop.comment.isEmpty {
//            params = [
//                "shop":
//                    [
//                        "comment": NSNull(),
//                        "image_urls": imageURLStrings,
//                        "list_ids": selectedListIDs,
//                ],
//            ]
//        } else {
//            params = [
//                "shop":
//                    [
//                        "comment": self.shop.comment,
//                        "image_urls": imageURLStrings,
//                        "list_ids": selectedListIDs,
//                ],
//            ]
//        }
//        
//        guard let accessToken = accessToken, let client = client, let email = email else { return }
//        let headers = [
//            "Uid": email,
//            "Access-Token": accessToken,
//            "Client": client,
//            ]
//        let url = "\(urlUserShops)/\(shopID)/"
//        print(url)
//        Alamofire.request(url, method: .put, parameters: params, headers: headers).validate().responseJSON { response in
//            
//            switch response.result {
//            case .success:
//                self.editType = .edited
//                
//                completion()
//            case let .failure(error):
//                Alert.show(message: error.localizedDescription)
//                print(debug: error)
//            }
//        }
//    }
//    
//    func saveInList(listID: Int, completion: @escaping () -> Void) {
//        self.selectedListIDs.removeAll()
//        self.shop.lists.forEach {
//            self.selectedListIDs.append($0.id)
//        }
//        self.selectedListIDs.append(listID)
//        let params:[String:Any] = [
//            "shop":
//                [
//                    "list_ids": self.selectedListIDs,
//            ],
//            ]
//        
//        guard let accessToken = accessToken, let client = client, let email = email else { return }
//        let headers = [
//            "Uid": email,
//            "Access-Token": accessToken,
//            "Client": client,
//            ]
//        let url = "\(urlUserShops)/\(shopID)/"
//        print(url)
//        Alamofire.request(url, method: .put, parameters: params, headers: headers).validate().responseJSON { response in
//            
//            switch response.result {
//            case .success:
//                self.editType = .edited
//                completion()
//            case let .failure(error):
//                Alert.show(message: error.localizedDescription)
//                print(debug: error)
//            }
//        }
//    }
//    
//    func deleteShop(completion: @escaping () -> Void) {
//        guard let accessToken = accessToken, let client = client, let email = email else { return }
//        let headers = [
//            "Uid": email,
//            "Access-Token": accessToken,
//            "Client": client,
//            ]
//        
//        var url: String
//        if self.shop.checkInID != 0 {
//            url = "\(urlCheckIns)/\(self.shop.checkInID)"
//        } else {
//            return
//        }
//        print(debug: url)
//        Alamofire.request(url, method: .delete, headers: headers).validate().responseJSON { [weak self] response in
//            switch response.result {
//            case let .success(value):
//                let json = JSON(value)
//                print(json)
//                self?.editType = .deleted
//                completion()
//            case let .failure(error):
//                Alert.show(message: error.localizedDescription)
//                print(error)
//            }
//        }
//    }
//    
//    func fetchShareLink(shop: Shop, completion: @escaping (_ token: String) -> Void) {
//        guard let accessToken = accessToken, let client = client, let email = email else { return }
//        let headers = [
//            "Uid": email,
//            "Access-Token": accessToken,
//            "Client": client,
//            ]
//        let shopID = shop.id
//        let params: [String: [String: Any]] = ["share_link": ["shop_ids": [shopID]]]
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
//    func fetchLists(completion: @escaping () -> Void) {
//        
//        guard let accessToken = accessToken, let client = client, let email = email else { return }
//        let headers = [
//            "Uid": email,
//            "Access-Token": accessToken,
//            "Client": client,
//            ]
//        
//        //初期化しないと重複する
//        self.lists.removeAll()
//        
//        Alamofire.request(urlLists, method: .get, headers: headers).validate().responseJSON { [weak self] response in
//            guard let strongSelf = self else { return }
//            switch response.result {
//            case let .success(value):
//                let json = JSON(value)
//                print(json)
//                json["lists"].arrayValue.forEach { json in
//                    strongSelf.lists.append(List(json))
//                }
//                completion()
//            case let .failure(error):
//                Alert.show(message: error.localizedDescription)
//                print(error)
//            }
//        }
//    }
//    
//    func fetchListsForGuest(completion: @escaping () -> Void) {
//        //初期化しないと重複する
//        self.lists.removeAll()
//        
//        Alamofire.request(urlGuestLists, method: .get).validate().responseJSON { [weak self] response in
//            guard let strongSelf = self else { return }
//            switch response.result {
//            case let .success(value):
//                let json = JSON(value)
//                print(json)
//                json["lists"].arrayValue.forEach { json in
//                    strongSelf.lists.append(List(json))
//                }
//                completion()
//            case let .failure(error):
//                Alert.show(message: error.localizedDescription)
//                print(error)
//            }
//        }
//    }
//    
//    //TODO: リファクタリング
//    func createList(name: String, completion: @escaping () -> Void) {
//        guard let accessToken = accessToken, let client = client, let email = email else { return }
//        let headers = [
//            "Uid": email,
//            "Access-Token": accessToken,
//            "Client": client,
//            ]
//        let param: [String: [String: Any]] = ["list": [
//            "name": name,
//            ]]
//        
//        print(debug: urlLists)
//        Alamofire.request(urlLists, method: .post, parameters: param, headers: headers).validate().responseJSON { [weak self] response in
//            guard let strongSelf = self else { return }
//            switch response.result {
//            case let .success(value):
//                let json = JSON(value)
//                print(json)
//                let list = List(json)
//                strongSelf.lists.append(list)
//                strongSelf.selectedListIDs.append(list.id)
//                
//                //TOPVCを更新
//                let topVC = EcryTabBarController.shared.topVC
//                topVC.reflashList(moveListNum: topVC.currentPage)
//                topVC.editlistVC.model.items.append(EditListModel.Item(id: list.id, title: list.name, btnType: "minus"))
//                
//                completion()
//            case let .failure(error):
//                Alert.show(message: error.localizedDescription)
//                print(error)
//            }
//        }
//    }
//}
//
