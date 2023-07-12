//
//  NewCategoryVC.swift
//  Tracker
//
//  Created by Ramil Yanberdin on 10.07.2023.
//

import UIKit

final class NewCategoryVC: UIViewController {
    private var categoryTitle = String()

    lazy var newCategoryView: NewCategoryView = {
        let view = NewCategoryView()

        view.textField.delegate = self

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
        NotificationCenter.default.post(
            name: NSNotification.Name(rawValue: "SetCategoryTitle"),
            object: nil,
            userInfo: ["CategoryTitle": categoryTitle]
        )
        NotificationCenter.default.post(
            name: Notification.Name("CategoriesUpdated"),
            object: nil
        )
        navigationController?.popViewController(animated: true)
    }
}

extension NewCategoryVC: UITextFieldDelegate {
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else {
            return false
        }

        let updatedText = currentText.replacingCharacters(
            in: stringRange, with: string
        )

        if updatedText.count <= 38 {
            categoryTitle = updatedText
            return true
        } else {
            return false
        }
    }
}
