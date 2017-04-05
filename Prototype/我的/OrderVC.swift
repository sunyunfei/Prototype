
import UIKit

class OrderVC: BaseVC,UITableViewDelegate,UITableViewDataSource {

    let cellID:String = "OrderCell"
    var tableView:UITableView?
    var orderArray:NSMutableArray?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "ORDER"
        self.view.backgroundColor = UIColor.white
        loadTableView()
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    //数据加载
    func loadData(){
    
        orderArray = OrderDataManager.shareCartInstance().obtainCartData()
        tableView?.reloadData()
    }
    
    //表的加载
    func loadTableView(){
    
        tableView = UITableView.init(frame: self.view.bounds)
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.rowHeight = 80
        tableView?.separatorStyle = .none
        tableView?.register(UINib.init(nibName: cellID, bundle: nil), forCellReuseIdentifier: cellID)
        self.view.addSubview(tableView!)
    }

    //代理
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if orderArray == nil{
            
            return 0
        }else{
            
            return (orderArray?.count)!
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:OrderCell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! OrderCell
        cell.cartModel = orderArray?.object(at: indexPath.row) as! CartModel?
        cell.selectionStyle = .none
        return cell
    }
}
