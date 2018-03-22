import SwiftyUserDefaults

extension DefaultsKeys {
    static let isShopAccount = DefaultsKey<Bool>("isShopAccount")
    static let isPrivateAccount = DefaultsKey<Bool>("isPrivateAccount")
    static let numberOfShop = DefaultsKey<Int>("numberOfShop")
    static let name = DefaultsKey<String?>("name")
    static let pwd = DefaultsKey<String?>("pwd")
}

let urlAuthSignUp = "http://atukuri-mac.local:3000/api/consumers"
let urltopmodel = "http://atukuri-mac.local:3000/shop/index"
let urlshopmodel = ""

