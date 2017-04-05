
import UIKit

class UserModel: NSObject,NSCoding {

    var userName:String?
    var passwrod:String?
    var email:String?
    var address:String?
    
    init(name:String,pwd:String,email:String,address:String) {
        super.init()
        self.userName = name
        self.passwrod = pwd
        self.email = email
        self.address = address
    }
    
    //归档
    public func encode(with aCoder: NSCoder){
    
        aCoder.encode(userName, forKey: "userName")
        aCoder.encode(passwrod, forKey: "passwrod")
        aCoder.encode(email, forKey: "email")
        aCoder.encode(address, forKey: "address")
    }
    
    //解归档
    public required init?(coder aDecoder: NSCoder){
    
        super.init()
        self.userName = aDecoder.decodeObject(forKey: "userName") as! String?
        self.passwrod = aDecoder.decodeObject(forKey: "passwrod") as! String?
        self.email = aDecoder.decodeObject(forKey: "email") as! String?
        self.address = aDecoder.decodeObject(forKey: "address") as! String?
    }
}
