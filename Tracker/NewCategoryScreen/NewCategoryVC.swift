//
//  NewCategoryVC.swift
//  Tracker
//
//  Created by Ramil Yanberdin on 10.07.2023.
//

import UIKit

final class NewCategoryVC: UIViewController {
    lazy var newCategoryView: NewCategoryView = {
        let view = NewCategoryView()

//        view.tableView.dataSource = self
//        view.tableView.delegate = self

        return view
    }()

    override func loadView() {
        super.loadView()
        view = newCategoryView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle()
    }

    private func setTitle() {
        let titleLabel = UILabel()
        titleLabel.text = "Новая категория"
        titleLabel.textColor = .ypBlack
        titleLabel.font = UIFont(
            name: "SF Pro Text Regular",
            size: 18
        )
        self.navigationItem.titleView = titleLabel
    }
}

extension NewCategoryVC: NewCategoryDelegate {
    func saveCategory() {
        let categoriesVC = CategoriesVC()
        categoriesVC.categoriesView.delegate = categoriesVC
        categoriesVC.navigationItem.hidesBackButton = true
        self.navigationController?.pushViewController(categoriesVC, animated: true)
    }
}
