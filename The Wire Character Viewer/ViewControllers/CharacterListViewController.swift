//
//  ViewController.swift
//  TheSimpsonsCharacters
//
//  Created by Rashad Surratt on 4/22/23.
//

import UIKit
import Combine

protocol CharacterListViewControllerDelegate: AnyObject {
    func displayCharacter(character: RelatedTopic)
}

class CharacterListViewController: UIViewController {
    private let tableView = UITableView(frame: .zero, style: .plain)
    
    private var cancellables = Set<AnyCancellable>()
    
    let viewModel = CharactersViewModel(networkProvider: NetworkManager())
    
    var delegate: CharacterListViewControllerDelegate?
    
    func reloadData() {
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
        bindViewModel()
        viewModel.getCharacters()
        configureUI()
        configureSearchController()
    }
    
    private func bindViewModel() {
        viewModel.$characters
            .receive(on: DispatchQueue.main)
            .sink { characters in
                self.tableView.reloadData()
            }
            .store(in: &cancellables)
    }
    
    private func configureUI() {
        view.backgroundColor  = .systemBackground
        configureTableView()
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        
        tableView.frame = view.bounds
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: CharacterTableViewCell.indentifier)
    }
    
    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search Character"
        searchController.obscuresBackgroundDuringPresentation = true
        navigationItem.searchController = searchController
    }
    
}

extension CharacterListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.indentifier) as? CharacterTableViewCell
        let character = viewModel.characters[indexPath.row]
        cell?.configure(character: character)
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailedVC = DetailViewController()
        let character = viewModel.characters[indexPath.row]
        detailedVC.configure(character: character)
        detailedVC.networkProvider = NetworkManager()
        delegate?.displayCharacter(character: character)
        viewModel.character = character
        if UIDevice.current.userInterfaceIdiom == .phone {
            navigationController?.pushViewController(detailedVC, animated: true)
        }
    
    }
}

extension CharacterListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        var timer: Timer?
        guard let filter = searchBar.text, !filter.isEmpty else { return }
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            self.viewModel.characters = self.viewModel.characters.filter { $0.characterFullDescription.lowercased().contains(filter.lowercased()) }
            self.tableView.reloadData()
        })
  
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.getCharacters()
        self.tableView.reloadData()
    }
}

