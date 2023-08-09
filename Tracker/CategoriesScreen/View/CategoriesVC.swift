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

    weak var delegate: CategoriesSelectDelegate?

    let categoriesViewModel: CategoriesViewModel

    init(dataProvider: DataProviderProtocol) {
        categoriesViewModel = CategoriesViewModel(dataProvider: dataProvider)
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
        setTitle()
        setTableViewHeight()

        categoriesViewModel.onChange = categoriesView.tableView.reloadData
        categoriesViewModel.categorySelected = { [weak self] category in
            guard let category else { return }
            self?.delegate?.selectCategory(category: category)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkStubImage()
    }

    private func setTitle() {
        let titleLabel = UILabel()
        let title = NSLocalizedString("CATEGORIES_HEADER_LABEL", comment: "")
        titleLabel.text = title
        titleLabel.textColor = .ypBlack
        titleLabel.font = UIFont(
            name: "SF Pro Text Regular",
            size: 18
        )
        self.navigationItem.titleView = titleLabel
    }

    private func checkStubImage() {
        if !categoriesViewModel.categories.isEmpty {
            categoriesView.stubImage.isHidden = true
            categoriesView.stubText.isHidden = true
        }
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
        let height = CGFloat(categoriesViewModel.categories.count * 75)
        NSLayoutConstraint.activate([
            categoriesView.tableView.heightAnchor.constraint(
                equalToConstant: height
            )
        ])
    }
}

extension CategoriesVC: NewCategoryVCDelegate {
    func addCategory(category: String) {
        categoriesViewModel.addCategory(category: category)
    }
}
