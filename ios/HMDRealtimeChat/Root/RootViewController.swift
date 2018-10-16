//
//  AppDelegate.swift
//  Fitness
//
//  Created by Duc Nguyen on 10/1/16.
//  Copyright © 2016 Reflect Apps Inc. All rights reserved.
//

import Foundation
import ViewDeck

enum BarButtonPosition{
    case right
    case left
}


typealias ViewControllerStoryboardType = (viewController: RootVC, storyboard: RootStoryboard)
protocol RootProtocal: class
{
    func registerNotifications()
    func setDataWhenFirstLoad()
    func setViewWhenDidLoad()
}

class RootViewController : UIViewController, RootProtocal {
    
    var analyticsPageName : String = ""
    var analyticsPageNameBase : String {
        get {
            return ("\(type(of: self))")
        }
    }
    var analyticsPageId : String? = nil
    var isModal = false
    var link : String = ""
    var indicatorView: RootIndicatorView?
    var downloadBtn: UIBarButtonItem!

    // MARK: - View Life
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.automaticallyAdjustsScrollViewInsets = false
        registerNotifications()
        setDataWhenFirstLoad()
        setViewWhenDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        analyticsPageName = analyticsPageNameBase
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        trackScreenView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    deinit {
    }
    
    func showMenuCustomAnimationAddition() {
        // View controllers can override this to provide an additional block of code for the animation block
    }
    
    func dismissKeyboard(){
        self.view.endEditing(true)
    }
    
    // MARK: Layout
    func iPad()->Bool{
        return UIDevice.current.userInterfaceIdiom == .pad
    }
    
    // MARK: Analytics tracking
    
    func trackScreenView() {
        
    }
    
    // MARK: Indicator loading
    // Support figuring out that the page is loading in the app.
    func addIndicatorLoading(blockUI: Bool? = false) {
        
    }
    
    // showloading
    func showLoading(){
        if indicatorView == nil{
            indicatorView = RootIndicatorView()
        }
        indicatorView!.show()
    }
    
    func showLoading(vc:UIViewController){
        if indicatorView == nil{
            indicatorView = RootIndicatorView()
        }
        indicatorView!.show(inController: vc)
    }
    
    // hide loading
    func hideLoading() {
        if let indicatorView = indicatorView{
            indicatorView.dismiss()
            self.indicatorView = nil
        }
    }
    
    func removeNetworkIssueView() {
        if let view  = self.view.viewWithTag(789) {
            UIView.animate(withDuration: 0.3, animations: {
                view.alpha = 0.0
            }, completion: { (hidden) in
                view.removeFromSuperview()
            })
        }
    }
    
    
    // MARK: Root Protocol
    func registerNotifications() {
        
    }
    
    func setDataWhenFirstLoad() {
        
    }
    
    func setViewWhenDidLoad() {
        
    }

    
    // MARK: Bar Button Item
    
    func addImageBarButton(position: BarButtonPosition, image: UIImage, target: Any, action: Selector){
        let barButton = UIBarButtonItem(image: image, style: .plain, target: target, action: action)
        if position == .left{
            self.navigationItem.leftBarButtonItem = barButton
        }else{
            self.navigationItem.rightBarButtonItem = barButton
        }
    }
    
  
    
    func addTitleBarButton(position: BarButtonPosition, title: String, target: Any, action: Selector){
        let barButton = UIBarButtonItem(title: title, style: .plain, target: target, action: action)
        barButton.setTitleTextAttributes([.font : UIFont.systemFont(ofSize: 15, weight: .medium)], for: .normal)
        barButton.tintColor = UIColor.tabbarColor
        if position == .left{
            self.navigationItem.leftBarButtonItem = barButton
        }else{
            self.navigationItem.rightBarButtonItem = barButton
        }

    }
    
    func addImageBarButton(position: BarButtonPosition, image: UIImage, target: Any, action: Selector, isAdd: Bool? = false){
        let barButton = UIBarButtonItem(image: image, style: .plain, target: target, action: action)
        barButton.tintColor = UIColor.tabbarActiveColor
        if position == .left{
            if isAdd! {
                self.navigationItem.leftBarButtonItems?.append(barButton)
            }else {
                self.navigationItem.leftBarButtonItem = barButton
            }
        }else{
            if isAdd! {
                self.navigationItem.rightBarButtonItems?.append(barButton)
            }else {
                self.navigationItem.rightBarButtonItem = barButton
            }
        }
        
    }
    
    func addBackButton() {
        
        self.addImageBarButton(position: .left, image: #imageLiteral(resourceName: "ic_Back"), target: self, action: Selector(("backAction")))
    }
    
    func addMenuButton() {
        
        //create a new button
        let button: UIButton = UIButton(type: UIButtonType.custom)
        //set image for button
        button.setImage(UIImage(named: "menu"), for: .normal)
        //add function for button
        button.addTarget(self, action: Selector(("menuAction")), for: .touchUpInside)
        //set frame
        button.frame = CGRect(x: 0.0, y: 0.0, width: 50.0, height: 44.0)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -20.0, bottom: 0, right: 0)
        
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = barButton
    }
    
    func addSearchButton() {
        //create a new button
        let button: UIButton = UIButton(type: UIButtonType.custom)
        //set image for button
        button.setImage(UIImage(named: "ic_search_bold"), for: .normal)
        //add function for button
        button.addTarget(self, action: Selector(("searchAction")), for: .touchUpInside)
        //set frame
        button.frame = CGRect(x: 0.0, y: 0.0, width: 35.0, height: 44.0)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    func addCloseButton() {
        let img = UIImage(named: "close")!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        let rightBarButtonItem = UIBarButtonItem(image: img, style: UIBarButtonItemStyle.plain, target: self, action: Selector(("closeAction")))
        self.navigationItem.leftBarButtonItem = rightBarButtonItem
    }
    
    func addDoneButton() {
        let backButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: Selector(("doneAction")))
        self.navigationItem.rightBarButtonItem = backButton
    }
    
    func addEditButton() {
        let backButton = UIBarButtonItem(title: "Edit", style: .done, target: self, action: Selector(("editAction")))
        self.navigationItem.rightBarButtonItem = backButton
    }
    
    func addCancelButton() {
        let backButton = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: Selector(("cancelAction")))
        self.navigationItem.rightBarButtonItem = backButton
    }
    
    func addDeleteButton() {
        let backButton = UIBarButtonItem(title: "Delete", style: .done, target: self, action: Selector(("deleteAction")))
        self.navigationItem.rightBarButtonItem = backButton
    }
    
    func addLoginButton(){
        let backButton = UIBarButtonItem(title: "Login", style: .done, target: self, action: Selector(("loginAction")))
        self.navigationItem.rightBarButtonItem = backButton
    }
    
    func addEmptyButton() {
        //create a new button
        let button: UIButton = UIButton(type: UIButtonType.custom)
        //set image for button
        button.setImage(UIImage(named: "emptyimage"), for: .normal)

        //set frame
        button.frame = CGRect(x: 0.0, y: 0.0, width: 50.0, height: 44.0)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -20.0, bottom: 0, right: 0)
        
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = barButton

    }
    
    func addNextButton() {
        //create a new button
        let button: UIButton = UIButton(type: UIButtonType.custom)
        //set image for button
        button.setImage(UIImage(named: "nextBtn"), for: .normal)
        button.setTitle("Next", for: .normal)
        button.titleLabel?.font = UIFont.appFont(name: kFontMontserratBold , fontSize: 12.0)
        
        //add function for button
        button.addTarget(self, action: Selector(("nextAction")), for: .touchUpInside)
        //set frame
        button.frame = CGRect(x: 0.0, y: 0.0, width: 50.0, height: 44.0)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 0)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        button.setTitleColor(UIColor.white, for: .normal)
        
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    
    func addApplyButton() {
        //create a new button
        let button: UIButton = UIButton(type: UIButtonType.custom)
        //set image for button
        button.setImage(UIImage(named: "nextBtn"), for: .normal)
        button.setTitle("Apply", for: .normal)
        button.titleLabel?.font = UIFont.appFont(name: kFontMontserratBold , fontSize: 12.0)
        
        //add function for button
        button.addTarget(self, action: Selector(("applyAction")), for: .touchUpInside)
        //set frame
        button.frame = CGRect(x: 0.0, y: 0.0, width: 50.0, height: 44.0)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 0)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        button.setTitleColor(UIColor.white, for: .normal)
        
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    func addSaveButton(){
        let backButton = UIBarButtonItem(title: "Save", style: .done, target: self, action: Selector(("saveAction")))
        self.navigationItem.rightBarButtonItem = backButton
    }
    
    func addSendButton() {
        let backButton = UIBarButtonItem(title: "Send", style: .done, target: self, action: Selector(("sendAction")))
        self.navigationItem.rightBarButtonItem = backButton
    }
    
    func removeBarButtonItems() {
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.rightBarButtonItem = nil
    }
    
    func removeRightBarButtonItem() {
        self.navigationItem.rightBarButtonItem = nil
    }
    
    func printFonts() {
       let fontFamilyNames = UIFont.familyNames
        for familyName in fontFamilyNames {
            print("------------------------------")
            print("Font Family Name = [\(familyName)]")
            let names = UIFont.fontNames(forFamilyName: familyName )
            print("Font Names = [\(names)]")
        }   
 
    }
    
    func setApplyButtonDisable(enable: Bool){
        //create a new button
        let button: UIButton = UIButton(type: UIButtonType.custom)
        //set image for button
        button.setImage(UIImage(named: "nextBtn"), for: .normal)
        button.setTitle("Apply", for: .normal)
        button.titleLabel?.font = UIFont.appFont(name: kFontMontserratBold , fontSize: 12.0)
        button.titleLabel?.alpha = 0.5
        //add function for button
        //button.addTarget(self, action: Selector(("applyAction")), for: .touchUpInside)
        //set frame
        button.frame = CGRect(x: 0.0, y: 0.0, width: 50.0, height: 44.0)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 0)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        button.setTitleColor(UIColor.white, for: .normal)
        
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButton

    }
    
//    func setPostButtonEnable(enable: Bool){
//        var attrs: [NSAttributedStringKey: Any] = self.navigationItem.rightBarButtonItem?.titleTextAttributes(for: .normal) as? [NSAttributedStringKey: Any] ?? [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)]
//        attrs[NSAttributedStringKey.foregroundColor] = enable ? UIColor.white : UIColor.white.withAlphaComponent(0.5)
//        self.navigationItem.rightBarButtonItem?.setTitleTextAttributes(attrs, for: .normal)
//        
//    }
    
    
    // MARK: Update Color
    func updateStatusBarColor(dark: Bool) {
        if dark {
            UIApplication.shared.statusBarStyle = .default
        } else {
            UIApplication.shared.statusBarStyle = .lightContent
        }
    }
    
    // hide title view of the navigation bar. it does not hide the nav totallly
    func hideNavigation(hide: Bool) {
    }
    
    func removeNavTotally() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func loadNavTotally() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func displayContentController(content: UIViewController, hostVC: UIViewController) {
        RootLinker.sharedInstance.rootNav?.addChildViewController(content)
        RootLinker.sharedInstance.rootNav?.view.addSubview(content.view)
        RootLinker.sharedInstance.rootNav?.didMove(toParentViewController: hostVC)
    }
    
    func hideContentController(content: UIViewController) {
        content.willMove(toParentViewController: nil)
        content.view.removeFromSuperview()
        content.removeFromParentViewController()
    }
    
    func postNotification(name: Notification.Name){
        NotificationCenter.default.post(name: name, object: nil)
    }

    func addNotification(name: Notification.Name, actionHandler: ((Notification)->())?){
        NotificationCenter.default.addObserver(forName: name, object: nil, queue: nil) { (noti) in
            actionHandler?(noti)
        }
    }
    
    func addNotification(name: Notification.Name, actionHandler: (()->())?){
        self.addNotification(name: name) { (noti) in
            actionHandler?()
        }
    }
    
   
    
    func hideNavigationBarWithOutBlackArea(color:UIColor=UIColor.white){
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.view.backgroundColor = color
    }
}

// MARK: - Navigation
extension UIViewController {
    
    func openLeftNavigation() {
        if let rootViewDeck = RootLinker.sharedInstance.rootViewDeckController {
            rootViewDeck.open(.left, animated: true)
        }
    }
    
    func closeLeftNavigation() {
        if let rootViewDeck = RootLinker.sharedInstance.rootViewDeckController {
            rootViewDeck.open(.none, animated: true)
        }
    }

    func pushVC(sohdaVC: RootVC, animation: RootNavigationPushAnimation? = nil, sohdaStoryboard: RootStoryboard? = nil) {
        
        // get the storyboard
        var sty = self.storyboard
        if let mySohdaStory = sohdaStoryboard {
            sty = UIStoryboard(name: mySohdaStory.rawValue, bundle: Bundle.main)
        }
        
        if let vc = sty?.instantiateViewController(withIdentifier: sohdaVC.rawValue) {
            
            // get root nav by storyboard and the nav name
            let rootNav = RootLinker.sharedInstance.rootNav
            
            // push view
            let animated = animation ?? RootNavigationPushAnimation.Default
            switch animated {
            case RootNavigationPushAnimation.Default:
                rootNav?.pushViewController(vc, animated: true)
            case RootNavigationPushAnimation.BottomTop:
                let transition = CATransition()
                transition.duration = 0.3
                transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
                transition.type = kCATransitionPush
                transition.subtype = kCATransitionFromTop
                navigationController?.view.layer.add(transition, forKey: kCATransition)
                navigationController?.pushViewController(vc, animated: false)
            default:
                break
            }
            
        }
    }
    
    func pushVC(vc: UIViewController, animation: RootNavigationPushAnimation? = nil){
        
        // get root nav by storyboard and the nav name
        let rootNav = RootLinker.sharedInstance.rootNav
        
        // push view
        let animated = animation ?? RootNavigationPushAnimation.Default
        switch animated {
        case RootNavigationPushAnimation.Default:
            rootNav?.pushViewController(vc, animated: true)
        case RootNavigationPushAnimation.BottomTop:
            let transition = CATransition()
            transition.duration = 0.3
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromTop
            navigationController?.view.layer.add(transition, forKey: kCATransition)
            navigationController?.pushViewController(vc, animated: false)
        default:
            break
        }
    }
    
    func popVCToViewControllerByRootNav(to sohdaVC: RootVC) {
        
        // get root nav by storyboard and the nav name
        let rootNav = RootLinker.sharedInstance.rootNav
        Log(items: rootNav?.viewControllers)
        if let viewControllers = rootNav?.viewControllers {
            for aViewController:UIViewController in viewControllers {
                let vc = String(describing: type(of: aViewController))
                if sohdaVC.rawValue == vc {
                    rootNav?.popToViewController(aViewController, animated: true)
                }
            }
        }
    }
    
    func popVCToRoot() {
        // get root nav by storyboard and the nav name
        let rootNav = RootLinker.sharedInstance.rootNav
        rootNav?.popToRootViewController(animated: true)
        
    }
    
    func popVC(to sohdaVC: RootVC, sohdaStoryboard: RootStoryboard?=nil){
        var sty = self.storyboard
        if let mySohdaStory = sohdaStoryboard {
            sty = UIStoryboard(name: mySohdaStory.rawValue, bundle: Bundle.main)
        }
        if let vc = sty?.instantiateViewController(withIdentifier: sohdaVC.rawValue){
            self.navigationController?.setViewControllers([vc], animated: true)
        }
    }
    
    func isOpenning() -> Bool {
//        let userDefaults = UserDefaults.standard
//        return (userDefaults.bool(forKey: keyConfigRequestServerEpRate) == true)
        return true
    }
    
    func popVC(animation: RootNavigationPushAnimation? = nil) {
        
        // get root nav by storyboard and the nav name
        let rootNav = RootLinker.sharedInstance.rootNav
        
        // get root nav by storyboard and the nav name
        let animated = animation ?? RootNavigationPushAnimation.Default
        
        switch animated {
            
        case RootNavigationPushAnimation.Default:
            _ = rootNav?.popViewController(animated: true)
            
        case RootNavigationPushAnimation.BottomTop:
            let transition = CATransition()
            transition.duration = 0.3
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            transition.type = kCATransitionFade
            transition.subtype = kCATransitionFromBottom
            navigationController?.view.layer.add(transition, forKey:kCATransition)
            let _ = navigationController?.popViewController(animated: false)
            
        default:
            break
        }
    }
    

    
    private func getNavRootByName(sohdaStory: RootStoryboard, sohdaNav: RootNav) -> UINavigationController {
        let rootViewController =  RootLinker.getRootViewController(nameStoryboard: sohdaStory.rawValue, idViewController: sohdaNav.rawValue)
        return rootViewController
    }
    
    private func getStoryBoardNameBy(sohdaNav: RootNav) -> RootStoryboard {
        
        var nameStoryboard = RootStoryboard.Invalid
        switch sohdaNav {
            
        case RootNav.Home:
            nameStoryboard = RootStoryboard.Main
        }
        return nameStoryboard
    }
    
    func switchNav(sohdaNav: RootNav) {
        let rootMaster = RootLinker.sharedInstance.rootViewDeckController
        let sohdaStory = getStoryBoardNameBy(sohdaNav: sohdaNav)
        let navSwitch = getNavRootByName(sohdaStory: sohdaStory, sohdaNav: sohdaNav)
        rootMaster?.centerViewController = navSwitch
    }
}


