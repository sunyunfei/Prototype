

import UIKit

class ShopVC: UIViewController,UITableViewDelegate,UITableViewDataSource,ShopCellDelegate,PayPalPaymentDelegate {

    @IBOutlet weak var sumbitBtn: UIButton!//提交按钮
    @IBOutlet weak var priceLabel: UILabel!//总价
    @IBOutlet weak var tableView: UITableView!//数据表
    var payPalConfig = PayPalConfiguration()//支付管理
    var cellID:String = "ShopCell"
    var cartArray:NSMutableArray?
    //支付环境
    var environment:String = PayPalEnvironmentNoNetwork {
        willSet(newEnvironment) {
            if (newEnvironment != environment) {
                PayPalMobile.preconnect(withEnvironment: newEnvironment)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib.init(nibName: cellID, bundle: nil), forCellReuseIdentifier: cellID)
        tableView.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: -50, right: 0)
        tableView.rowHeight = 80
        tableView.separatorStyle = .none
        loadData()
        
        //接收通知
        NotificationCenter.default.addObserver(self, selector: #selector(loadData), name: NSNotification.Name(rawValue:"refresh_cart"), object: nil)
        
        //支付代码
        payPalConfig.acceptCreditCards = false
        payPalConfig.merchantName = "Awesome Shirts, Inc."
        payPalConfig.merchantPrivacyPolicyURL = URL(string: "https://www.paypal.com/webapps/mpp/ua/privacy-full")
        payPalConfig.merchantUserAgreementURL = URL(string: "https://www.paypal.com/webapps/mpp/ua/useragreement-full")
        payPalConfig.languageOrLocale = Locale.preferredLanguages[0]
        payPalConfig.payPalShippingAddressOption = .payPal
    }

    //确定支付环境
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        PayPalMobile.preconnect(withEnvironment: environment)
    }
    
    //加载数据
    func loadData(){
    
        cartArray = CartDataManager.shareCartInstance().obtainCartData()
        tableView.reloadData()
        changeAllPrice()
    }
    
    //商品总价的更改
    func changeAllPrice(){
    
        var allPrice:Double = 0.0
        
        if (cartArray?.count)! > 0{
        
            for i in 0 ..< (cartArray?.count)!{
            
                let cart:CartModel = cartArray?.object(at: i) as! CartModel
                allPrice = allPrice + (cart.count?.doubleValue)! * (Double(cart.newPrice!))!
            }
        }
        
        //赋值
        priceLabel.text = "$ \(allPrice)"
    }
    
    //刷新事件
    @IBAction func clickRefreshBtn(_ sender: Any) {
        
        //改变按钮的标题
        sumbitBtn.setTitle("CHECK OUT", for: .normal)
        //按钮不可操作
        sumbitBtn.isEnabled = true
        
        //数据改变
        cartArray?.removeAllObjects()
        loadData()
    }
    
    //提交事件
    @IBAction func clickSumbitBtn(_ sender: UIButton) {
      
        //判断是否有商品
        if (cartArray?.count)! > 0{
        
            //跳转
            /*
            let story:UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
            let payVC:PayVC = story.instantiateViewController(withIdentifier: "pay") as! PayVC
            payVC.priceStr = priceLabel.text!
            payVC.dataArray = cartArray
            self.navigationController?.pushViewController(payVC, animated: true)
 */
            //支付接入

            let payment = PayPalPayment(amount: NSDecimalNumber(string: priceLabel.text!), currencyCode: "USD", shortDescription: "this is test data", intent: .sale)
            
            if (payment.processable) {
                let paymentViewController = PayPalPaymentViewController(payment: payment, configuration: payPalConfig, delegate: self)
                present(paymentViewController!, animated: true, completion: nil)
            }
            else {
                
                print("Payment not processalbe: \(payment)")
            }
            
        }else{
        
            YFShowMessage.showMessageInWindows(message: "Shopping cart no goods", vc: self)
        }
        
    }

    //表代理
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if cartArray == nil{
        
            return 0
        }else{
        
            return (cartArray?.count)!
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell:ShopCell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! ShopCell
        cell.delegate = self
        cell.selectionStyle = .none
        cell.cartModel = cartArray?.object(at: indexPath.row) as! CartModel?
        return cell
    }
    
    //商品数量改变
    func changeCountForShop(){
    
        //改变按钮的标题
        sumbitBtn.setTitle("HIT REFRESH BUTTON TO UPDATE TOTAL", for: .normal)
        //按钮不可操作
        sumbitBtn.isEnabled = false
    }
    
    
    //支付代理
    func payPalPaymentDidCancel(_ paymentViewController: PayPalPaymentViewController) {
        print("PayPal Payment Cancelled")
        paymentViewController.dismiss(animated: true, completion: nil)
    }
    
    func payPalPaymentViewController(_ paymentViewController: PayPalPaymentViewController, didComplete completedPayment: PayPalPayment) {
        print("PayPal Payment Success !")
        paymentViewController.dismiss(animated: true, completion: { () -> Void in
            // send completed confirmaion to your server
            print("Here is your proof of payment:\n\n\(completedPayment.confirmation)\n\nSend this to your server for confirmation and fulfillment.")
            
            //数据的处理
            //购物车商品清除
            CartDataManager.shareCartInstance().deleteCartData()
            //订单增加
            OrderDataManager.shareCartInstance().saveOrderAllData(originArray: self.cartArray!)
            let priceStr2:String = self.priceLabel.text!.substring(from: "aa".endIndex)
            let price:Double? = Double(priceStr2)
            UserDefaultsManager.shareInstance().saveUserScoreForDefaults(score:price!)
            self.loadData()
        })
    }
}
