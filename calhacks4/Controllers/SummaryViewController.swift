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
    
    
    init(topic: Topic) {
        self.topic = topic
        self.viewModel = SummaryViewModel(id: topic.id)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        viewModel.fetchItems() { articles in
            var lastCard: UIView?
            var trailingSpace: CGFloat = 0
            for (index, article) in articles.enumerated() {
                let card = Card(article: article)
                card.translatesAutoresizingMaskIntoConstraints = false
                card.backgroundColor = index < 1 ? .white : .black
                self.cardScrollView.addSubview(card)
                
                NSLayoutConstraint.activate([card.heightAnchor.constraint(equalTo: self.cardScrollView.heightAnchor, multiplier: 0.85),
                                             card.centerYAnchor.constraint(equalTo: self.cardScrollView.centerYAnchor)])
                
                if let lastCard = lastCard {
                    card.leadingAnchor.constraint(equalTo: lastCard.leadingAnchor, constant: self.cardScrollView.frame.width).isActive = true
                    self.cardScrollView.layoutIfNeeded()
                    trailingSpace = card.frame.origin.x
                } else {
                    card.centerXAnchor.constraint(equalTo: self.cardScrollView.centerXAnchor).isActive = true
                }
                
                card.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.articlePressed(sender:))))
                lastCard = card
            }
            
            if let lastCard = lastCard {
                self.cardScrollView.trailingAnchor.constraint(equalTo: lastCard.trailingAnchor, constant: trailingSpace).isActive = true
            }
        }
    }
    
    func setupViews() {
        self.navigationItem.largeTitleDisplayMode = .never
        self.view.backgroundColor = .white
        
        self.view.addSubview(scrollView)
        scrollView.addSubview(scrollViewContentView)
        scrollViewContentView.addSubview(contentStackView)
        scrollViewContentView.addSubview(separatorLine)
        scrollViewContentView.addSubview(cardScrollView)
    }
    
    func setupConstraints() {
        // Container view constraints
        NSLayoutConstraint.activate([scrollViewContentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
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
        NSLayoutConstraint.activate([cardScrollView.heightAnchor.constraint(equalToConstant: self.view.frame.height * 0.6),
                                     cardScrollView.heightAnchor.constraint(equalTo: cardScrollView.widthAnchor, multiplier: 1.375),
                                     cardScrollView.centerXAnchor.constraint(equalTo: scrollViewContentView.centerXAnchor),
                                     cardScrollView.bottomAnchor.constraint(equalTo: scrollViewContentView.bottomAnchor),
                                     cardScrollView.topAnchor.constraint(equalTo: separatorLine.bottomAnchor)])
    }
    
    @objc private func articlePressed(sender: UIGestureRecognizer) {
        if let card = sender.view as? Card {
            self.navigationController?.pushViewController(ArticleViewController(with: card.article), animated: true)
        }
    }
    
    // MARK: Private variables
    
    private let viewModel: SummaryViewModel
    
    private let topic: Topic
    
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
        label.text = self.topic.title
        
        return label
    }()
    
    private lazy var summaryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.text = self.topic.summary
        
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
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.clipsToBounds = false
        
        return scrollView
    }()
}

extension SummaryViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == cardScrollView {
            let centerX = view.frame.midX
            
            for view in cardScrollView.subviews {
                let frameInMainView = cardScrollView.convert(view.frame, to: self.view)
                var alpha = abs((centerX - frameInMainView.midX) / 100)
                alpha = alpha < 0.1 ? 0 : alpha
                
                view.backgroundColor = UIColor.black.withAlphaComponent(alpha)
            }
        }
    }
}
