//
//  AppDelegate.swift
//  TwitterTutorial
//
//  Created by Youngbin Choi on 4/10/24.
//

import UIKit
import FirebaseCore
import FirebaseAppCheck

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if #available(iOS 15.0, *) {
            let appearance1 = UINavigationBarAppearance()
            appearance1.configureWithDefaultBackground()
//            appearance1.backgroundColor = .white
            
            let appearance2 = UITabBarAppearance()
            appearance2.configureWithDefaultBackground()
//            appearance2.backgroundColor = .blue
            
            UINavigationBar.appearance().standardAppearance = appearance1
            UINavigationBar.appearance().scrollEdgeAppearance = appearance1
            UITabBar.appearance().scrollEdgeAppearance = appearance2
            UITabBar.appearance().standardAppearance = appearance2
        }
        let providerFactory = AppCheckDebugProviderFactory()
        AppCheck.setAppCheckProviderFactory(providerFactory)
        
        FirebaseApp.configure()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}



