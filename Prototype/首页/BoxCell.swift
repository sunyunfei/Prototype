

import UIKit

class BoxCell: UICollectionViewCell {

    @IBOutlet weak var iconImageView: UIImageView!//图片
    @IBOutlet weak var nameLabel: UILabel!//姓名
    @IBOutlet weak var oldPrice: UILabel!//原价
    @IBOutlet weak var newPriceLabel: UILabel!//最新价钱
    var boxModel:BoxModel?{
    
        didSet{
        
            loadData()
        }
    }
    
    func loadData(){
    
        iconImageView.image = UIImage.init(named: (boxModel?.icon)!)
        nameLabel.text = boxModel?.title
        let oldStr:NSMutableAttributedString = NSMutableAttributedString.init(string: "$\((boxModel?.oldPrice)!)")
        oldStr.addAttribute(NSStrikethroughStyleAttributeName, value: (1), range: NSMakeRange(0,oldStr.length))
        oldPrice.attributedText = oldStr
        newPriceLabel.text = "$" + (boxModel?.newPrice)!
    }

}
