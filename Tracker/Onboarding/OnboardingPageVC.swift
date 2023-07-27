//
//  OnboardingPageViewController.swift
//  Tracker
//
//  Created by Ramil Yanberdin on 27.07.2023.
//

import UIKit

final class OnboardingPageVC: UIPageViewController {
    lazy var pages: [OnboardingSlideVC] = {
        let firstPage = OnboardingSlideVC(numberOfPage: 0)
        let secondPage = OnboardingSlideVC(numberOfPage: 1)
        return [firstPage, secondPage]
    }()

    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()

        pageControl.numberOfPages = pages.count
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = .ypBlack
        pageControl.pageIndicatorTintColor = .ypGray
        pageControl.translatesAutoresizingMaskIntoConstraints = false

        return pageControl

    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        delegate = self

        if let first = pages.first {
            setViewControllers([first], direction: .forward, animated: true, completion: nil)
        }

        view.addSubview(pageControl)

        NSLayoutConstraint.activate([
            pageControl.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -134
            ),
            pageControl.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            )
        ])
    }
}
