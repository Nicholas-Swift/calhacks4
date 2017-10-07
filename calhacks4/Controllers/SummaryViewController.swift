//
//  SummaryViewController.swift
//  calhacks4
//
//  Created by Brian Hans on 10/7/17.
//  Copyright © 2017 Nick Swift. All rights reserved.
//

import Foundation
import UIKit

class SummaryViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        self.navigationItem.largeTitleDisplayMode = .never
        self.view.backgroundColor = .white
        
        self.view.addSubview(scrollView)
        scrollView.addSubview(scrollViewContentView)
        scrollViewContentView.addSubview(contentStackView)
        scrollViewContentView.addSubview(separatorLine)
        scrollViewContentView.addSubview(cardScrollView)
        
        for i in 0..<2 {
            let card = Card(title: "Test this card code out cause testing", subtitle: "BRIAN")
            card.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([card.heightAnchor.constraint(equalTo: cardScrollView.heightAnchor, constant: 0.75),
                                         card.centerYAnchor.constraint(equalTo: cardScrollView.centerYAnchor)])
            cardScrollView.addSubview(card)
        }
    }
    
    func setupConstraints() {
        // Container view constraints
        NSLayoutConstraint.activate([scrollViewContentView.topAnchor.constraint(equalTo: self.view.topAnchor),
                                     scrollViewContentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
                                     scrollViewContentView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                                     scrollViewContentView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
                                     scrollViewContentView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                                     scrollViewContentView.trailingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
                                     scrollViewContentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor)])
        
        // Stack view constraints
        NSLayoutConstraint.activate([contentStackView.topAnchor.constraint(equalTo: scrollViewContentView.topAnchor, constant: 35),
                                     contentStackView.leadingAnchor.constraint(equalTo: scrollViewContentView.leadingAnchor, constant: 20),
                                     contentStackView.trailingAnchor.constraint(equalTo: scrollViewContentView.trailingAnchor, constant: -20)])
        // Scroll view constraints
        
        NSLayoutConstraint.activate([scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
                                     scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
                                     scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                                     scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)])
        
        // Separator line constraints
        NSLayoutConstraint.activate([separatorLine.heightAnchor.constraint(equalToConstant: 0.5),
                                     separatorLine.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                                     separatorLine.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                                     separatorLine.topAnchor.constraint(equalTo: contentStackView.bottomAnchor, constant: 35)])
        
        // Second scroll view constraints
        NSLayoutConstraint.activate([cardScrollView.heightAnchor.constraint(equalToConstant: self.view.frame.height * 0.7),
                                     cardScrollView.leadingAnchor.constraint(equalTo: scrollViewContentView.leadingAnchor),
                                     cardScrollView.trailingAnchor.constraint(equalTo: scrollViewContentView.trailingAnchor),
                                     cardScrollView.bottomAnchor.constraint(equalTo: scrollViewContentView.bottomAnchor),
                                     cardScrollView.topAnchor.constraint(equalTo: separatorLine.bottomAnchor, constant: 35)])
    }
    
    // MARK: Private variables
    
    private var scrollViewContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, summaryLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 35
        stackView.alignment = .leading
        
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Font.title
        label.textColor = .black
        label.numberOfLines = 0
        label.text = "title"
        
        return label
    }()
    
    private lazy var summaryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.text = "summary title"
        
        return label
    }()
    
    private lazy var separatorLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.gray.withAlphaComponent(0.35)
        
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .clear
        scrollView.contentInsetAdjustmentBehavior = .never
        
        return scrollView
    }()
    
    private lazy var cardScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        
        return scrollView
    }()
}

extension SummaryViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}
