//
//  AppDelegate.swift
//  IAGuide-Swift
//
//  Created by Omar Alejel on 8/7/15.
//  Copyright (c) 2015 Omar Alejel. All rights reserved.
//

import UIKit

let df = NSDateFormatter()
@objc class Global {
    class func dateFormatter() -> NSDateFormatter {
        return df
    }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        window  = UIWindow(frame: UIScreen.mainScreen().bounds)
        
//give the status bar a white color
        UIApplication.sharedApplication().statusBarStyle = .LightContent
//setup the tabs that are view controllers and add them to a uitabviewcontroller
        let gvc = GuideViewController(nibName: "GuideViewController", bundle: NSBundle.mainBundle())
        let mvc = MapViewController()
        let ovc = OlympicsViewController()
        let evc = ExtrasViewController()
        
        let tbc = setupTabBarController()
        tbc.viewControllers = [gvc, mvc, ovc, evc]
//set the index of the view controller in "viewControllers"
        tbc.selectedIndex = 0
        for item in tbc.tabBar.items as! [UITabBarItem] {
            item.image = item.image?.imageWithRenderingMode(.AlwaysOriginal)
        }
//set the root View Controller as the tab bar controller
        window?.rootViewController = tbc
//start the timer that notifies the app that a new day has arrived
        startNextDayTimer()
//standard setup
        window?.backgroundColor = UIColor.whiteColor()
        window?.makeKeyAndVisible()
        return true
    }
    
    func setupTabBarController() -> UITabBarController {
        let tbc =  UITabBarController()
//set the overall appearance of the tab bar
        tbc.tabBar.tintColor = UIColor.yellowColor()
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.whiteColor()], forState: .Normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.yellowColor()], forState: .Selected)
//give tabbar the custom blue color
        tbc.tabBar.barTintColor = UIColor(red: 0.1686, green: 0.5176, blue: 0.8274, alpha: 1)
        return tbc
    }
    
    func startNextDayTimer() {
//set up a timer that notifies us when a new day begins by calling the newDayArrived function below
    }
    
    func newDayArrived() {
//tell other parts of the application to prepare for the change in date
    }

}

