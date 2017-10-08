//
//  Article.swift
//  calhacks4
//
//  Created by Brian Hans on 10/7/17.
//  Copyright © 2017 Nick Swift. All rights reserved.
//

import Foundation

struct Article {
    
    let title: String
    let text: String
    var description: String
    let date: String
    let imageURL: URL?
    let tags: [String]
    let refs: [URL]
    let source: String
    
    init() {
        self.title = "Company Scrambles as Weinstein Takes Leave and a Third of the Board Resigns"
        self.text = "The Weinstein Company struggled to perform damage control on Friday amid allegations of rampant sexual harassment by its co-chairman Harvey Weinstein and turmoil among its ranks. One-third of the company’s all-male board resigned, while board members who remained hired an outside law firm to investigate the allegations and announced that Mr. Weinstein would take an indefinite leave of absence immediately.\nMr. Weinstein had said on Thursday that he would take a leave of absence, but it was unclear when he would leave, how long he would be gone, or what it meant for his relationship with the company he co-founded.\n“As Harvey has said, it is important for him to get professional help for the problems he has acknowledged,” said a statement signed by four board "
        self.imageURL = URL(string: "https://static01.nyt.com/images/2017/10/07/us/07xp-weinstein2/07xp-weinstein2-master768.jpg")!
        self.refs = []// [("CNN", URL(string: "https://www.google.com")!), ("Fox", URL(string: "https://www.google.com")!)]
        self.tags = ["Fake News", "Real News", "Trump"]
        self.description = ""
        self.date = ""
        self.source = "Fake"
        let endIndex = text.index(self.text.startIndex, offsetBy: 255, limitedBy: self.text.endIndex) ?? text.endIndex
        self.description = String(self.text[..<endIndex])
    }
    
    init?(json: [String: Any]) {
        guard let title = json["title"] as? String, let text = json["full_text"] as? String, !title.isEmpty && !text.isEmpty else { return nil }
        self.title = title
        self.text = text
        
        self.description = json["desc_text"] as? String ?? ""
        self.tags = json["tags"] as? [String] ?? []
        self.refs = (json["refs"] as? [String] ?? []).flatMap{ URL(string: $0) }.filter{ $0.absoluteString.contains("http") }
        self.source = json["source"] as? String ?? ""
        if let imageString = json["image_url"] as? String {
            self.imageURL = URL(string: imageString)
        } else {
            self.imageURL = nil
        }
        self.date = json["date"] as? String ?? ""
    }
}
