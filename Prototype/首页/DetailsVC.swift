

import UIKit

class DetailsVC: BaseVC,UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    var dataArray:[String] = []
    var boxModel:BoxModel?
    override func viewDidLoad() {
        super.viewDidLoad()

        //数据的加载
        loadModel()
        loadImageData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //基本数据的显示
    func loadModel(){
    
        titleLabel.text = boxModel?.title
        priceLabel.text = boxModel?.newPrice
    }
    
    //图片数据的加载
    func loadImageData(){
    
        //获取plist文件里面的数据
        let path:String = Bundle.main.path(forResource: "detailsData", ofType: "plist")!
        let originArray = NSArray.init(contentsOfFile: path)
        //防止越界
        if (boxModel?.boxId?.intValue)! >= (originArray?.count)! {
            
            boxModel?.boxId = 0
        }
        
        let catoryArray:[String] = originArray?[(boxModel?.boxId?.intValue)!] as! [String]
        for imageName in catoryArray{
            dataArray.append(imageName)
        }
        //开始加载image
        loadImageView()
    }
    
    //加载image
    func loadImageView(){
    
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentSize = CGSize.init(width: (scrollView.frame.size.width * (CGFloat)(dataArray.count)), height: 0)
        //图片加载
        for i in 0 ..< dataArray.count{
        
            let detailsImage:UIImageView = UIImageView.init(frame: CGRect.init(x: (CGFloat)(i) * scrollView.frame.size.width, y: -65, width: scrollView.frame.size.width, height: scrollView.frame.size.height))
            detailsImage.contentMode = .scaleAspectFit
            detailsImage.image = UIImage.init(named: dataArray[i])
            scrollView.addSubview(detailsImage)
        }
        
        pageControl.numberOfPages = dataArray.count
    }
    
    //按钮事件
    @IBAction func clickAddBtn(_ sender: Any) {
       
        //保存数据
        let cart:CartModel = CartModel.init(boxId: (boxModel?.boxId)!, title: (boxModel?.title)!, old: (boxModel?.oldPrice)!, new: (boxModel?.newPrice)!, icon: (boxModel?.icon)!, count: 1)
        if CartDataManager.shareCartInstance().saveCartData(cart: cart, changeCount: 1){
        
            YFShowMessage.showMessageInWindows(message: "Add to CART success!!!", vc: self)
            //发送通知，刷新购物车数据
            YFNotificationManager.shareNotification().pushRefreshCart()
            
        }else{
        
            YFShowMessage.showMessageInWindows(message: "Add to CART failure!!!", vc: self)
        }
        
    }

    //代理
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let index:Int = (Int)(self.scrollView.contentOffset.x) / (Int)(self.scrollView.frame.width)
        pageControl.currentPage = index
    }

}
