//
//  String+Extensions.swift
//  Simpsons Character Viewer
//
//  Created by Rashad Surratt on 4/23/23.
//



import Foundation

extension String {
 
    func getCharacterName() -> String {
        var characterName: String = "Unknown Character Name"
        
        if let index = self.firstIndex(of: "-") {
            let i = self.index(index, offsetBy: -1)
            characterName = String(self[..<i])
        }
        
        return characterName
    }
    
    func getCharacterDescription() -> String {
        var desc: String = "Unknown Character Description"
        
        if let index = self.firstIndex(of: "-") {
            let i = self.index(index, offsetBy: 2)
            desc = String(self[i...])
        }
        
        return desc
    }
}
