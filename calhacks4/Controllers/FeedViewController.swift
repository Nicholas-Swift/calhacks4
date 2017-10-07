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
    
    // MARK: Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        viewModel.fetchArticles { [weak self] _ in
            self?.tableView.reloadData()
        }
    }
    
    // MARK: Custom methods
    
    func setupViews() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationItem.title = "Newstral"
        
        self.view.addSubview(tableView)
        tableView.frame = self.view.frame
        tableView.register(cellClass: FeedTableViewCell.self)
    }
    
    // MARK: Private variables
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        
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
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.navigationController?.pushViewController(ArticleViewController(with: viewModel.item(for: indexPath)), animated: true)
    }
}
