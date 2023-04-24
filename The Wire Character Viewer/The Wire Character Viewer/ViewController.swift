//
//  ViewController.swift
//  The Wire Character Viewer
//
//  Created by Rashad Surratt on 4/23/23.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
       configureUI()
    }
    
    private func configureUI() {
        let split = UISplitViewController(style: .doubleColumn)
        self.addChild(split)
        self.view.addSubview(split.view)
        split.view.frame = self.view.bounds
        split.view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        split.didMove(toParent: self)
        
        let characterListNavController = UINavigationController(rootViewController: CharacterListViewController())
        let detailedListViewController = UINavigationController(rootViewController: DetailViewController())
        
        split.setViewController(characterListNavController, for: .primary)
        split.setViewController(detailedListViewController, for: .secondary)
    }
}

