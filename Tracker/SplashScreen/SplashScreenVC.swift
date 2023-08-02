//
//  SplashScreenVC.swift
//  Tracker
//
//  Created by Ramil Yanberdin on 28.07.2023.
//

import UIKit

final class SplashScreenVC: UIViewController {
    let splashScreenView: SplashScreenView
    let storeManager: StoreManager

    init() {
        splashScreenView = SplashScreenView()
        storeManager = StoreManager()
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        shouldPresentOnboarding()
    }

    private func shouldPresentOnboarding() {
        guard let window = UIApplication.shared.windows.first else {
            assertionFailure("Failed to invalid configuration")
            return
        }
        if !storeManager.isFirstStart {
            storeManager.isFirstStart = true
            let onboardingVC = OnboardingPageVC()
            window.rootViewController = onboardingVC
        } else {
            let tabBarController = TabBarController()
            window.rootViewController = tabBarController
        }
    }
}
