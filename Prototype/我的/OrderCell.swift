

import UIKit

class OrderCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!//图片
    @IBOutlet weak var countLabel: UILabel!//数量
    @IBOutlet weak var priceLabel: UILabel!//价钱
    @IBOutlet weak var titleLabel: UILabel!//标题
    
    @IBOutlet weak var allPriceLabel: UILabel!
    var cartModel:CartModel?{
    
        didSet{
        
            loadData()
        }
    }
    
    func loadData(){
    
        iconImageView.image = UIImage.init(named: (cartModel?.icon)!)
        titleLabel.text = cartModel?.title
        priceLabel.text = "$ " + (cartModel?.newPrice)!
        countLabel.text = " x \((cartModel?.count)!)"
        let allPrice:Double = (Double)((cartModel?.newPrice)!)! * (cartModel?.count?.doubleValue)!
        allPriceLabel.text = "Total:$\(allPrice)"
    }
}
