//
//  CharactersViewModel.swift
//  TheSimpsonsCharacters
//
//  Created by Rashad Surratt on 4/23/23.
//

import Foundation
import Combine

class CharactersViewModel: ObservableObject {
    @Published var characters = [RelatedTopic]()
    
    @Published var character: RelatedTopic?
    
    private let networkProvider: NetworkProvider
    
    init(networkProvider: NetworkProvider) {
        self.networkProvider = networkProvider
    }
    
    func getCharacters() {
        Task {
            do {
                characters = try await networkProvider.getCharacters()
            } catch {
                // handle error
                print("No Characters")
            }
        }
    }
    
    
}
