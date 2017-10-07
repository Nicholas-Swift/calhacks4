//
//  ArticleViewController.swift
//  calhacks4
//
//  Created by Brian Hans on 10/7/17.
//  Copyright © 2017 Nick Swift. All rights reserved.
//

import Foundation
import UIKit

class ArticleViewController: UIViewController {
    
    // MARK: Lifecycle events
    
    init(with article: Article) {
        self.article = article
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        self.navigationItem.largeTitleDisplayMode = .never
        self.view.backgroundColor = .white
        
        self.view.addSubview(scrollView)
        
        self.scrollView.addSubview(contentStackView)
        
        titleLabel.text = article.title
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        paragraphStyle.paragraphSpacing = 20
        articleLabel.attributedText = NSAttributedString(string: article.text, attributes: [NSAttributedStringKey.paragraphStyle: paragraphStyle])
        imageView.af_setImage(withURL: article.imageURL)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        // Content stack view constraints
        NSLayoutConstraint.activate([contentStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 35),
                                     contentStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
                                     contentStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
                                     contentStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -35),
                                     contentStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
                                     contentStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20)])
        
        NSLayoutConstraint.activate([scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
                                     scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
                                     scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                                     scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)])
        
        // Image view constraints
        NSLayoutConstraint.activate([imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 1.504)])
    }
    

    // MARK: Private variables
    
    private var article: Article
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .clear
        scrollView.contentInsetAdjustmentBehavior = .never
        
        return scrollView
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 2
        
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Font.title
        label.textColor = .black
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var articleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imageView, titleLabel, articleLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 35
        
        return stackView
    }()
}


