//
//  CategoryVC.swift
//  Tracker
//
//  Created by Ramil Yanberdin on 10.07.2023.
//

import UIKit

final class CategoriesVC: UIViewController {
    lazy var categoriesView: CategoriesView = {
        let view = CategoriesView()

//        view.tableView.dataSource = self
//        view.tableView.delegate = self

        return view
    }()

    override func loadView() {
        super.loadView()
        view = categoriesView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle()
    }

    private func setTitle() {
        let titleLabel = UILabel()
        titleLabel.text = "Категория"
        titleLabel.textColor = .ypBlack
        titleLabel.font = UIFont(
            name: "SF Pro Text Regular",
            size: 18
        )
        self.navigationItem.titleView = titleLabel
    }
}

extension CategoriesVC: CategoriesDelegate {
    func createCategory() {
        let newCategoryVC = NewCategoryVC()
        newCategoryVC.newCategoryView.delegate = newCategoryVC
        newCategoryVC.navigationItem.hidesBackButton = true
        self.navigationController?.pushViewController(newCategoryVC, animated: true)
    }
}
