//
//  StoreManager.swift
//  Tracker
//
//  Created by Ramil Yanberdin on 28.07.2023.
//

import Foundation

final class StoreManager {
    let firstStartKey = "Trckrfrststrt"
    let userDefaults = UserDefaults.standard

    var isFirstStart: Bool {
        didSet {
            userDefaults.set(isFirstStart, forKey: firstStartKey)
        }
    }

    init() {
        isFirstStart = userDefaults.bool(forKey: firstStartKey)
    }
}


