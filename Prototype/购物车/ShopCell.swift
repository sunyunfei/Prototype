

import UIKit
//代理
protocol ShopCellDelegate{

   func changeCountForShop()//商品数量改变
}

class ShopCell: UITableViewCell {

    @IBOutlet weak var reduceBtn: UIButton!//减少按钮
    @IBOutlet weak var iconImageView: UIImageView!//图片
    @IBOutlet weak var priceLabel: UILabel!//价钱
    @IBOutlet weak var countLabel: UILabel!//数量
    @IBOutlet weak var addBtn: UIButton!//增加按钮
    @IBOutlet weak var titleLabel: UILabel!//名字
    var cartModel:CartModel?{
    
        didSet{
        
            loadData()
        }
    }
    var delegate:ShopCellDelegate?
    //预处理
    override func awakeFromNib() {
        super.awakeFromNib()
        
        reduceBtn.layer.borderWidth = 1
        reduceBtn.layer.borderColor = UIColor.init(colorLiteralRed: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        addBtn.layer.borderWidth = 1
        addBtn.layer.borderColor = UIColor.init(colorLiteralRed: 0, green: 0, blue: 0, alpha: 0.2).cgColor
    }
    
    //数据加载
    func loadData(){
    
        iconImageView.image = UIImage.init(named: (cartModel?.icon)!)
        priceLabel.text = cartModel?.newPrice
        titleLabel.text = cartModel?.title
        countLabel.text = "\((cartModel?.count)!)"
    }
    
    //数据操作
    func changeData(count:Int){
    
        if CartDataManager.shareCartInstance().saveCartData(cart: cartModel!, changeCount: count){
        
            print("商品增加或减少成功")
        }
    }
    
    //点击减少事件
    @IBAction func clickReduceBtn(_ sender: UIButton) {
        
        //判断是否为1
        var count:Int = Int(countLabel.text!)!
        if count <= 0{
        
           countLabel.text = "0"
        }else{
        
            count = count - 1
            countLabel.text = "\(count)"
            changeData(count: -1)
        }
        delegate?.changeCountForShop()
    }
    
    //点击增加事件
    @IBAction func clickAddBtn(_ sender: UIButton) {
        
        var count:Int = Int(countLabel.text!)!
        count = count + 1
        countLabel.text = "\(count)"
        changeData(count: 1)
        delegate?.changeCountForShop()
    }
}
