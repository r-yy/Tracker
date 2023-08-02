//
//  OnboardingSlideVC.swift
//  Tracker
//
//  Created by Ramil Yanberdin on 27.07.2023.
//

import UIKit

final class OnboardingSlideVC: UIViewController {
    lazy var onboardingView: OnboardingView = {
        let view = OnboardingView()

        view.configView(page: numberOfPage)
        view.delegate = self

        return view
    }()

    var numberOfPage: Int

    override func loadView() {
        super.loadView()
        view = onboardingView
    }

    init(numberOfPage: Int) {
        self.numberOfPage = numberOfPage
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension OnboardingSlideVC: OnboardingViewDelegate {
    func startApp() {
        guard let window = UIApplication.shared.windows.first else {
            assertionFailure("Failed to invalid configuration")
            return
        }
        let tabBarController = TabBarController()
        tabBarController.modalPresentationStyle = .fullScreen
        tabBarController.modalTransitionStyle = .crossDissolve
        present(tabBarController, animated: true)
    }
}
