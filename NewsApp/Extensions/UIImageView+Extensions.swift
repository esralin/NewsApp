//
//  UIImageView+Extensions.swift
//  NewsApp
//
//  Created by Esra Alın on 7.07.2023.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func setImage(with url: URL?) {
        
        guard let url = url else {
            self.image = nil
            return
        }
        
        self.kf.setImage(with: url)
    }
}
