//
//  RegsisterVC.swift
//  Prototype
//
//  Created by 孙云飞 on 2017/2/7.
//  Copyright © 2017年 Rambo Si. All rights reserved.
//

import UIKit

class RegsisterVC: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var nameFiled: UITextField!//账号
    
    @IBOutlet weak var passwordField: UITextField!//密码
    
    @IBOutlet weak var oncePasswordField: UITextField!//再次输入密码
    @IBOutlet weak var emailField: UITextField!//邮箱
    
    @IBOutlet weak var addressField: UITextField!//地址
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //判断是否所有的信息都已经填写完成
    func completeAllFieldInput() -> Bool{
    
        if  nameFiled.text!.isEmpty
            || passwordField.text!.isEmpty
            || oncePasswordField.text!.isEmpty
            || emailField.text!.isEmpty
            || addressField.text!.isEmpty{
        
            return false
        }
        return true
    }
    
    //判断两次密码输入是否一致
    func validationForPasswordSuccess() -> Bool{
    
        if passwordField.text! == oncePasswordField.text!{
        
            return true
        }
        return false
    }
    
    //点击注册按钮
    @IBAction func clickRegisterBtn(_ sender: Any) {
        
        if !self.completeAllFieldInput() {
            
            //有没有填写的信息
            YFShowMessage.showMessageInWindows(message: "Sorry,fill in incomplete information",vc: self)
            return
        }
        
        if !validationForPasswordSuccess() {
            
            //两次密码输入不一样
            YFShowMessage.showMessageInWindows(message: "Two password is not consistent, please check",vc: self)
            return
        }
        
        //注册数据开始保存
        let user:UserModel = UserModel.init(name: nameFiled.text!, pwd: passwordField.text!, email: emailField.text!, address: addressField.text!)
        if UserDataManager.sharedInstance.saveUserData(user: user){
        
            YFShowMessage.showMessageInWindows(message: "Registration is successful, please return to log in",vc: self)
        }else{
        
            YFShowMessage.showMessageInWindows(message: "Registration is failure, please once do it",vc: self)
        }
    }

    //点击去登录事件
    @IBAction func clickToLoginBtn(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    

    //触摸事件键盘消失
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
    }
    
    //键盘代理事件
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
        return true
    }
}
