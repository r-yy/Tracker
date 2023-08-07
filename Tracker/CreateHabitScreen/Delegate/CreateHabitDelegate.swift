//
//  CreateHabitDelegate.swift
//  Tracker
//
//  Created by Ramil Yanberdin on 11.07.2023.
//

import Foundation

protocol CreateHabitDelegate: AnyObject {
    var trackerToEdit: Tracker? { get set }

    func closeWindow()
    func createTracker()
    func clearTextField()
    func editTracker()
}
