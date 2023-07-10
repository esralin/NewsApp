//
//  favArticleModel.swift
//  NewsApp
//
//  Created by Esra Alın on 9.07.2023.
//

import Foundation
import RealmSwift


class FavArticleModel: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var articleDescription: String? = ""
    @objc dynamic var url: String? = ""
    @objc dynamic var urlToImage: String? = ""
    @objc dynamic var publishedAt: String = ""
    @objc dynamic var author: String? = ""
}
