//
//  CategoriesViewModel.swift
//  Tracker
//
//  Created by Ramil Yanberdin on 31.07.2023.
//

import Foundation

final class CategoriesViewModel {
    var onChange: (() -> Void)?
    var categorySelected: ((_: String?) -> Void)?

    private(set) var categories: [String] = [] {
        didSet {
            onChange?()
        }
    }

    private(set) var chosenCategory: String? {
        didSet {
            categorySelected?(chosenCategory)
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

    func selectCategory(category: String) {
        chosenCategory = category
    }

    private func getCategories() {
        categories = dataProvider.getCategories().map({ $0.title })
    }
}
