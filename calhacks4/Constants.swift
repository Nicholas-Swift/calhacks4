//
//  Constants.swift
//  calhacks4
//
//  Created by Brian Hans on 10/7/17.
//  Copyright © 2017 Nick Swift. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    
    
}

struct Font {
    static let title: UIFont = UIFont.boldSystemFont(ofSize: 24)
    static let subtitle: UIFont = UIFont.systemFont(ofSize: 12)
}

struct Style {
    static func setDefaultStyles() {
        UINavigationBar.appearance().backgroundColor = UIColor.white
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().tintColor = .black
    }
}
