import SwiftyJSON
import Alamofire

final class ItemModel {
    let shop_id: Int
    var item = Item()
    var items = [Item]()
    
    init(_ shopID: Int) {
        self.shop_id = shopID
    }
    
    func getItemInfo(completion: @escaping ()->Void) {
        let url = urlitem + "/\(shop_id)"
        Alamofire.request(url, method: .get).responseJSON { [weak self] response in
            guard let strongSelf = self else { return }
            switch response.result {
            case let .success(value) :
                let json = JSON(value)
                print(json)
                strongSelf.item = Item(json)
                completion()
            case let .failure(error) :
                print(error)
                completion()
            }
            
        }
        
    }
    
}

//ItemViewの
//func fetch() {
//    self.model.getItemInfo {
//        itemnamelabel.text = self.model.item.itemname
//        itemlabel.text = self.model.item.itemtext
//        sizelavel.text = self.model.item.size
//        itemimageView = self.
//    }
//}

//shopVCのセル
//cell.configure(self.model.items[indexPath.row]) { image in
//    if let image = image {
//        self.model.shops[indexPath.row].image = image
//    }
//}

