//
//  CategoriesDelegate.swift
//  Tracker
//
//  Created by Ramil Yanberdin on 10.07.2023.
//

import Foundation

protocol CategoriesDelegate: AnyObject {
    func createCategory()
}

protocol CategoriesSelectDelegate: AnyObject {
    func selectCategory(category: String)
}
