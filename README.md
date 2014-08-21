BLSNavigationController
=======================

iOS navigation controller with TweetBot 3-like back button for web content and progress bar

![Demo](demo.gif)

BLSNavigation controller handles all the hassle of in-app web browsing for you. It automatically sets the title of the webpage, shows a loading progress bar, and handles backwards navigation. The back button behavior is inspired by Tweetbot 3. The navigation controller's traditional back button is used to navigate backward in the webpage stack, but still maintains traditional swipe-from-edge gesture to get you directly back to the previous view controller if needed.

To Use
========
* Drop BLSNavigationController.m and BLSNavigationController.h into your project. 
* You are assumed to be using iOS 8's WKWebView as your webview. 
* alloc and init your WKWebView and assign it to self.view in -viewDidLoad(). 
* Set your WKWebView's navigationDelegate to your view controller's instance of BLSNavigationController
* That's it. You're done.

Requirements
==============
* iOS 8
* WKWebView as your webView

Pull requests are welcome!
