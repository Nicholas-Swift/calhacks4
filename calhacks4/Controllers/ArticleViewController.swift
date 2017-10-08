//
//  ArticleViewController.swift
//  calhacks4
//
//  Created by Brian Hans on 10/7/17.
//  Copyright © 2017 Nick Swift. All rights reserved.
//

import Foundation
import UIKit
import SafariServices

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
        paragraphStyle.paragraphSpacing = 5
        articleLabel.attributedText = NSAttributedString(string: article.text, attributes: [NSAttributedStringKey.paragraphStyle: paragraphStyle])
        
        setupConstraints()
        
        if let imageUrl = article.imageURL {
            imageView.af_setImage(withURL: imageUrl)
        } else {
            imageView.removeFromSuperview()
        }
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
        NSLayoutConstraint.activate([imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 1.504),
                                     imageView.widthAnchor.constraint(equalTo: contentStackView.widthAnchor)])
    }
    
    @objc func sourceButtonPressed(sender: UIGestureRecognizer) {
        if let sourceView = sender.view as? SourceView {
            if let url = sourceView.url {
                let safariVC = SFSafariViewController(url: url)
                safariVC.preferredControlTintColor = .black
                self.present(safariVC, animated: true, completion: nil)
            }
        }
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
        label.text = self.article.title
        
        return label
    }()
    
    private lazy var articleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.text = self.article.text
        
        return label
    }()
    
    private lazy var contentStackView: UIStackView = {
        let tagScrollView = UIScrollView()
        tagScrollView.showsHorizontalScrollIndicator = false

        if self.tagsStackView.arrangedSubviews.count > 1 {
            tagsStackView.translatesAutoresizingMaskIntoConstraints = false
            
            tagScrollView.addSubview(self.tagsStackView)
        }
        
        let sourcesScrollView = UIScrollView()
        sourcesScrollView.showsHorizontalScrollIndicator = false
        
        if self.sourcesStackView.arrangedSubviews.count > 1 {
            sourcesStackView.translatesAutoresizingMaskIntoConstraints = false
            
            sourcesScrollView.addSubview(self.sourcesStackView)
        }
        
        let stackView = UIStackView(arrangedSubviews: [imageView, titleLabel, articleLabel, sourcesScrollView, tagScrollView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 35
        
        if self.sourcesStackView.arrangedSubviews.count > 1 {
            NSLayoutConstraint.activate([sourcesStackView.topAnchor.constraint(equalTo: sourcesScrollView.topAnchor),
                                         sourcesStackView.leadingAnchor.constraint(equalTo: sourcesScrollView.leadingAnchor),
                                         sourcesStackView.trailingAnchor.constraint(equalTo: sourcesScrollView.trailingAnchor),
                                         sourcesStackView.bottomAnchor.constraint(equalTo: sourcesScrollView.bottomAnchor)])
            
            NSLayoutConstraint.activate([sourcesScrollView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
                                         sourcesScrollView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
                                         sourcesScrollView.heightAnchor.constraint(equalTo: sourcesStackView.heightAnchor)])
        }
        
        if tagsStackView.arrangedSubviews.count > 1 {
            NSLayoutConstraint.activate([tagsStackView.topAnchor.constraint(equalTo: tagScrollView.topAnchor),
                                         tagsStackView.leadingAnchor.constraint(equalTo: tagScrollView.leadingAnchor),
                                         tagsStackView.trailingAnchor.constraint(equalTo: tagScrollView.trailingAnchor),
                                         tagsStackView.bottomAnchor.constraint(equalTo: tagScrollView.bottomAnchor)])
            
            NSLayoutConstraint.activate([tagScrollView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
                                         tagScrollView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
                                         tagScrollView.heightAnchor.constraint(equalTo: tagsStackView.heightAnchor)])
        }
        
        return stackView
    }()
    
    private lazy var sourcesStackView: UIStackView = {
        var sourceViews: [UIView] = [SourceView(title: "Sources:", url: nil, isTitle: true)]
        for (index, ref) in self.article.refs.enumerated() {
            let sourceView: SourceView = SourceView(title: "\(index + 1)", url: ref, isTitle: false)
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(sourceButtonPressed(sender:)))
            sourceView.addGestureRecognizer(tapGesture)
            sourceViews.append(sourceView)
        }
        
        let stackView = UIStackView(arrangedSubviews: sourceViews)
        stackView.axis = .horizontal
        stackView.spacing = 5
        
        return stackView
    }()
    
    private lazy var tagsStackView: UIStackView = {
        var tagViews: [UIView] = [SourceView(title: "Tags:", url: nil, isTitle: true)]
        for tag in self.article.tags {
            let sourceView: SourceView = SourceView(title: tag, url: nil, isTitle: false)
            tagViews.append(sourceView)
        }
        
        let stackView = UIStackView(arrangedSubviews: tagViews)
        stackView.axis = .horizontal
        stackView.spacing = 5
        
        return stackView
    }()
}


