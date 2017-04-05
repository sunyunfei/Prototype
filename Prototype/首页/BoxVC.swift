

import UIKit

class BoxVC: BaseVC,UICollectionViewDelegate,UICollectionViewDataSource {

    var collectionView:UICollectionView?//数据表
    var cellID:String = "BoxCell"
    var dataArray:[BoxModel] = []
    var chooseIndex:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        //加载数据表
        loadCollectionView()
        //数据处理
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //数据处理
    func loadData(){
    
        //获取plist文件里面的数据
        let path:String = Bundle.main.path(forResource: "boxData", ofType: "plist")!
        let originArray = NSArray.init(contentsOfFile: path)
        //防止越界
        if chooseIndex! >= (originArray?.count)! {
            
            chooseIndex = 0
        }
        
        let catoryArray:[Dictionary<String,AnyObject>] = originArray?[chooseIndex!] as! [Dictionary<String, AnyObject>]
        for dic in catoryArray{
            
            let model = BoxModel.init(dic: dic )
            dataArray.append(model)
        }
        //刷洗
        collectionView?.reloadData()
    }
    
    //加载数据表
    func loadCollectionView(){
    
        //布局
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        let cell_width = self.view.frame.size.width / 2 - 12
        layout.itemSize = CGSize.init(width:cell_width , height: cell_width)
        layout.sectionInset = UIEdgeInsets.init(top: 4, left: 4, bottom: 0, right: 4)
        collectionView = UICollectionView.init(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.backgroundColor = UIColor.init(colorLiteralRed: 237.0 / 255, green: 239.0 / 255, blue: 241.0 / 255, alpha: 1.0)
        collectionView?.register(UINib.init(nibName: cellID, bundle: nil), forCellWithReuseIdentifier: cellID)
        self.view.addSubview(collectionView!)
    }
    
    //代理
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:BoxCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! BoxCell
        cell.boxModel = dataArray[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //打开login
        let story:UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        let detailsVC:DetailsVC = story.instantiateViewController(withIdentifier: "details") as! DetailsVC
        detailsVC.title = "PRODUCT DETAILS"
        detailsVC.boxModel = dataArray[indexPath.row]
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(detailsVC, animated: true)
        //self.hidesBottomBarWhenPushed = false
    }
}
