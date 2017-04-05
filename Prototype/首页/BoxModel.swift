

import UIKit

class BoxModel: NSObject {

    var boxId:NSNumber?
    var title:String?
    var oldPrice:String?
    var newPrice:String?
    var icon:String?
    
    init(dic:Dictionary<String,AnyObject>) {
       
        boxId = dic["boxId"] as! NSNumber?
        title = dic["title"] as! String?
        oldPrice = dic["oldPrice"] as! String?
        newPrice = dic["newPrice"] as! String?
        icon = dic["icon"] as! String?
    }
}
