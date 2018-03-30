import SwiftyJSON
import Alamofire

final class ItemModel {
    let shop_id: Int
    var item = Item()
    var items = [Item]()
    
    init(_ shopID: Int) {
        self.shop_id = shopID
    }
    
    func EditItem(image: UIImage, itemname: String, itemtext: String, size:String) {
        
        guard let data = UIImagePNGRepresentation(image) else { return }
        let url = "\(urlEditItem)/\(shop_id)"
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                // 送信する値の指定をここでします
                multipartFormData.append(data, withName: "image", fileName: "image", mimeType: "image/png")
                multipartFormData.append(itemname.data(using: String.Encoding.utf8)!, withName: "itemname")
                multipartFormData.append(itemtext.data(using: String.Encoding.utf8)!, withName: "itemtext")
                multipartFormData.append(size.data(using: String.Encoding.utf8)!, withName: "size")
                multipartFormData.append(size.data(using: String.Encoding.utf8)!, withName: "cost")
                
        },
            
            to: url,
            method: .put,
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
    
    func fetchItem(completion: @escaping ()->Void) {
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
//        itemimageView = self.model.item.image
//    }
//}

//shopVCのセル
//cell.configure(self.model.items[indexPath.row]) { image in
//    if let image = image {
//        self.model.shops[indexPath.row].image = image
//    }
//}

