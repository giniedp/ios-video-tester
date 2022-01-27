//
//  ViewController.swift
//  Bayer04
//
//  Created by Heiko on 09.09.20.
//  Copyright © 2020 Bayer 04 Leverkusen Fussball GmbH. All rights reserved.
//

import UIKit
import WebKit
import NotificationCenter
import SafariServices
import QuickLook
import PassKit
import CoreLocation

class MainWebViewController: BayerWebViewController {
    
    override func loadView() {
        setupWebView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.becomeFirstResponder()
         loadURL(url: URL(string: "https://ginie.eu/video-test.html")!)
        // let path = Bundle.main.path(forResource: "video-test.html", ofType: nil)
        // if path != nil {
        //     loadURL(url: URL(fileURLWithPath: path!))
        // }
    }
        
    override func clearMemory(){
        super.clearMemory()
        NotificationCenter.default.removeObserver(self)
    }
    
    override func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        print("start loading \(String(describing: navigationAction.request.url)), targetFrame \(String(describing: navigationAction.targetFrame))")
        decisionHandler(.allow)
    }
}

