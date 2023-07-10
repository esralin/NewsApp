//
//  NetworkManager.swift
//  NewsApp
//
//  Created by Esra Alın on 6.07.2023.
//

import Foundation

final class NetworkManager{
    static let shared = NetworkManager()

    
    struct Constants{
        static let topHeadlinesURL = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=6daf1a245b2b42b88a6f4c4bf417105e")
        static let searchURL = "https://newsapi.org/v2/everything?q="
        static let apiKey = "&apiKey=6daf1a245b2b42b88a6f4c4bf417105e"
    }
    
    private init() {}
    
    func getArticles(completion: @escaping (_ newsResponse: NewsResponse) -> Void) {
        
        guard let url =  Constants.topHeadlinesURL else {
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest) { data, urlResponse, error in
            
            guard let data = data else { return }
            
            do {
                
                let newsResponse = try JSONDecoder().decode(NewsResponse.self, from: data)
                completion(newsResponse)
            }
            catch {
                print("--* \(error.localizedDescription)")
            }
            
            
        }.resume()
    }
    
    func search(query: String,completion: @escaping (_ newsResponse: NewsResponse) -> Void) {
        
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        
        
        var urlString = Constants.searchURL + query + Constants.apiKey
        
        
        urlString = urlString.replacingOccurrences(of: " ", with: "+")
        guard let url =  URL(string: urlString) else {
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest) { data, urlResponse, error in
            
            guard let data = data else { return }
            
            do {
                
                let newsResponse = try JSONDecoder().decode(NewsResponse.self, from: data)
                completion(newsResponse)
            }
            catch {
                print("--* \(error.localizedDescription)")
            }
            
            
        }.resume()
    }
    
    
  

}


