//
//  AppDelegate.swift
//  BabyObjectsTalk
//
//  Created by Glenn Posadas on 12/27/20.
//

import GoogleMobileAds
import UIKit

let mainSB = UIStoryboard(name: "Main", bundle: nil)

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
     
        GADMobileAds.sharedInstance().start(completionHandler: nil)

        return true
    }
}
