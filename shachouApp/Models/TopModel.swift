import Alamofire
import SwiftyJSON

struct List {
    let id: Int
    let name: String
    let url: URL?
    
    init() {
        id = 0
        name = ""
        url = nil
    }
    
    init(_ json:JSON) {
        id = json["id"].intValue
        name = json["name"].stringValue
        url = json["url"].url
    }
}

final class TopModel {
    
}
