//
//  ScheduleDelegte.swift
//  Tracker
//
//  Created by Ramil Yanberdin on 10.07.2023.
//

import Foundation

protocol ScheduleDelegate: AnyObject {
    func setDays()
    func addDay(cell: ScheduleCell)
}
