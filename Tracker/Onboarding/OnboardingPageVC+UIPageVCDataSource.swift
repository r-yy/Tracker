//
//  OnboardingPageVC+UIPageVCDataSource.swift
//  Tracker
//
//  Created by Ramil Yanberdin on 27.07.2023.
//

import UIKit

extension OnboardingPageVC: UIPageViewControllerDataSource {
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController
    ) -> UIViewController? {
        guard let viewController = viewController as? OnboardingSlideVC,
              let viewControllerIndex = pages.firstIndex(of: viewController) else {
            return nil
        }

        var previousIndex = viewControllerIndex - 1

        if previousIndex < 0 {
            previousIndex = viewControllerIndex + 1
        }

        return pages[previousIndex]
    }

    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController
    ) -> UIViewController? {
        guard let viewController = viewController as? OnboardingSlideVC,
              let viewControllerIndex = pages.firstIndex(of: viewController) else {
            return nil
        }

        var nextIndex = viewControllerIndex + 1

        if nextIndex == pages.count {
            nextIndex = viewControllerIndex - 1
        }

        return pages[nextIndex]
    }

    
}
