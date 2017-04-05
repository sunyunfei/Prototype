
import UIKit

class BaseVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let returnBtn:UIButton = UIButton.init(type: .custom)
        returnBtn.frame = CGRect.init(x: 0, y: 0, width: 40, height: 30)
        returnBtn.setImage(UIImage.init(named: "goodsdetail_btn_back2"), for: .normal)
        returnBtn.addTarget(self, action: #selector(clickReturnBtn), for: .touchUpInside)
        let barBtn:UIBarButtonItem = UIBarButtonItem.init(customView: returnBtn)
        self.navigationItem.leftBarButtonItem = barBtn
    }

    func clickReturnBtn(){
        
        self.navigationController?.popViewController(animated: true)
    }
}
