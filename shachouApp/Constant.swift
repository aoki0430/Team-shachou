import SwiftyUserDefaults
//import KeychainAccess

extension DefaultsKeys {
    static let isShopAccount = DefaultsKey<Bool>("isShopAccount")
    static let isPrivateAccount = DefaultsKey<Bool>("isPrivateAccount")
    static let numberOfShop = DefaultsKey<Int>("numberOfShop")
    static let name = DefaultsKey<String?>("name")
    static let pwd = DefaultsKey<String?>("pwd")
}


let endpoint = "url"

let urlAuthSignUp = "http://atukuri-mac.local:3000/consumers"
//let urlAuthSignIn = endpoint + "auth/sign_in"
//let urlAuthSignUpFB = endpoint + version + "auth/facebook"
//let urlUser = endpoint + version + "user"
//let urlAuthSignIn = endpoint + version + "auth/sign_in"
//let urlCheckIns = endpoint + version + "check_ins"
//let urlShops = endpoint + version + "shops"
//let urlSearchShops = endpoint + version + "shops/search"
//let urlCheckInSuggestions = endpoint + version + "check_in_suggestions"
//let urlUsersShopRankings = endpoint + version + "users/shop_rankings"
//let urlShareLink = endpoint + version + "share_links"
//let urlNotifications = endpoint + version + "notifications"
//let urlLists = endpoint + version + "lists"
//let urlListsEditOrder = endpoint + version + "lists/row_order"
//let urlListEditShops = endpoint + version + "shops?list_id="
//let urlListsRecommend = endpoint + version + "lists/recommend"
//let urlCopyList = endpoint + version + "lists/copy"
//let urlContacts = endpoint + version + "contacts"
//let urlUserShops = endpoint + version + "users/shops"
//let urlUserEdit = endpoint + version + "users/"
//let urlGuestShops = endpoint + version + "public/shops"
//let urlGuestLists = endpoint + version + "public/lists"
//let urlGuestSearchShops = endpoint + version + "public/shops/search"
//let urlShareLinks = endpoint + version + "share_links/"

//let keychain = Keychain(service: "com.teamshachou")
//var accessToken: String? {
//    get { return keychain["accessToken"] }
//    set(value) { keychain["accessToken"] = value }
//}
//
//var client: String? {
//    get { return keychain["client"] }
//    set(value) { keychain["client"] = value }
//}
//
//var email: String? {
//    get { return keychain["email"] }
//    set(value) { keychain["email"] = value }
//}
//
//var latitude: Double? {
//    get { return Defaults[.latitude] }
//    set(value) { Defaults[.latitude] = value }
//}
//
//var longitude: Double? {
//    get { return Defaults[.longitude] }
//    set(value) { Defaults[.longitude] = value }
//}

