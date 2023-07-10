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
    
    private let searchViewController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "News"
        setupTableView()
        getArticles()
        createSearchBar()
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
        NetworkManager.shared.getArticles(completion: handleArticlesResponse(response:))
    }
    
    func handleArticlesResponse(response: NewsResponse) {
        
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
            let viewController = NewDetailsViewController(article: article)
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

extension NewsViewController: UISearchBarDelegate{
    func createSearchBar() {
        navigationItem.searchController = searchViewController
        searchViewController.searchBar.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else {
            return
        }
        NetworkManager.shared.search(query: text, completion: handleSearchResponse(response:))
    }
    
    func handleSearchResponse(response: NewsResponse) {
        
        articles = response.articles 
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.searchViewController.dismiss(animated: true, completion: nil)
        }
    }
}
