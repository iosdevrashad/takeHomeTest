//
//  CharacterTableViewCell.swift
//  Simpsons Character Viewer
//
//  Created by Rashad Surratt on 4/23/23.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {
    
    static let indentifier = "CharacterCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  func configure(character: RelatedTopic) {
        textLabel?.text = character.characterFullDescription.getCharacterName()
        
    }
    

}
