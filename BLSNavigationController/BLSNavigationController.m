//
//  BLSNavigationControllerViewController.m
//  Airpin
//
//  Created by Thomas Carey on 8/2/14.
//  Copyright (c) 2014 Thomas Carey. All rights reserved.
//

#import "BLSNavigationController.h"

@interface BLSNavigationController ()

@property (weak, nonatomic) UIViewController *viewController;
@property (strong, nonatomic) UIProgressView *progressView;

@end

@implementation BLSNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
    UIProgressView *progress = self.progressView;
    [self.view addSubview:self.progressView];
    UINavigationBar *navBar = self.navigationBar;
    
    NSLayoutConstraint *constraint;
    
    constraint = [NSLayoutConstraint constraintWithItem:progress
                                              attribute:NSLayoutAttributeBottom
                                              relatedBy:NSLayoutRelationEqual
                                                 toItem:navBar
                                              attribute:NSLayoutAttributeBottom
                                             multiplier:1
                                               constant:-0.5];
    [self.view addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:progress
                                              attribute:NSLayoutAttributeLeft
                                              relatedBy:NSLayoutRelationEqual
                                                 toItem:navBar
                                              attribute:NSLayoutAttributeLeft
                                             multiplier:1
                                               constant:0];
    [self.view addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:progress
                                              attribute:NSLayoutAttributeRight
                                              relatedBy:NSLayoutRelationEqual
                                                 toItem:navBar
                                              attribute:NSLayoutAttributeRight
                                             multiplier:1
                                               constant:0];
    [self.view addConstraint:constraint];
    
    self.progressView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.progressView setProgress:0.0 animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIViewController *)viewController
{
    if (!_viewController) {
        _viewController = self.topViewController;
        while ([_viewController class] == [BLSNavigationController class]) {
            _viewController = ((BLSNavigationController *)_viewController).topViewController;
        }
    }
    
    return _viewController;
}

- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item
{
    // See http://stackoverflow.com/questions/6413595/uinavigationcontroller-and-uinavigationbardelegate-shouldpopitem-with-monotouc/7453933#7453933
    // for future reference in getting this to work
    
    if ([self.viewController.view respondsToSelector:@selector(canGoBack)] &&
        [self.viewController.view respondsToSelector:@selector(goBack)]) {
        WKWebView *webView = (WKWebView *)self.viewController.view;
        if ([webView canGoBack]) {
            [webView goBack];
            return NO;
        } else {
            [self popViewControllerAnimated:YES];
        }
    } else {
        [self popViewControllerAnimated:YES];
    }
    
    return YES;
}

- (void)updateWithProgress:(float)progress title:(NSString *)title
{
    if (progress == 1.0) {
        [self finishNavigation];
    } else {
        [self updateProgress:progress];
    }
    
    if (title.length) {
        self.viewController.title = title;
    }
}

- (void)updateProgress:(float)progress
{
    if (progress > self.progressView.progress) {
        [self.progressView setProgress:progress animated:YES];
    }
}

- (void)finishNavigation
{
    [UIView animateWithDuration:0.33
                          delay:0
         usingSpringWithDamping:1.0
          initialSpringVelocity:1.0
                        options:0
                     animations:^{
                         [self.progressView setProgress:1.0 animated:YES];
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.66
                                               delay:0
                              usingSpringWithDamping:1.0
                               initialSpringVelocity:1.0
                                             options:0
                                          animations:^{
                                              self.progressView.alpha = 0.0;
                                          }
                                          completion:^(BOOL finished) {
                                              [self.progressView setProgress:0.0 animated:NO];
                                              self.progressView.alpha = 1.0;
                                          }];
    }];
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    [self updateWithProgress:webView.estimatedProgress title:webView.URL.absoluteString];
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
    [self updateWithProgress:webView.estimatedProgress title:webView.title];
}

- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation
{
    [self updateWithProgress:webView.estimatedProgress title:webView.title];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    [self updateWithProgress:webView.estimatedProgress title:webView.title];
}

@end
