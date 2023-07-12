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

    override func loadView() {
        super.loadView()
        view = categoriesView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleNotification(_:)),
            name: Notification.Name("SetCategoryTitle"),
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.reloadTableView),
            name: Notification.Name("CategoriesUpdated"),
            object: nil
        )
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkStubImage()
    }

    @objc
    private func handleNotification(_ notification: NSNotification) {
        guard let category = notification.userInfo?["CategoryTitle"] as? String else {
            return
        }
        categories.append(category)
    }

    @objc
    private func reloadTableView(notification: NSNotification) {
        categoriesView.tableView.reloadData()
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
}

extension CategoriesVC: CategoriesDelegate {
    func createCategory() {
        let newCategoryVC = NewCategoryVC()
        newCategoryVC.newCategoryView.delegate = newCategoryVC
        newCategoryVC.navigationItem.hidesBackButton = true
        self.navigationController?.pushViewController(newCategoryVC, animated: true)
    }
}
