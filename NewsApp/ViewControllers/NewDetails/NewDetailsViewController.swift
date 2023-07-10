//
//  NewDetailsViewController.swift
//  NewsApp
//
//  Created by Esra Alın on 9.07.2023.
//

import UIKit
import SafariServices
import RealmSwift
import Toast

class NewDetailsViewController: UIViewController {
    
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var newImageView: UIImageView!
    
    private var article: Article
    let realm = try! Realm()
    
  
    
    var favArticleModel = FavArticleModel()
    
    init(article: Article) {
        self.article = article
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Details"
        setProperties(article: self.article)
        if isFav(){
            favButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
        else{
            favButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }

    
    
    @IBAction func actionAddFav(_ sender: UIButton) {
        prepareToAdd(article: self.article)
        addToFav(favArticle: favArticleModel)
    }
    
    
    @IBAction func actionShareButton(_ sender: UIButton) {
        let items = [URL(string: article.url!)]
        let ac = UIActivityViewController(activityItems: items as [Any], applicationActivities: nil)
        present(ac, animated: true)
    }
    
    @IBAction func actionViewSourceButton(_ sender: UIButton) {
        guard let url = URL(string: article.url!) else {
            return
        }
        let viewController = SFSafariViewController(url: url)
        present(viewController,animated: true)
    }
    
    @objc func addToFav(favArticle: FavArticleModel) {
        if control(){
            realm.beginWrite()
            realm.add(favArticleModel)
            try! realm.commitWrite()
            showToast(message: "News added to favorites!")
            favButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }

    }
    
    // Remove news from favorites
    func control() -> Bool {
        let allData = realm.objects(FavArticleModel.self)
        for data in allData {
            if data.url == favArticleModel.url {
                _ = navigationController?.popToRootViewController(animated: true)
                try! realm.write {
                    realm.delete(data)
                }
                return false
            }
        }
        return true
    }
    
    
    func isFav() -> Bool {
        let allData = realm.objects(FavArticleModel.self)
   
        if allData.contains(favArticleModel) {
            return true
            }
        return false
    }
    
    func showToast(message: String) {
        var style = ToastStyle()
        style.backgroundColor =  .black
        self.view.makeToast("\(message)",position: .bottom, style: style)
    }
}

private extension NewDetailsViewController{
    func prepareToAdd(article: Article){
        favArticleModel.title = article.title
        favArticleModel.articleDescription = article.description
        favArticleModel.url = article.url
        favArticleModel.urlToImage = article.urlToImage
        favArticleModel.publishedAt = article.publishedAt
        favArticleModel.author = article.author
    }
    
}

private extension NewDetailsViewController {
    func setProperties(article: Article){
        let imageURL = URL(string: article.urlToImage ?? NewDetailsViewController.noImage)
        newImageView.setImage(with: imageURL)
        
        titleLabel.text = article.title
        authorLabel.text = article.author ?? "No author"
        dateLabel.text = String(article.publishedAt.prefix(upTo: article.publishedAt.index(article.publishedAt.startIndex, offsetBy: 10)))
        descriptionTextView.text = article.description ?? "Description not found"
    }
}


