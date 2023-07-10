//
//  FavoritesViewController.swift
//  NewsApp
//
//  Created by Esra Alın on 9.07.2023.
//

import UIKit
import RealmSwift

class FavoritesViewController: UIViewController {



    @IBOutlet var tableView: UITableView!
    
    var favArticles = [FavArticleModel]()
  
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favorites"
        getFavArticles()
        setupTableView()
        tableView.reloadData()

    }
    
    private func getFavArticles() {
        favArticles = [FavArticleModel]()
        let allData = realm.objects(FavArticleModel.self)
        for data in allData.reversed() {
            favArticles.append(data)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        title = "Favorites"
        getFavArticles()
        setupTableView()
        tableView.reloadData()
    }

}

private extension FavoritesViewController{
    func setupTableView() {
        tableView.register(nibName: FavoritesTableViewCell.nibName)
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.favArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesTableViewCell.nibName) as? FavoritesTableViewCell else {
            fatalError("Cell oluşturulamadı!")
        }
        cell.article = favArticles[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
        DispatchQueue.main.async {
            let article = self.favArticles[indexPath.row]
            let segueObject: Article = Article(source:nil, title:article.title, description: article.articleDescription, url: article.url, urlToImage: article.urlToImage, publishedAt: article.publishedAt,author: article.author)
            let viewController = NewDetailsViewController(article: segueObject)
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
