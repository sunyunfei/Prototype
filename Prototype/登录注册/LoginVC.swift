//
//  LoginVC.swift
//  Prototype
//
//  Created by 孙云飞 on 2017/2/7.
//  Copyright © 2017年 Rambo Si. All rights reserved.
//

import UIKit

class LoginVC: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var nameField: UITextField!//账号
    @IBOutlet weak var passwordField: UITextField!//密码
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //判断账号密码是否填写完成
    func completeAllFieldInput() -> Bool{
    
        if nameField.text!.isEmpty || passwordField.text!.isEmpty{
        
            return false
        }
        return true
    }
    
    //判断账号密码是否错误
    func loginSuccess(){
    
        let user:UserModel = UserModel.init(name: nameField.text!, pwd: passwordField.text!, email: "", address: "")
        if UserDataManager.sharedInstance.loginForUser(user: user){
        
            //保存账号
            UserDefaultsManager.shareInstance().saveUserForDefaults(user:user)
            //登录成功
            YFShowBaseTabVC.loadTabbarVC()
        }else{
        
            //登录失败
            YFShowMessage.showMessageInWindows(message: "Name or password may be error", vc: self)
        }
    }
    
    //点击登录按钮事件
    @IBAction func clickLoginBtn(_ sender: Any) {
        
        if !completeAllFieldInput() {
            YFShowMessage.showMessageInWindows(message: "Name or password may be empty", vc: self)
            return
        }
        
        loginSuccess()
        
    }
    

    //键盘隐藏
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
    }
}
