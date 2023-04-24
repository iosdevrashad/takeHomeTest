//
//  ViewController.swift
//  TheSimpsonsCharacters
//
//  Created by Rashad Surratt on 4/22/23.
//

import UIKit
import Combine

class CharacterListViewController: UIViewController {
    private let tableView = UITableView(frame: .zero, style: .plain)
    
    private var cancellables = Set<AnyCancellable>()
    
    private let viewModel = CharactersViewModel(networkProvider: NetworkManager())
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
        bindViewModel()
        viewModel.getCharacters()
        configureUI()
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
        navigationController?.pushViewController(detailedVC, animated: true)
     
    }
}

