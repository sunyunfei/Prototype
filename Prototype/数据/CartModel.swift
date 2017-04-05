

import UIKit

class CartModel: NSObject,NSCoding {

    var boxId:NSNumber?
    var title:String?
    var oldPrice:String?
    var newPrice:String?
    var icon:String?
    var count:NSNumber?
    
    init(boxId:NSNumber,title:String,old:String,new:String,icon:String,count:NSNumber) {
        
        self.boxId = boxId
        self.title = title
        oldPrice = old
        newPrice = new
        self.icon = icon
        self.count = count
    }
    
    public func encode(with aCoder: NSCoder){
    
        aCoder.encode(boxId, forKey: "boxId")
        aCoder.encode(title, forKey: "title")
        aCoder.encode(oldPrice, forKey: "oldPrice")
        aCoder.encode(newPrice, forKey: "newPrice")
        aCoder.encode(icon, forKey: "icon")
        aCoder.encode(count, forKey: "count")
    }
    
    public required init?(coder aDecoder: NSCoder){
    
        super.init()
        self.boxId = aDecoder.decodeObject(forKey: "boxId") as! NSNumber?
        self.title = aDecoder.decodeObject(forKey: "title") as! String?
        self.oldPrice = aDecoder.decodeObject(forKey: "oldPrice") as! String?
        self.newPrice = aDecoder.decodeObject(forKey: "newPrice") as! String?
        self.icon = aDecoder.decodeObject(forKey: "icon") as! String?
        self.count = aDecoder.decodeObject(forKey: "count") as! NSNumber?
    }
}
