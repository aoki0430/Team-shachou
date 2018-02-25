import UIKit
import SwiftyUserDefaults

class RootVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
//        // アクセストークンがなく、ゲストでもない場合WelcomeVCを表示
//        if accessToken == nil && !Defaults[.isGuest] {
//            let vc = WelcomeVC()
//            let navi = UINavigationController(rootViewController: vc)
//            UIApplication.shared.keyWindow?.rootViewController = navi
//            //            self.present(navi, animated: false, completion: nil)
//        } else {
//            let tab = EcryTabBarController.shared
//            // 5つめのタブはMyPageVCに戻しておく
//            //            tab.mypageVC.navigationController?.popToRootViewController(animated: false)
//
//            UIApplication.shared.keyWindow?.rootViewController = tab
//            //            self.present(tab, animated: false, completion: nil)
//        }
//    }
        let vc = ShopVC()
        self.present(vc, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

