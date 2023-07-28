//
//  OnboardingPageVC+UIPagesVCDelegate.swift
//  Tracker
//
//  Created by Ramil Yanberdin on 27.07.2023.
//

import UIKit

extension OnboardingPageVC: UIPageViewControllerDelegate {
    func pageViewController(
        _ pageViewController: UIPageViewController,
        didFinishAnimating finished: Bool,
        previousViewControllers: [UIViewController],
        transitionCompleted completed: Bool
    ) {
        if let currentViewController = pageViewController.viewControllers?.first as? OnboardingSlideVC,
            let currentIndex = pages.firstIndex(of: currentViewController) {
            pageControl.currentPage = currentIndex
        }
    }
}

