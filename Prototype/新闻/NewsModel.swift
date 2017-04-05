

import UIKit

class NewsModel: NSObject {

    var date: String? //时间
    var thumbnail_pic_s: String? //图片
    var title : String? //标题
    var url :String? //链接
    
    init(dic:Dictionary<String,AnyObject>) {
        
        self.date = dic["date"] as! String?
        self.thumbnail_pic_s = dic["thumbnail_pic_s"] as? String
        self.title = dic["title"] as? String
        self.url = dic["url"] as? String
    }
}
