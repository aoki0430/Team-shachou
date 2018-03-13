//import SwiftyUserDefaults
//
//final class SearchShopListPresenter {
//    
//    //TODO: リファクタリング
//    let model = ChangeShopModel()
//    var completion: ((_ visited: Bool, _ shop: Shop, _ selectedListIDs: [Int], _ rankCount: Int) -> Void) // 現在のところ必須
//    private let listID:Int//listEmptyViewから来た時、お店をそのリストに保存するため
//    private let isFromVisitedVCSearch:Bool // 行ったリストの検索から来たときのため
//    
//    // falseなら現在地に近い順、trueならリスト内のお店を検索
//    let isForMyList: Bool
//    
//    var numOfShop: Int {
//        return model.nearShops.count
//    }
//    
//    var searchKeyword: String? {
//        get {
//            return model.seachKeyword
//        }
//        //        set {
//        //            self.model.setSearchInit(keyword: searchKeyword)
//        //        }
//        
//    }
//    
//    
//    init(isForMyList: Bool, listID:Int = 0, isFromVisitedVCSearch:Bool = false) {
//        self.isForMyList = isForMyList
//        self.listID = listID
//        self.isFromVisitedVCSearch = isFromVisitedVCSearch
//        //TODO: TopVCと一緒にリファクタリング
//        self.completion = { (visited: Bool, shop: Shop, selectedListIDs: [Int], rankCount: Int) -> Void in
//            EcryTabBarController.shared.topVC.checkInCompletion(visited: visited, shop: shop, selectedListIDs: selectedListIDs, rankCount: rankCount)
//        }
//        
//    }
//    
//    // TODO: リファクタリング
//    func set(searchKeyword:String?) {
//        self.model.setSearchInit(keyword: searchKeyword)
//    }
//    
//    func fetch(completion: @escaping () -> Void) {
//        // TODO: リファクタリング
//        self.model.isReloading = true // 初回のロードであることを示す
//        
//        // リスト内検索
//        if isForMyList {
//            self.model.searchSavedShops {
//                completion()
//            }
//            // 現在地から検索
//        } else {
//            // 近い順
//            if self.model.seachKeyword == nil {
//                if Defaults[.isGuest] {
//                    self.model.fetchNearShopsForGuest {
//                        completion()
//                    }
//                } else {
//                    self.model.fetchNearShops {
//                        completion()
//                    }
//                }
//                // キーワード検索
//            } else {
//                if Defaults[.isGuest] {
//                    self.model.searchKeywordShopsForGuest {
//                        completion()
//                    }
//                } else {
//                    self.model.searchKeywordShops {
//                        completion()
//                    }
//                }
//            }
//        }
//    }
//    
//    // 追加読み込みする
//    func moreLoadShops(completion: @escaping () -> Void) {
//        
//        if isForMyList {
//            self.model.searchSavedShops {
//                completion()
//            }
//        } else {
//            self.model.moreLoad {
//                completion()
//            }
//        }
//        
//    }
//    
//    func shop(index: Int) -> Shop {
//        return self.model.nearShops[index]
//    }
//    
//    func isSavedShop(index: Int) -> Bool {
//        return self.model.nearShops[index].checkInID != 0
//    }
//    
//    // TODO: リファクタリング
//    func shopVC(index: Int) -> ShopVC {
//        
//        var listVC: ListVC
//        if self.visitedCountOfShop(index: index) == 0 {
//            listVC = EcryTabBarController.shared.topVC.withlistVC //行きたいリスト
//        } else {
//            listVC = EcryTabBarController.shared.topVC.visitedVC //行ったリスト
//        }
//        
//        let shopVC = ShopVC(
//            shopID: self.shop(index: index).id,
//            self.shop(index: index).checkInID,
//            listVC.model.listID,
//            completion: { needReload in
//                if needReload {
//                    listVC.model.clearList()
//                    listVC.fetch()
//                }
//        }
//        )
//        
//        shopVC.pinCompletion = self.completion
//        shopVC.hidesBottomBarWhenPushed = true
//        // listEmptyViewからの場合
//        if self.listID != 0 {
//            shopVC.listID = self.listID
//        }
//        return shopVC
//    }
//    
//    // TODO: リファクタリング
//    func beforeSaveShopVC(index: Int) -> BeforeSaveShopVC {
//        let selectedShop = self.shop(index: index)
//        let beforeSaveShopVC = BeforeSaveShopVC(shopID: selectedShop.id)
//        beforeSaveShopVC.completion = self.completion
//        if self.listID != 0 {
//            beforeSaveShopVC.model.selectedListIDs.append(self.listID)
//        }
//        
//        beforeSaveShopVC.isFromVisitedVCSearch = self.isFromVisitedVCSearch
//        beforeSaveShopVC.hidesBottomBarWhenPushed = true
//        
//        return beforeSaveShopVC
//    }
//    
//}
//
//
//
