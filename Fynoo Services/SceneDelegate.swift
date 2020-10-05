//
//  SceneDelegate.swift
//  Fynoo Services
//
//  Created by Aishwarya on 03/09/20.
//  Copyright © 2020 Aishwarya. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var nav = UINavigationController()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
   
        guard let _ = (scene as? UIWindowScene) else { return }
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        let bounds = UIScreen.main.bounds
        let width = bounds.size.width
        let height = bounds.size.height
        ModalController.saveTheContent(width as AnyObject, WithKey: "width")
        ModalController.saveTheContent(height as AnyObject, WithKey: "height")
        
        AuthorisedUser.shared.getAuthorisedUserCheck()
        UIApplication.shared.statusBarStyle = .default
        selecting_local.DoTheSwizzling()
        UITextField.appearance().tintColor = .gray
        
        if let value = UserDefaults.standard.value(forKey: "AppleLanguages") as? [String]{
            if value[0]=="ar"{
                HeaderHeightSingleton.shared.LanguageSelected = "AR"
            }
            else if value[0]=="en"{
                HeaderHeightSingleton.shared.LanguageSelected = "EN"
            }
        }
        
//         let vc = PersonalRegViewController(nibName: "PersonalRegViewController", bundle: nil)
       let vc = BasedUrlViewController(nibName: "BasedUrlViewController", bundle: nil)
 //       let vc = SplashAnimatedViewController(nibName: "SplashAnimatedViewController", bundle: nil)
        nav = UINavigationController.init(rootViewController: vc)
        IQKeyboardManager.shared.enable = true
        nav.interactivePopGestureRecognizer?.isEnabled = true
        nav.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        nav.setNavigationBarHidden(true, animated: false)
        
        if #available(iOS 13.0, *) {
            window?.overrideUserInterfaceStyle = .light
        }
    }
    
    func ChangeLayout(){
        let preferredLanguage = NSLocale.preferredLanguages[0]
        print(preferredLanguage)
        if preferredLanguage.starts(with: "en"){
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        } else{
           UIView.appearance().semanticContentAttribute = .forceRightToLeft
        }
    }
    
    // SwipGestureRecognizer delegate methods
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool
    {
        if (nav.viewControllers.count ?? 0) > 1 {
            return true
        }
        return false
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return !(otherGestureRecognizer is UIPanGestureRecognizer)
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

extension UIImage {
    func makeImageWithColorAndSize(color: UIColor, size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(CGRect(x:0, y:0, width:size.width, height:size.height))
        var image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
