//
//  SourceView.swift
//  calhacks4
//
//  Created by Brian Hans on 10/7/17.
//  Copyright © 2017 Nick Swift. All rights reserved.
//

import Foundation
import UIKit

class SourceView: UIView {
    
    public let url: URL?
    
    init(title: String, url: URL?, isTitle: Bool) {
        self.url = url
        self.isTitle = isTitle
        super.init(frame: .zero)
        
        setupView(title: title)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: label.intrinsicContentSize.width + 20, height: label.intrinsicContentSize.height + 4)
    }
    
    func setupView(title: String) {
        self.layer.cornerRadius = 2
        self.label.text = title.uppercased()
        
        self.addSubview(label)
        
        NSLayoutConstraint.activate([label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
                                     label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
                                     label.topAnchor.constraint(equalTo: self.topAnchor, constant: 2),
                                     label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2)])
    }
    
    
    
    // MARK: Private variables
    
    private let isTitle: Bool
    
    private lazy var label: UILabel =  {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        if !isTitle {
            self.backgroundColor = .black
            label.textColor = .white
        } else {
            self.layer.borderWidth = 1
            self.layer.borderColor = UIColor.black.cgColor
            self.backgroundColor = .white
            label.textColor = .black
        }
        
        return label
    }()
}
