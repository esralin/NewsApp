//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by Esra Alın on 7.07.2023.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var headerLaber: UILabel!
    
    
    var article: Article? {
        didSet {
            let imageURL = URL(string: article?.urlToImage ?? NewsTableViewCell.noImage)
            coverImageView.setImage(with: imageURL)
            headerLaber.text = article?.title
            descriptionLabel.text = article?.description ?? "Description not found"
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
