//
//  TrackerSnapshotTests.swift
//  TrackerSnapshotTests
//
//  Created by Ramil Yanberdin on 08.08.2023.
//

import XCTest
import SnapshotTesting
@testable import Tracker

final class TrackerSnapshotTests: XCTestCase {
    func testTrackerVC() {
        let vc = TabBarController()

        assertSnapshot(
            matching: vc,
            as: .image(traits: .init(userInterfaceStyle: .light))
        )
        assertSnapshot(
            matching: vc,
            as: .image(traits: .init(userInterfaceStyle: .dark))
        )
    }
}
