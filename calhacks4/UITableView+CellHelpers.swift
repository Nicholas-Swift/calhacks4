//
//  UITableView+CellHelpers.swift
//  calhacks4
//
//  Created by Brian Hans on 10/7/17.
//  Copyright © 2017 Nick Swift. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    
    func register(cellClass: AnyClass) {
        self.register(cellClass, forCellReuseIdentifier: String(describing: cellClass))
    }
    
    func dequeueCell<T>(for indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as? T else {
            fatalError("\(String(describing: T.self)) not registered for tableview")
        }
        
        return cell
    }
}
