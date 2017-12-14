//
//  AppDelegate.swift
//  TriviaFlop
//
//  Created by Dennis Broekhuizen on 08-12-17.
//  Copyright © 2017 Dennis Broekhuizen. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        UINavigationBar.appearance().barTintColor = UIColor(red:0.32, green:0.60, blue:0.844, alpha:1)
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white , NSAttributedStringKey.font: UIFont(name: "AvenirNext-DemiBold", size: 22)!]
        UIBarButtonItem.appearance().setTitleTextAttributes(
            [
                NSAttributedStringKey.font : UIFont(name: "Avenir", size: 17)!,
                NSAttributedStringKey.foregroundColor : UIColor.white,
                ], for: .normal)
        return true
    }

}

