//
//  CategoriesViewModel.swift
//  Tracker
//
//  Created by Ramil Yanberdin on 31.07.2023.
//

import Foundation

final class CategoriesViewModel {
    var onChange: (() -> Void)?

    private(set) var categories: [String] = [] {
        didSet {
            onChange?()
        }
    }

    private let dataProvider: DataProviderProtocol

    init(dataProvider: DataProviderProtocol) {
        self.dataProvider = dataProvider
        getCategories()
    }

    func addCategory(category: String) {
        categories.append(category)
    }

    private func getCategories() {
        categories = dataProvider.getCategories().map({ $0.title })
    }
}
