//
//  NewsViewController.swift
//  NewsApp
//
//  Created by Esra Alın on 6.07.2023.
//

import UIKit

class NewsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var articles: [Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "News"
        setupTableView()
        getArticles()
    }
}

// MARK: - Private functions
private extension NewsViewController {
    
    func setupTableView() {
        
        tableView.register(nibName: NewsTableViewCell.nibName)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func getArticles() {
        NetworkManager.shared.getArticles(completion: handleCategoriesResponse(response:))
    }
    
    func handleCategoriesResponse(response: NewsResponse) {
        
        articles = response.articles
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension NewsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.nibName) as? NewsTableViewCell else {
            fatalError("Cell oluşturulamadı!")
        }
        cell.article = articles[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        DispatchQueue.main.async {
            let article = self.articles[indexPath.row]
           // let viewController = ProductsViewController(category: category)
           // self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
