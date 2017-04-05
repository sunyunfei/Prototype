

import UIKit

class HomeVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //title
        let titleStr:[String] = ["BAGS","BALLS","Chill-bra","SHOES","T-shirts"]
        let boxVC:BoxVC = BoxVC()
        boxVC.chooseIndex = indexPath.row
        boxVC.title = titleStr[indexPath.row]
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(boxVC, animated: true)
        self.hidesBottomBarWhenPushed = false
    }
}
