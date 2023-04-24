//
//  NetworkManager.swift
//  TheSimpsonsCharacters
//
//  Created by Rashad Surratt on 4/22/23.
//

import UIKit

protocol NetworkProvider {
    func getCharacters() async throws -> [RelatedTopic]
    func downloadImage(from urlString: String) async -> UIImage?
}

enum SimpsonsError: String, Error {
    case incorrectURL
    case responseError
    case decodingError
}

class NetworkManager: NetworkProvider {
   
    private let endPointURL = URL(string: AppConfiguration.apiURL)
    private let baseURL = URL(string: "https://api.duckduckgo.com")
    
    let cache           = NSCache<NSString, UIImage>()
    let decoder = JSONDecoder()
    
     init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
    }
    
    func getCharacters() async throws -> [RelatedTopic] {
        guard let endPoint = endPointURL else {
            throw SimpsonsError.incorrectURL
        }
        
        var request = URLRequest(url: endPoint)
        request.httpMethod = "GET"
       

        let (data, response) = try await URLSession.shared.data(from: endPoint)
        
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw SimpsonsError.responseError
        }
        
        do {
            let result = try decoder.decode(DuckDuckGoResponse.self, from: data)
            return result.relatedTopics
        } catch DecodingError.keyNotFound(let key, let context) {
            fatalError("Failed to decode to missing key '\(key.stringValue)' not found – \(context.debugDescription)")
        } catch DecodingError.typeMismatch(_, let context) {
            fatalError("Failed to decode due to type mismatch – \(context.debugDescription)")
        } catch DecodingError.valueNotFound(let type, let context) {
            fatalError("Failed to decode due to missing \(type) value – \(context.debugDescription)")
        } catch DecodingError.dataCorrupted(_) {
            fatalError("Failed to decode because it appears to be invalid JSON")
        } catch {
            throw SimpsonsError.decodingError
        }
        return []
    }
    
    func downloadImage(from urlString: String) async -> UIImage? {
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey) { return image }
        guard let url = URL(string: urlString) else { return nil }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let image = UIImage(data: data) else { return nil }
            cache.setObject(image, forKey: cacheKey)
            return image
        } catch {
            return nil
        }
    }

}
