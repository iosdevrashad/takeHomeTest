//
//  DetailViewController.swift
//  TheSimpsonsCharacters
//
//  Created by Rashad Surratt on 4/23/23.
//

import UIKit

class DetailViewController: UIViewController {
    
    private let titleLabel = UILabel()
    private let imageView = UIImageView()
    private let descriptionLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
    }
    
    var networkProvider: NetworkProvider? = nil
    
    func configure(character: RelatedTopic) {
        titleLabel.text = character.characterFullDescription.getCharacterName()
        titleLabel.font = .boldSystemFont(ofSize: 19)
        if character.icon.characterImgUrl.isEmpty {
            imageView.image = UIImage(named: "NO IMAGE")?.imageResized(to: CGSize(width: 250, height: 250))
        } else {
            Task {
                imageView.image = await networkProvider?.downloadImage(from: "https://duckduckgo.com"+character.icon.characterImgUrl)?.imageResized(to: CGSize(width: 150, height: 150))
            }
        }
        
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleToFill
        descriptionLabel.numberOfLines = 0
        descriptionLabel.text = character.characterFullDescription.getCharacterDescription()
    }
    
    private func setupUI() {
        view.addSubview(titleLabel)
        view.addSubview(imageView)
        view.addSubview(descriptionLabel)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            titleLabel.bottomAnchor.constraint(equalTo: imageView.topAnchor, constant: -10),
            imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            imageView.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -20),
            descriptionLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            descriptionLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200)
            

        ])
    }
    

}
