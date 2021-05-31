//
//  DashboardViewController.swift
//  WebViewBasedApp
//
//  Created by Bhargav Kaneriya on 31/05/21.
//

import UIKit
import WebKit

class DashboardViewController: UIViewController {

    @IBOutlet weak var webDisplayView: UIView!
    
    var mWebKitView: WKWebView!
    var staticPageLink = "https://www.hackingwithswift.com"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setUpUI()
    }
    
    func setUpUI() {
        mWebKitView = WKWebView(frame: webDisplayView.bounds)
        mWebKitView.navigationDelegate = self
        webDisplayView.addSubview(mWebKitView)
        
        self.setupWebView()
        DispatchQueue.main.asyncAfter(deadline: .now()+1.0) {
            let url = URL(string: self.staticPageLink)!
            self.mWebKitView.load(URLRequest(url: url))
            self.mWebKitView.allowsBackForwardNavigationGestures = true
        }
    }
    
    func setupWebView() {
        let webConfig = WKWebViewConfiguration()
        self.mWebKitView = WKWebView(frame: self.webDisplayView.bounds, configuration: webConfig)
        self.mWebKitView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        /*
        mWebKitView.scrollView.layer.masksToBounds = false
        mWebKitView.scrollView.clipsToBounds = false
        mWebKitView.scrollView.contentInset = .zero
        mWebKitView.scrollView.isScrollEnabled = true
        mWebKitView.scrollView.bounces = false
        mWebKitView.scrollView.bouncesZoom = false
         */
        
        mWebKitView.isOpaque = false
        mWebKitView.scrollView.delegate = self
//        mWebKitView.scrollView.showsHorizontalScrollIndicator = false
//        mWebKitView.scrollView.showsVerticalScrollIndicator = false

        
        self.webDisplayView.clipsToBounds = true
        self.webDisplayView.addSubview(self.mWebKitView)
    }
}

// MARK:- WKNavigationDelegate -
extension DashboardViewController : WKNavigationDelegate , UIScrollViewDelegate {
    
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
          scrollView.pinchGestureRecognizer?.isEnabled = true
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        print(scale)
    }
    
    private func webView(webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: NSError) {
        print(error.localizedDescription)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Strat to load")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("finish to load")
    }
}
