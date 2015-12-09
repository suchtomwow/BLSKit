//
//  BLSNavigationController.swift
//  BLSNavigationController
//
//  Created by Thomas Carey on 12/1/15.
//  Copyright © 2015 BLS. All rights reserved.
//

import WebKit

class BLSNavigationController: UINavigationController, UINavigationBarDelegate {
  
  let progressView = UIProgressView(progressViewStyle: .Bar)
  
  var webView: WKWebView? {
    didSet {
      if let _ = webView {
        webView?.addObserver(self, forKeyPath: "estimatedProgress", options: .New, context: nil)
        webView?.addObserver(self, forKeyPath: "title", options: .New, context: nil)
      }
    }
    willSet {
      if newValue == nil {
        webView?.removeObserver(self, forKeyPath: "estimatedProgress")
        webView?.removeObserver(self, forKeyPath: "title")
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureView()
    configureConstraints()
  }
  
  private func configureView() {
    progressView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(progressView)
  }
  
  private func configureConstraints() {
    NSLayoutConstraint(item: progressView, attribute: .Bottom, relatedBy: .Equal, toItem: navigationBar, attribute: .Bottom, multiplier: 1.0, constant: -0.5).active = true
    NSLayoutConstraint(item: progressView, attribute: .Leading, relatedBy: .Equal, toItem: navigationBar, attribute: .Leading, multiplier: 1.0, constant: 0.0).active = true
    NSLayoutConstraint(item: progressView, attribute: .Trailing, relatedBy: .Equal, toItem: navigationBar, attribute: .Trailing, multiplier: 1.0, constant: 0.0).active = true
  }
  
  func navigationBar(navigationBar: UINavigationBar, shouldPopItem item: UINavigationItem) -> Bool {
    // See http://stackoverflow.com/questions/6413595/uinavigationcontroller-and-uinavigationbardelegate-shouldpopitem-with-monotouc/7453933#7453933
    // for future reference in getting this to work  
    
    if let webView = topViewController?.view as? WKWebView {
      if webView.canGoBack {
        webView.goBack()
        return false
      } else {
        self.webView = nil
        popViewControllerAnimated(true)
      }
    } else {
      webView = nil
      popViewControllerAnimated(true)
    }
    
    return true
  }
  
  private func updateProgress(progress: Float) {
    if progress == 1.0 {
      finishNavigation()
    } else {
      progressView.setProgress(progress, animated: true)
    }
  }
  
  private func finishNavigation() {
    UIView.animateWithDuration(0.33, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: [], animations: { () -> Void in
      self.progressView.setProgress(1.0, animated: true)
      self.progressView.alpha = 0.0
      }, completion: { finished in
        self.progressView.setProgress(0.0, animated: false)
        self.progressView.alpha = 1.0
    })
  }
  
  override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
    if keyPath == "estimatedProgress" {
      if let webView = webView {
        updateProgress(Float(webView.estimatedProgress))
      }
    } else if keyPath == "title" {
      let newTitle = change?["new"] as? String
      topViewController?.title = newTitle
    }
  }
}
