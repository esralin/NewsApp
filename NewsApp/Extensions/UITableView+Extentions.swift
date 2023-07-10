//
//  UITableView+Extentions.swift
//  NewsApp
//
//  Created by Esra Alın on 7.07.2023.
//

import UIKit

extension UITableView {
    
    func register(nibName: String) {
        let nib = UINib(nibName: nibName, bundle: nil)
        self.register(nib, forCellReuseIdentifier: nibName)
    }
}
