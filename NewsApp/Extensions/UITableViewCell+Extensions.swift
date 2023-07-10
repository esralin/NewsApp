//
//  UITableViewCell+Extensions.swift
//  NewsApp
//
//  Created by Esra Alın on 7.07.2023.
//

import UIKit

extension UITableViewCell {
    
    static var nibName: String {
        return String(describing: self.self)
    }
    
    static var noImage: String {
        return "https://feb.kuleuven.be/drc/LEER/visiting-scholars-1/image-not-available.jpg"
    }
}
