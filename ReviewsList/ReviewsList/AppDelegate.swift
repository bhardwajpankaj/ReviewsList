//
//  AppDelegate.swift
//  ReviewsList
//
//  Created by Pankaj Bhardwaj on 02/08/19.
//  Copyright © 2019 Pankaj Bhardwaj. All rights reserved.
//

import UIKit

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        startAppLaunchAnimation()
        
        return true
    }
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func startAppLaunchAnimation(){
        
        guard let appWindow = self.window else{
            return
        }
        
        let imageWrapperView = UIView()
        imageWrapperView.frame = appWindow.frame
        imageWrapperView.backgroundColor = .white
        
        let imageView = UIImageView(frame : CGRect(x:0,y:0,width: 120,height: 120))
        imageView.image = UIImage.init(imageLiteralResourceName: "Icon-120")
        
        imageView.frame = CGRect(x: (imageWrapperView.frame.size.width - imageView.frame.size.width)/2, y: (imageWrapperView.frame.size.height - imageView.frame.size.height)/2, width : imageView.frame.size.width, height: imageView.frame.size.height)
        imageWrapperView.addSubview(imageView)
        
        appWindow.rootViewController?.view.addSubview(imageWrapperView)
        UIView.animate(withDuration: 0.8, animations: {
            imageView.transform = CGAffineTransform.init(scaleX: 2.0 , y: 2.0)
            
        }) { (completed) in
            imageWrapperView.removeFromSuperview()
        }
    }
}

