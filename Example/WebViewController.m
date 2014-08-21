//
//  ViewController.m
//  Example
//
//  Created by Thomas Carey on 8/20/14.
//  Copyright (c) 2014 BLS Software. All rights reserved.
//

#import "WebViewController.h"
#import <WebKit/WebKit.h>
#import "BLSNavigationController.h"

@interface WebViewController ()

@property (strong, nonatomic) WKWebView *webView;

@end

@implementation WebViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    self.webView.navigationDelegate = (BLSNavigationController *)self.navigationController;
    self.view = self.webView;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.duckduckgo.com"]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
