

import UIKit

class YFShowBaseTabVC: NSObject {

    //加载分栏
    class func loadTabbarVC(){
    
        //打开login
        let story:UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        let loginVC = story.instantiateViewController(withIdentifier: "base")
        UIApplication.shared.keyWindow?.rootViewController = loginVC
    }
}
