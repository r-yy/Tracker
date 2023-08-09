//
//  AnalyticsService.swift
//  Tracker
//
//  Created by Ramil Yanberdin on 09.08.2023.
//

import Foundation
import YandexMobileMetrica

final class AnalyticsService {
    static func activate() {
        guard let configuration = YMMYandexMetricaConfiguration(
          apiKey: "934511d1-7ae1-4e29-b775-be4664f0a943") else { return }

        YMMYandexMetrica.activate(with: configuration)
    }

    static func report(event: String, screen: String, item: String) {
        YMMYandexMetrica.reportEvent(event, parameters: [screen: item], onFailure: { error in
            print("REPORT ERROR: %@", error.localizedDescription)
        })
    }
}
