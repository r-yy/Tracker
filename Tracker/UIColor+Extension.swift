//
//  Colors+Extension.swift
//  Tracker
//
//  Created by Ramil Yanberdin on 10.07.2023.
//

import UIKit

extension UIColor {
    static var ypBlue: UIColor { UIColor(named: "blue") ?? UIColor.blue }
    static var ypWhite: UIColor { UIColor(named: "white") ?? UIColor.white }
    static var ypDateGray: UIColor { UIColor(named: "dateGray") ?? UIColor.lightGray }
    static var ypBlack: UIColor { UIColor(named: "black") ?? UIColor.black }
    static var ypGray: UIColor { UIColor(named: "gray") ?? UIColor.gray }
    static var ypRed: UIColor { UIColor(named: "red") ?? UIColor.red }
}

extension UIColor {
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.currentIndex = hex.startIndex

        var rgbValue: UInt64 = 0

        scanner.scanHexInt64(&rgbValue)

        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff

        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff,
            alpha: 1
        )
    }
}
