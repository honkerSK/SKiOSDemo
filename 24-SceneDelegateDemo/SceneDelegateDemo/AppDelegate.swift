//
//  AppDelegate.swift
//  SceneDelegateDemo
//
//  Created by sunke on 2020/7/3.
//  Copyright © 2020 KentSun. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    //手动添加window属性
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if #available(iOS 13, *) {
            
        } else {
            window = UIWindow(frame:UIScreen.main.bounds)
            window!.backgroundColor = UIColor.blue
            //设置root
            let rootVC = UIViewController()
            window!.rootViewController = rootVC
            window!.makeKeyAndVisible()
        }
        return true
    }
    
    //MARK: UISceneSession Lifecycle
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
}

