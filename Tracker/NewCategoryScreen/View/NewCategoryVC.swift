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

    weak var delegate: NewCategoryVCDelegate?

    override func loadView() {
        super.loadView()
        view = newCategoryView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle()

        let tap = UITapGestureRecognizer(
            target: self, action: #selector(dismissKeyboard)
        )
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
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

    @objc
    private func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension NewCategoryVC: NewCategoryDelegate {
    func saveCategory() {
        delegate?.addCategory(category: categoryTitle)
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
