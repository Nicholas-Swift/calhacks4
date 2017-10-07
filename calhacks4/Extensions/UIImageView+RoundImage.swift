//
//  UIImageView+CircleImage.swift
//  calhacks4
//
//  Created by Nick Swift on 10/6/17.
//  Copyright © 2017 Nick Swift. All rights reserved.
//

import UIKit

extension UIImageView {
  
  func roundImage() {
    self.layer.masksToBounds = true
    self.layer.cornerRadius = self.frame.size.width / 2
  }
  
}
