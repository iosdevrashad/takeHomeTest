//
//  AppDelegate.swift
//  Simpsons Character Viewer
//
//  Created by Rashad Surratt on 4/23/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.configureSplitVC()        return true
    }
}

extension AppDelegate: UISplitViewControllerDelegate {
    func configureSplitVC() {
        guard let splitViewController = self.window?.rootViewController as? UISplitViewController else { return }
        
        splitViewController.delegate = self
        splitViewController.preferredDisplayMode = .allVisible
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
}

