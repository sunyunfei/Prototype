

import UIKit

class YFShowMessage: NSObject {

   //弹出提示框
   class func showMessageInWindows(message:String?,vc:UIViewController){
        
        let alertVC:UIAlertController = UIAlertController.init(title: "WARN", message: "默认的提示信息", preferredStyle: .alert)
        message?.isEmpty == true ? (alertVC.message = "您好，今天见到您真高兴") : (alertVC.message = message!)
        let alertBtn:UIAlertAction = UIAlertAction.init(title: "OK", style: .cancel, handler: nil)
        alertVC.addAction(alertBtn)
        vc.present(alertVC, animated: true, completion: nil)
    }
}
