import SwiftyJSON

struct Shop {
    var id = 0
    var shopname = ""
    var text = ""
    var addr = ""
    var tel = ""
    var image = ""
    
    init() {
    }
    
    init(_ json: JSON) {
        id = json["id"].intValue
        shopname = json["shopname"].stringValue
        text = json["text"].stringValue
        if text == "<null>" {
            text = ""
        }
        addr = json["addr"].stringValue
        tel = json["tel"].stringValue
        image = json["image"]["url"].stringValue
    }
}

struct Item {
    var shop_id = 0
    var itemname = ""
    var itemtext = ""
    var size = ""
    var itemimage = ""
    
    init() {
    }
    
    init(_ json: JSON) {
        shop_id = json["shop_id"].intValue
        itemname = json["itemname"].stringValue
        itemtext = json["itemtext"].stringValue
        size = json["size"].stringValue
        itemimage = json["itemimage"].stringValue
    }
}
