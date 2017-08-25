//
//  AppDelegate.swift
//  FlexAndChill
//
//  Created by Hongfei Zhang on 8/24/17.
//  Copyright © 2017 Deja View Concepts, Inc. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		window = UIWindow(frame: UIScreen.main.bounds)
		
		if let window = self.window {
			window.rootViewController = ViewController()
			window.backgroundColor = .white
			window.makeKeyAndVisible()
		}
		
		return true
	}

}

