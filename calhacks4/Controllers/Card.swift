//
//  Card.swift
//  calhacks4
//
//  Created by Brian Hans on 10/7/17.
//  Copyright © 2017 Nick Swift. All rights reserved.
//

import Foundation
import UIKit

class Card: UIView {
    
    init(title: String, subtitle: String?) {
        self.title = title
        self.subtitle = subtitle
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    func setupViews() {
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.gray.cgColor
        self.backgroundColor = .black
        
        self.addSubview(titleLabel)
        self.addSubview(subtitleLabel)
        
        NSLayoutConstraint.activate([titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 25),
                                     titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
                                     titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
                                     titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -25)])
        
        NSLayoutConstraint.activate([subtitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15),
                                     subtitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20)])
        
        NSLayoutConstraint.activate([self.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.375)])
        
    }
    
    // MARK: Private variables
    
    private let title: String
    private let subtitle: String?
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = title
        label.font = Font.cardTitle
        label.textColor = .black
        
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = subtitle
        label.font = Font.cardSubtitle
        label.textColor = .black
        
        return label
    }()
    
    
}
