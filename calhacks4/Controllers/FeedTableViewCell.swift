//
//  FeedTableViewCell.swift
//  calhacks4
//
//  Created by Brian Hans on 10/7/17.
//  Copyright © 2017 Nick Swift. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage

class FeedTableViewCell: UITableViewCell {
    
    
    //MARK: Lifecycle events
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupInitialViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        photoImageView.af_cancelImageRequest()
        photoImageView.image = nil
        titleLabel.text = nil
        subtitleLabel.text = nil
    }
    
    // MARK: Public functions
    
    func setup(with article: Article) {
        photoImageView.af_setImage(withURL: article.imageURL)
        titleLabel.text = article.title
        subtitleLabel.text = article.description
    }
    
    
    // MARK: Private functions
    
    private func setupInitialViews() {
        self.addSubview(contentStackView)
        self.addSubview(separatorLine)
        photoImageViewContainer.addSubview(photoImageView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        // Stack view constraints
        NSLayoutConstraint.activate([contentStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: spacing * 2),
                                     contentStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: spacing),
                                     contentStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -spacing),
                                     contentStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -spacing * 2)])
        
        // Photo image view container constraints
        NSLayoutConstraint.activate([photoImageViewContainer.widthAnchor.constraint(equalTo: self.photoImageViewContainer.heightAnchor, multiplier: 2.64),
                                     photoImageView.leadingAnchor.constraint(equalTo: self.photoImageViewContainer.leadingAnchor),
                                     photoImageView.trailingAnchor.constraint(equalTo: self.photoImageViewContainer.trailingAnchor),
                                     photoImageView.topAnchor.constraint(equalTo: self.photoImageViewContainer.topAnchor)])
        
        
        // Width constraints
        NSLayoutConstraint.activate([photoImageView.widthAnchor.constraint(equalTo: contentStackView.widthAnchor),
                                     titleLabel.widthAnchor.constraint(equalTo: contentStackView.widthAnchor),
                                     subtitleLabel.widthAnchor.constraint(equalTo: contentStackView.widthAnchor)])

        // Separator line constraints
        NSLayoutConstraint.activate([separatorLine.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                                     separatorLine.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                                     separatorLine.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                                     separatorLine.heightAnchor.constraint(equalToConstant: 0.5)])
    }
    
    
    // MARK: Private variables
    
    private var spacing: CGFloat = 15
    
    private lazy var photoImageViewContainer: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 2
        
        return view
    }()
    
    private lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Font.title
        label.textColor = .black
        label.numberOfLines = 3
        
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = Font.subtitle
        label.textColor = .gray
        label.numberOfLines = 4
        
        return label
    }()
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [photoImageViewContainer, titleLabel, subtitleLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = spacing
        stackView.axis = .vertical
        stackView.alignment = .center
        
        return stackView
    }()
    
    private lazy var separatorLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.gray.withAlphaComponent(0.35)
        
        return view
    }()
}
