

import UIKit

class OrderDataManager: NSObject {

    //存储位置
    let userFilePath:String = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0].appending("/order.data")
    
    //单例
    static let manager:OrderDataManager = OrderDataManager()
    class func shareCartInstance() -> OrderDataManager{
        
        return manager
    }
    
    //存储此元素，要判断当地是否有此元素
    func saveCartData(cart:CartModel) ->Bool{
        
        //取出归档的数据
        var locationArray:NSMutableArray?
        
        locationArray = NSKeyedUnarchiver.unarchiveObject(withFile: userFilePath) as! NSMutableArray!
        //1.本地没有数据的时候
        if locationArray == nil || (locationArray?.count)! <= 0{
                //进入存储元素的操作
                locationArray = NSMutableArray.init(object: cart)
                if NSKeyedArchiver.archiveRootObject(locationArray!, toFile: userFilePath){
                    
                    return true
                }else{
                    
                    return false
                }
        }else{
            
            //2.本地有数据的时候
            //判断本地是否这个数据
            var falge = true
            for i in 0 ..< (locationArray?.count)!{
                
                let locationCart:CartModel = locationArray?.object(at: i) as! CartModel
                if locationCart.boxId == cart.boxId{
                    
                    //说明本地有这个数据
                    let allCount:Int = (locationCart.count?.intValue)! + (cart.count?.intValue)!
                    
                    //判断是否已经为0
                    if allCount <= 0 {
                        
                        locationArray?.remove(locationCart)
                        falge = false
                        continue
                    }
                    
                    locationCart.count = allCount as NSNumber?
                    //结束循环
                    falge = false
                    continue
                }
            }
            
            //判断是否新添加
            if falge {
                locationArray?.add(cart)
            }
        }
        
        //保存
        if NSKeyedArchiver.archiveRootObject(locationArray!, toFile: userFilePath){
            
            return true
        }
        
        return false
    }
    
    //外部调用存储
    func saveOrderAllData(originArray:NSMutableArray){
        
        if originArray.count > 0{
            
            for i in 0 ..< originArray.count{
                
                let cartModel:CartModel = originArray.object(at: i) as! CartModel
                if saveCartData(cart: cartModel){
                    
                    print("order save")
                }
            }
        }
    }
    
    //删除本地存储
    func deleteCartData(){
        
        let defaultManager:FileManager = FileManager.default
        if defaultManager.isDeletableFile(atPath: userFilePath){
            
            do{
                
                try defaultManager.removeItem(atPath: userFilePath)
            }catch{
                
                
            }
        }
    }

    
    //读取数据，判断是否有此元素
    func obtainCartData() -> NSMutableArray{
        
        //取出归档的数据
        var locationArray:NSMutableArray?
        
        locationArray = NSKeyedUnarchiver.unarchiveObject(withFile: userFilePath) as! NSMutableArray!
        //1.本地没有数据的时候
        if locationArray == nil || (locationArray?.count)! <= 0{
            
            locationArray = NSMutableArray.init()
        }
        
        return locationArray!
    }
}
