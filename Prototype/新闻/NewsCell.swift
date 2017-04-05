

import UIKit

class NewsCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!//标题
    
    @IBOutlet weak var iconImageView: UIImageView!//图片
    
    @IBOutlet weak var timeLabel: UILabel!//发布日期
    
    //数据
    var newModel:NewsModel?{
    
        didSet{
        
            //数据处理
            loadData()
        }
    }
    
    //数据处理
    func loadData(){
    
        titleLabel.text = newModel?.title
        timeLabel.text = newModel?.date
        //图片异步加载
        DispatchQueue.global().async {
            
            let url = NSURL(string:(self.newModel?.thumbnail_pic_s!)!)
            let data = NSData(contentsOf: url! as URL)
            
            let image = UIImage(data:data as! Data)
            //主线城ui
            DispatchQueue.main.async {
                
                self.iconImageView.image = image
            }
        }
    }
}
