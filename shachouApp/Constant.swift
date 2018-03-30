import SwiftyUserDefaults

extension DefaultsKeys {
    static let isShopAccount = DefaultsKey<Bool>("isShopAccount")
    static let shopid = DefaultsKey<Int>("shopid")
    static let name = DefaultsKey<String?>("name")
    static let pwd = DefaultsKey<String?>("pwd")
}


let urlShopSignUp = "https://vintageapi.herokuapp.com/api/consumers"
let urlUserSignUp = "https://vintageapi.herokuapp.com/api/consumers"
let urlCreateShop = "https://vintageapi.herokuapp.com/shop/upload"
let urlGetAllShop = "https://vintageapi.herokuapp.com/shop/index"
let urlGetAllItem = "https://vintageapi.herokuapp.com/item"
let urlEditShop = "https://vintageapi.herokuapp.com/shop"
let urlEditItem = "https://vintageapi.herokuapp.com/edititem"
let urlshop = "https://vintageapi.herokuapp.com/shop"
let urlitem = "https://vintageapi.herokuapp.com/showitem"

//let urlAuthSignUp = "http://atukuri-mac.local:3000/api/consumers"
//let urlGetAllShop = "http://atukuri-mac.local:3000/shop/index"
//let urlGetAllItem = "http://atukuri-mac.local:3000/item"
//let urlEditShop = ""
//let urlEditItem = ""
//let urlshop = "http://atukuri-mac.local:3000/shop"
//let urlitem = "http://atukuri-mac.local:3000/showitem"

