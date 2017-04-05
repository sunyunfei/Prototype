

import UIKit

class NewsVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var tableView:UITableView?
    var dataArray:[NewsModel] = []
    var cellID:String = "NewsCell"
    override func viewDidLoad() {
        super.viewDidLoad()

        //加载表
        loadTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //加载表
    func loadTableView(){
    
        tableView = UITableView.init(frame: self.view.bounds)
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.rowHeight = 100
        //注册单元格
        tableView?.register(UINib.init(nibName: cellID, bundle: nil), forCellReuseIdentifier: cellID)
        self.view.addSubview(tableView!)
        //数据请求
        loadData()
    }
    
    //数据加载
    func loadData(){
    
        //网络请求
        let urlStr = "http://v.juhe.cn/toutiao/index?type=keji&key=848c3f852e0471b53e966832570d7308"
        let url = URL(string:urlStr.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!){(Data,respond,error) in
            
            if let data = Data{
                
                if let result = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: AnyObject]{
                    
                    let result2:[String:AnyObject] = (result?["result"])! as! [String : AnyObject]
                    let result3:[AnyObject] = (result2["data"] as? [AnyObject])!
                    for dic in result3{
                        
                        let model = NewsModel.init(dic: dic as! [String : AnyObject])
                        
                        self.dataArray.append(model)
                    }
                    
                    //主线程刷新表
                    DispatchQueue.main.async {
                        //判断是否有数据
                        if self.dataArray.count > 0{
                        
                            self.tableView?.reloadData()
                        }else{
                        
                            print("数据加载失败，检查网络")
                        }
                        
                    }
                    
                }
            }
        }
        //开始请求
        dataTask.resume()
    }
    
    //表代理
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:NewsCell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! NewsCell
        cell.newModel = dataArray[indexPath.row]
        return cell
    }
    
    //点击单元格事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        //跳转
        let model = dataArray[indexPath.row]
        let webVC = NewsWebVC()
        webVC.newModel = model
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(webVC, animated: true)
        self.hidesBottomBarWhenPushed = false
    }
}
