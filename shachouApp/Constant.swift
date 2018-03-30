import SwiftyUserDefaults

extension DefaultsKeys {
    static let isShopAccount = DefaultsKey<Bool>("isShopAccount")
    static let shopid = DefaultsKey<Int>("shopid")
    static let name = DefaultsKey<String?>("name")
    static let pwd = DefaultsKey<String?>("pwd")
}

let urlAuthSignUp = "http://atukuri-mac.local:3000/api/consumers"
let urlGetAllShop = "http://atukuri-mac.local:3000/shop/index"
let urlGetAllItem = "http://atukuri-mac.local:3000/item"
let urlEditShop = ""
let urlEditItem = ""
let urlshop = "http://atukuri-mac.local:3000/shop"
let urlitem = "http://atukuri-mac.local:3000/showitem"

