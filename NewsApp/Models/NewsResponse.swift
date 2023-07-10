//
//  NewsResponse.swift
//  NewsApp
//
//  Created by Esra Alın on 7.07.2023.
//

import Foundation


struct NewsResponse: Codable {
    var articles: [Article]
}

struct Article: Codable {
    var source: Source?
    var title: String
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String
    var author: String?
}

struct Source: Codable {
    var name: String
}
