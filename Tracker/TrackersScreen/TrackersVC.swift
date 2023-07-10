//
//  ViewController.swift
//  Tracker
//
//  Created by Ramil Yanberdin on 10.07.2023.
//

import UIKit

final class TrackersVC: UIViewController {
    let trackersView = TrackersView()

    var categories: [TrackerCategory] = []
    var completedTrackers: [TrackerRecord] = []
    var currentDate: Date = Date()
  
    override func loadView() {
        super.loadView()
        view = trackersView
    }




}

