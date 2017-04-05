

import UIKit

class UserDataManager: NSObject {

    //存储位置
    let userFilePath:String = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0].appending("/user.data")
    
    //单例
    static var sharedInstance : UserDataManager {
        struct Static {
            static let instance : UserDataManager = UserDataManager()
        }
        return Static.instance
    }
    
    //判断本地是否有此数据
    func judgeUserData(user:UserModel,methodIndex:Int) -> Bool{
        
        //取出归档的数据
        var locationArray:NSMutableArray?
        
        locationArray = NSKeyedUnarchiver.unarchiveObject(withFile: userFilePath) as! NSMutableArray!
       
        //1.本地没有数据的时候
        if locationArray == nil || (locationArray?.count)! <= 0{
        
            print("本地没有数据")
            switch methodIndex {
            case 1:
                //进入存储元素的操作
                locationArray = NSMutableArray.init(object: user)
                if NSKeyedArchiver.archiveRootObject(locationArray!, toFile: userFilePath){
                
                    return true
                }else{
                
                    return false
                }
            case 2:
                //直接返回失败
                return false
            default:
                break
            }
        }
        
        //本地有数据的时候,判断数据
        switch methodIndex {
        case 1:
            //是否存储元素
            var flage:Bool = true
            for i in 0 ..< (locationArray?.count)!{
            
                let locationUser:UserModel = locationArray?.object(at: i) as! UserModel
                if locationUser.userName == user.userName {
                    
                    //本地已经有这个用户了
                    print("本地已经又这个用户了")
                    flage = false
                    return false
                }
            }
            //本地没有这个用户，存储
            if flage {
                //进入存储元素的操作
                locationArray?.add(user)
                if NSKeyedArchiver.archiveRootObject(locationArray!, toFile: userFilePath){
                    print("本地存储用户")
                    return true
                }else{
                    print("本地已经又这个用户了")
                    return false
                }
            }

        case 2:
            //查看账号密码是否正确
            for i in 0 ..< (locationArray?.count)!{
            
                let locationUser:UserModel = locationArray?.object(at: i) as! UserModel
                //print("name=\(locationUser.userName),pwd=\(locationUser.passwrod)")
                if user.userName == locationUser.userName && user.passwrod == locationUser.passwrod {
                    //登录成功
                    print("成功登陆")
                    return true
                }
            }

        default:
            break
        }
        
        return false
    }
    
    //存储此元素，要判断当地是否有此元素
    func saveUserData(user:UserModel) -> Bool{
    
        return judgeUserData(user: user, methodIndex: 1)
    }
    
    //读取数据，判断是否有此元素
    func loginForUser(user:UserModel) -> Bool{
    
        return judgeUserData(user: user, methodIndex: 2)
    }
    
}
