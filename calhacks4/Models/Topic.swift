//
//  NewsPiece.swift
//  calhacks4
//
//  Created by Alexander Dejeu on 10/7/17.
//  Copyright © 2017 Nick Swift. All rights reserved.
//

import Foundation

struct Topic {
  let id: String
  let title: String
  var summary: String
  let imageURL: URL

  init() {
    self.id = "0"
    self.title = "Company Scrambles as Weinstein Takes Leave and a Third of the Board Resigns"
    self.imageURL = URL(string: "https://static01.nyt.com/images/2017/10/07/us/07xp-weinstein2/07xp-weinstein2-master768.jpg")!
    self.summary = "R.I.P NewsPiece - now known as Topic 😭 I wonder if anyone will notice this? 🤔"
    let endIndex = summary.index(self.summary.startIndex, offsetBy: 255, limitedBy: self.summary.endIndex) ?? summary.endIndex
    self.summary = String(self.summary[..<endIndex])
  }

  init(json: [String: Any]) {
    self.id = json["id"] as! String
    self.title = json["title"] as? String ?? ""
    self.summary = json["summary"] as? String ?? ""
    let imageString = json["image_url"] as? String ?? ""
    self.imageURL = URL(string: imageString)!
  }
}
