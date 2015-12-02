//
//  WebViewController.swift
//  Example
//
//  Created by Thomas Carey on 12/1/15.
//  Copyright © 2015 BLS Software. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
  
  override func loadView() {
    let webView = WKWebView()

    let blsNavigationController = navigationController as! BLSNavigationController
    blsNavigationController.webView = webView

    view = webView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    (view as! WKWebView).loadRequest(NSURLRequest(URL: NSURL(string: "http://www.duckduckgo.com")!))
  }
}