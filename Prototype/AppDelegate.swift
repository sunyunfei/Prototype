//
//  AppDelegate.swift
//  Prototype
//
//  Created by Rambo Si on 17/1/24.
//  Copyright © 2017年 Rambo Si. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //高德地图
        AMapServices.shared().apiKey = "17eddda860e07ceda5b69e097f337879"
        //支付接入
        PayPalMobile .initializeWithClientIds(forEnvironments: [PayPalEnvironmentProduction: "AYv7DhKeLsbpOrBdeqAKyPzy35aNDhNETgwoN4yiizBxSWkwNIY3xfw8gYpazqSSANlPiEEInbigjLx7",
                                                                PayPalEnvironmentSandbox: "Ad3cw4sqg26QyZU7L2uBxhzws1-esbH3koSHtJavk6E5HxQo6wE7FEUQ2vWFlgidtATGV-SztolGOvtG"])
        
        //加载初始界面
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.makeKeyAndVisible()
        //判断是否已经登陆
        UserDefaultsManager.shareInstance().obtainUserNameForDefaults().isEmpty == true ? loadLoginVC() : YFShowBaseTabVC.loadTabbarVC()
        return true
    }

    //加载登录界面
    func loadLoginVC(){
        //打开login
        let story:UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        let loginVC = story.instantiateViewController(withIdentifier: "login")
        window?.rootViewController = loginVC
    }
}

