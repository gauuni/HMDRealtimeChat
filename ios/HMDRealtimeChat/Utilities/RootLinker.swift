//
//  AppDelegate.swift
//  Fitness
//
//  Created by Duc Nguyen on 10/1/16.
//  Copyright © 2016 Reflect Apps Inc. All rights reserved.
//

import Foundation
import ViewDeck

class RootLinker: NSObject  {
    @objc static let sharedInstance = RootLinker()
    var myScheduleTabIndex: Int = -1
    
    override init() {
        
    }
    
    class func getTopViewController() -> UIViewController? {
        let rc = RootLinker.sharedInstance.getRootViewController()
        if let nc = rc as? UINavigationController {
            return nc.visibleViewController?.presentedViewController ?? nc.visibleViewController
        } else {
            return rc?.presentedViewController ?? rc
        }
    }
    
    /** get viewcontroller from class name */
    class func getViewController(storyboard: RootStoryboard, aClass:AnyClass) -> UIViewController{
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        
        let viewController = storyboard.instantiateViewController(withIdentifier: String.className(aClass: aClass))
        return viewController
    }
    
    /** get root viewcontroller from class name */
    class func getRootViewController(storyboard:RootStoryboard, aClass: AnyClass) -> UINavigationController {
        let storyboard = UIStoryboard.storyboard(name: storyboard)
        let viewController = storyboard.viewController(aClass: aClass)
        return viewController as! UINavigationController
    }
    
    class func getRootViewController(nameStoryboard:String, idViewController:String) -> UINavigationController {
        let storyboard = UIStoryboard(name: nameStoryboard, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: idViewController)
        return viewController as! UINavigationController
    }
    
    class func getAppDelegate() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }

    private func getRootViewController() -> UIViewController? {
        let viewDeck = UIApplication.shared.keyWindow?.rootViewController
        return viewDeck
    }
    
    func getRootViewDeckController() -> RootViewDeckController? {
        return getRootViewController() as? RootViewDeckController
    }
    
    @objc var rootTabbarController: RootTabBarController? {
        return RootLinker.sharedInstance.getRootViewDeckController()?.centerViewController as? RootTabBarController
    }
    
    func getRootNav() -> UINavigationController? {
        if let rootViewDeck = getRootViewDeckController(){
            if let tabbarController = rootViewDeck.centerViewController as? UITabBarController{
                return tabbarController.selectedViewController as? UINavigationController
            }
        }
        
        return nil
        
    }
    
    func activeTab(tab: NSInteger) {
        if let rootTabbarViewController = rootTabbarController {
            rootTabbarViewController.selectedIndex =  tab
            AppState.sharedInstance.currentSelectedTab = tab
        }
    }
    
    func viewControllerForLink(link : NSURL, forTab tab : Int? = nil) -> RootViewController {
        _ = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc : RootViewController = RootViewController()
        return vc
    }

    @objc func dismissModal() {
        let viewDeck = UIApplication.shared.keyWindow?.rootViewController as! RootViewDeckController
        let viewController = viewDeck.centerViewController
        viewController.dismiss(animated: true, completion: nil)
    }
}
