//
//  Extensions.swift
//  TriviaRich-iOS
//
//  Created by Matthew Rigdon on 9/20/17.
//  Copyright © 2017 com.rigdon. All rights reserved.
//

import UIKit

enum TriviarichFontStyle {
    case regular
    case medium
    case boldItalic
}

extension UIView {
    func removeSubviews() {
        subviews.forEach { $0.removeFromSuperview() }
    }
}

extension UIViewController {
    func removeSubviews() {
        view.subviews.forEach { $0.removeFromSuperview() }
    }
}

extension UIFont {
    static func triviarich(style: TriviarichFontStyle = .regular, size: CGFloat = 17) -> UIFont {
        switch style {
        case .regular:
            return UIFont(name: "AvenirNext-Regular", size: size)!
        case .medium:
            return UIFont(name: "AvenirNext-Medium", size: size)!
        case .boldItalic:
            return UIFont(name: "AvenirNext-BoldItalic", size: size)!
        }
    }
}

extension UIColor {
    class var triviarichGreen: UIColor {
        return UIColor(red: 46/255, green: 204/255, blue: 113/255, alpha: 1)
    }
}

extension CGFloat {
    var half: CGFloat {
        return self / 2
    }
}
