

import UIKit

class PayVC: BaseVC {

    @IBOutlet weak var accountField: UITextField!//账号
    @IBOutlet weak var passwordField: UITextField!//密码
    var dataArray:NSMutableArray?
    var priceStr:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "PAY"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //按钮事件
    @IBAction func clickPayBtn(_ sender: Any) {
        
        //判断账号密码的位数，正确即可
        let account:String = accountField.text!
        let pwd:String = passwordField.text!
        
        if account.characters.count == 19 && pwd.characters.count == 6{
        
            //成功
            //购物车商品清除
            CartDataManager.shareCartInstance().deleteCartData()
            //订单增加
            OrderDataManager.shareCartInstance().saveOrderAllData(originArray: dataArray!)
            let priceStr2:String = priceStr!.substring(from: "aa".endIndex)
            let price:Double? = Double(priceStr2)
            UserDefaultsManager.shareInstance().saveUserScoreForDefaults(score:price!)
            //发送通知，刷新购物车数据
            YFNotificationManager.shareNotification().pushRefreshCart()
            //返回
            let alertVC:UIAlertController = UIAlertController.init(title: "WARN", message: "Buy success", preferredStyle: .alert)
            let alertBtn:UIAlertAction = UIAlertAction.init(title: "OK", style: .default, handler: { (alert) in
                
                self.navigationController?.popViewController(animated: true)
            })
            alertVC.addAction(alertBtn)
            self.present(alertVC, animated: true, completion: nil)
            
        }else{
        
            YFShowMessage.showMessageInWindows(message: "Pay failure,Please try again", vc: self)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
