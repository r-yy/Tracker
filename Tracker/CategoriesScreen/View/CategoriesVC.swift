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

        view.tableView.dataSource = self
        view.tableView.delegate = self

        return view
    }()

    var categories = [String]()

    weak var delegate: CategoriesSelectDelegate?

    var dataProvider: DataProviderProtocol

    init(dataProvider: DataProviderProtocol) {
        self.dataProvider = dataProvider
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        view = categoriesView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getCategories()
        setTitle()
        setTableViewHeight()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkStubImage()
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

    private func checkStubImage() {
        if !categories.isEmpty {
            categoriesView.stubImage.isHidden = true
            categoriesView.stubText.isHidden = true
        }
    }

    private func getCategories() {
        categories = dataProvider.getCategories().map({ $0.title })
    }
}

extension CategoriesVC: CategoriesDelegate {
    func createCategory() {
        let newCategoryVC = NewCategoryVC()
        newCategoryVC.newCategoryView.delegate = newCategoryVC
        newCategoryVC.delegate = self
        newCategoryVC.navigationItem.hidesBackButton = true
        self.navigationController?.pushViewController(newCategoryVC, animated: true)
    }

    func setTableViewHeight() {
        let height = CGFloat(categories.count * 75)
        NSLayoutConstraint.activate([
            categoriesView.tableView.heightAnchor.constraint(
                equalToConstant: height
            )
        ])
    }
}

extension CategoriesVC: NewCategoryVCDelegate {
    func addCategory(category: String) {
        categories.append(category)
        categoriesView.tableView.reloadData()
    }
}
