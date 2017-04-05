

import UIKit

class UserDefaultsManager: NSObject {

    //单例
    static let manager:UserDefaultsManager = UserDefaultsManager()
    
    class func shareInstance() -> UserDefaultsManager{
        
        return manager
    }
    
    //存
    func saveUserForDefaults(user:UserModel){
    
        let defaults:UserDefaults = UserDefaults.standard
        defaults.set(user.userName, forKey: "username")
        defaults.synchronize()
    }
    
    //存积分
    func saveUserScoreForDefaults(score:Double?){
        //首先取出来
        let name:String = obtainUserNameForDefaults()
        let oldScore:Double = obtainUserScoreForDefaults()
        
        let defaults:UserDefaults = UserDefaults.standard
        defaults.set(score! + oldScore, forKey: name + "score")
        defaults.synchronize()
    }

    //取数据
    func obtainUserNameForDefaults() -> String{
    
        let defaults:UserDefaults = UserDefaults.standard
        let str:String? = defaults.object(forKey: "username") as? String
        if str == nil || (str?.isEmpty)!{
        
            return ""
        }else{
        
            return str!
        }
    }
    
    //取数据
    func obtainUserScoreForDefaults() -> Double{
        
        let defaults:UserDefaults = UserDefaults.standard
        let name:String = obtainUserNameForDefaults()
        if defaults.object(forKey: name + "score") != nil{
        
            return defaults.object(forKey: name + "score") as! Double
        }else{
        
            return 0
        }
        
    }
    
    //删除
    func deleteUserNameForDefaults(){
        
        let defaults:UserDefaults = UserDefaults.standard
        defaults.removeObject(forKey: "username")
    }
}
