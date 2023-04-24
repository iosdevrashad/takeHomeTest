//
//  CharacterViewController.swift
//  The Wire Character Viewer
//
//  Created by Rashad Surratt on 4/24/23.
//

import UIKit
import Combine

class CharacterViewController: UISplitViewController {
    private var viewModel: CharactersViewModel?
    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadViewControllers()
        primaryViewController.reloadData()

    }
    

    private var primaryViewController: CharacterListViewController!
    
    
    private func loadViewControllers() {
        self.primaryViewController = CharacterListViewController()
        self.primaryViewController.delegate = self
        let navController = UINavigationController(rootViewController: self.primaryViewController)
        viewModel = primaryViewController.viewModel
        let detail = DetailViewController()
        detail.networkProvider = NetworkManager()
        
        self.viewControllers = [navController, detail]
        
        viewModel?.$character
            .sink(receiveValue: { character in
                if let character {
                    detail.configure(character: character)
                }
            })
            .store(in: &cancellables)
    }
}

extension CharacterViewController: CharacterListViewControllerDelegate {
    func displayCharacter(character: RelatedTopic) {
        let detailedVC = DetailViewController()
        detailedVC.configure(character: character)
        detailedVC.networkProvider = NetworkManager()
    }
    
}
