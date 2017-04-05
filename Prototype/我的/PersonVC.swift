

import UIKit

class PersonVC: UITableViewController {

    @IBOutlet weak var nameLabel: UILabel!//名字
    @IBOutlet weak var iconBtn: UIButton!//头像
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //名字数据
        nameLabel.text = UserDefaultsManager.shareInstance().obtainUserNameForDefaults()
        //头像圆角处理
        iconBtn.layer.cornerRadius = 50
        iconBtn.layer.masksToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //点击事件
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            let orderVC:OrderVC = OrderVC()
            self.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(orderVC, animated: true)
            self.hidesBottomBarWhenPushed = false
            break
        case 1:
            let allPrice:Double = UserDefaultsManager.shareInstance().obtainUserScoreForDefaults()
            let score:Int = (Int)(allPrice) / 100
            YFShowMessage.showMessageInWindows(message: "Your benus point is:\(score)", vc: self)
            break
        case 2:
            //退出事件
            UserDefaultsManager.shareInstance().deleteUserNameForDefaults()
            //删除数据
            OrderDataManager.shareCartInstance().deleteCartData()
            CartDataManager.shareCartInstance().deleteCartData()
            //跳转到login
            let story:UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
            let loginVC = story.instantiateViewController(withIdentifier: "login")
            UIApplication.shared.keyWindow?.rootViewController = loginVC
            break
        default:
            break
        }
    }

}
