//
//  ViewController.swift
//  calhacks4
//
//  Created by Nick Swift on 10/6/17.
//  Copyright © 2017 Nick Swift. All rights reserved.
//

import Foundation
import UIKit

class FeedViewController: UIViewController {
    
    let viewModel = FeedViewModel()
    var animatedIndexPaths: Set<IndexPath> = Set<IndexPath>()
    
    // MARK: Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        viewModel.fetchArticles { [weak self] _ in
            self?.tableView.reloadData()
            self?.animatedIndexPaths = Set<IndexPath>()
        }
    }
    
    // MARK: Custom methods
    
    func setupViews() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationItem.title = "Newstral"
        
        self.view.addSubview(tableView)
        tableView.register(cellClass: FeedTableViewCell.self)
        
        NSLayoutConstraint.activate([tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
                                     tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
                                     tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                                     tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)])
    }
    
    // MARK: Private variables
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.tintColor = .clear
        
        return tableView
    }()
}

// MARK: Table View Data Source and Delegate

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sectionCount
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FeedTableViewCell = tableView.dequeueCell(for: indexPath)
        cell.setup(with: viewModel.item(for: indexPath))
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.navigationController?.pushViewController(ArticleViewController(with: viewModel.item(for: indexPath)), animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard cell.frame.minY - tableView.contentOffset.y < self.view.frame.height, !animatedIndexPaths.contains(indexPath) else { return }
        animatedIndexPaths.insert(indexPath)
        
        let originY = cell.frame.origin.y
        cell.frame.origin.y = originY + (self.view.frame.height / 2)
        
        UIView.beginAnimations("in", context: nil)
        UIView.setAnimationDuration(0.8)
        cell.layer.transform = CATransform3DIdentity
        cell.frame.origin.y = originY
        UIView.commitAnimations()
        
        
    }
}
