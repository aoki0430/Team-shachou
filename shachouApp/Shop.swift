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
    var id = 0
    var shop_id = 0
    var itemname = ""
    var itemtext = ""
    var size = ""
    var image = ""
    var cost = ""
    
    init() {
    }
    
    init(_ json: JSON) {
        id = json["id"].intValue
        shop_id = json["shop_id"].intValue
        itemname = json["itemname"].stringValue
        itemtext = json["itemtext"].stringValue
        size = json["size"].stringValue
        cost = json["cost"].stringValue
        image = json["image"]["url"].stringValue
    }
}
