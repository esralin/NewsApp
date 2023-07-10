//
//  FavoritesTableViewCell.swift
//  NewsApp
//
//  Created by Esra Alın on 9.07.2023.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    var article: FavArticleModel? {
        didSet {
            let imageURL = URL(string: article?.urlToImage ?? FavoritesTableViewCell.noImage)
            coverImageView.setImage(with: imageURL)
            headerLabel.text = article?.title
            descriptionLabel.text = article?.articleDescription ?? "Description not found"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        article = nil
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        article = nil
    }
    
    
}
