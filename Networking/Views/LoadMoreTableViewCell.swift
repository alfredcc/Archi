//
//  LoadMoreTableViewCell.swift
//  Networking
//
//  Created by race on 9/8/16.
//  Copyright © 2016 race. All rights reserved.
//

import UIKit

final class LoadMoreTableViewCell: UITableViewCell {
    
    @IBOutlet weak var loadingActivityIndicator: UIActivityIndicatorView!
    
    var isLoading: Bool = false {
        didSet {
            if isLoading {
                loadingActivityIndicator.startAnimating()
                noMoreResultsLabel.hidden = true
            } else {
                loadingActivityIndicator.stopAnimating()
                noMoreResultsLabel.hidden = false
            }
        }
    }
    
    
    @IBOutlet weak var noMoreResultsLabel: UILabel! {
        didSet {
            noMoreResultsLabel.font = UIFont.systemFontOfSize(14)
            noMoreResultsLabel.text = NSLocalizedString("No more results.", comment: "")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        separatorInset = UIEdgeInsets(top: 0, left: UIScreen.mainScreen().bounds.width, bottom: 0, right: 0)
        noMoreResultsLabel.hidden = true
    }
    
    
}
