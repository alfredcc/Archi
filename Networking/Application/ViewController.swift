//
//  ViewController.swift
//  Networking
//
//  Created by race on 9/8/16.
//  Copyright © 2016 race. All rights reserved.
//

import UIKit

private let _perPage: Int = 8
private let _estimatedRowHeight: CGFloat = 120
private let _reusableRepoCellIdentifier: String = "repoCell"
private let _reusableLoadMoreCellIdentifier: String = "loadMoreTableViewCell"
private let _loadMoreTableViewCell: String = "LoadMoreTableViewCell"


enum FatchModel: Int {
    case Update
    case LoadMore
}

private enum Section: Int {
    case DataSource
    case LoadMore
}

class ViewController: UIViewController {
    
    var dataSource: Repos?
    private var _isFetching:Bool = false
    private var _canLoadMore:Bool = true
    private var _currentPage:Int = 0
    
    @IBOutlet weak var repoTableView: UITableView!

    // MARK: - Life cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        repoTableView.estimatedRowHeight = _estimatedRowHeight
        repoTableView.rowHeight = UITableViewAutomaticDimension
        repoTableView.registerNib(UINib(nibName: _loadMoreTableViewCell, bundle: nil), forCellReuseIdentifier: _reusableLoadMoreCellIdentifier)
        _fetchRepos()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Private methods
    
    private func _fetchRepos(model: FatchModel = .Update) {
        guard _isFetching == false && _canLoadMore else {
            return
        }
        _isFetching = true
        
        APIClient.events(_perPage, page: _currentPage + 1) { [weak self](result) in
            guard let strongSelf = self else {
                return
            }
            strongSelf._isFetching = false
            switch result {
            case let .Success(value):
                
                strongSelf._canLoadMore = value.content.count != 0
                if model == .Update {
                    strongSelf._currentPage = 1
                    strongSelf.dataSource = value
                } else {
                    strongSelf._currentPage = strongSelf._currentPage + 1
                    strongSelf.dataSource?.content.appendContentsOf(value.content)
                }
                self?.repoTableView.reloadData()
            case let .Failure(status, description):
                print("status: \(status); description: \(description)")
            }
        }
    }
    
    private func _showWebView(indexPath: NSIndexPath) {
        
        let viewController = WebViewController()
        viewController.urlString = dataSource?.content[indexPath.row].url
        navigationController?.pushViewController(viewController, animated: true)
    }
}


// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == Section.DataSource.rawValue {
            return dataSource?.content.count ?? 0
        }
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        guard let section = Section(rawValue: indexPath.section) else {
            return UITableViewCell()
        }
        switch section {
        case .DataSource:
            let cell = tableView.dequeueReusableCellWithIdentifier(_reusableRepoCellIdentifier, forIndexPath: indexPath) as! RepoTableViewCell
            cell.repo = dataSource?.content[indexPath.row]
            return cell
        case .LoadMore:
            return tableView.dequeueReusableCellWithIdentifier(_reusableLoadMoreCellIdentifier, forIndexPath: indexPath)
        }
    }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        guard let section = Section(rawValue: indexPath.section) else { return }
        switch section {
        case .DataSource:
            break
        case .LoadMore:
            guard let cell = cell as? LoadMoreTableViewCell else {
                break
            }
            cell.isLoading = true
            self._fetchRepos(.LoadMore)
            
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        _showWebView(indexPath)
    }
}
