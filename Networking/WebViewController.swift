//
//  WebViewController.swift
//  Networking
//
//  Created by race on 9/8/16.
//  Copyright © 2016 race. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    var urlString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewFrame = view.bounds
        let webView = WKWebView.init(frame: viewFrame)
        webView.allowsLinkPreview = true
        guard let
            urlString = urlString,
            url = NSURL(string: urlString) else { return }
        
        let request = NSURLRequest(URL: url)
        webView.loadRequest(request)
        view.addSubview(webView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
