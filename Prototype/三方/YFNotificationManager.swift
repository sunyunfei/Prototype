

import UIKit

class YFNotificationManager: NSObject {

    //单例
    static let manager:YFNotificationManager = YFNotificationManager()
    class func shareNotification() -> YFNotificationManager{
    
        return manager
    }
    
    //发送刷新购物车通知 
    func pushRefreshCart(){
    
        let name = NSNotification.Name(rawValue:"refresh_cart")
        NotificationCenter.default.post(name: name, object: nil, userInfo: nil)
    }
}
