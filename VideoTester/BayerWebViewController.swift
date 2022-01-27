//
//  BayerWebViewController.swift
//  Bayer04
//
//  Created by Heiko on 26.01.21.
//  Copyright © 2021 Bayer 04 Leverkusen Fussball GmbH. All rights reserved.
//

import Foundation
import UIKit
import WebKit


class BayerWebViewController: UIViewController, WKNavigationDelegate, WKUIDelegate
{
    var webView: WKWebView!
    var url: URL!
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        get{
            return UIDevice.current.userInterfaceIdiom == .phone ? .portrait : .all
        }
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
      return .lightContent
    }

    
    override func loadView(){
        setupWebView()
    }

    static var userAgentStatic : String?
    static func userAgentName()->String{
        if let userAgent = userAgentStatic {
            return userAgent
        }
        let infoDict = Bundle.main.infoDictionary!;
        let version = (infoDict["CFBundleShortVersionString"] as! String)
        let build = (infoDict["CFBundleVersion"] as! String)
        let stageIndex = "d"
        userAgentStatic = "werkself/\(stageIndex)\(version)/\(build)"
        return userAgentStatic!
    }
    
    static func globalWebViewConfig()->WKWebViewConfiguration{
        let config = WKWebViewConfiguration()
        config.applicationNameForUserAgent = userAgentName()
        return config
    }
    
    func clearMemory(){
        clearWebView()
    }
    
    func setupWebView(){
        print("setupWebView()")
        let config = BayerWebViewController.globalWebViewConfig()
        config.userContentController = setupContentController()
        config.allowsInlineMediaPlayback = true
        webView = WKWebView(frame: .zero, configuration: config)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        view = UIView.init()
        view.backgroundColor = .red
        webView.backgroundColor = view.backgroundColor
//        webView.scrollView.backgroundColor = view.backgroundColor
        view.addSubview(webView)
        
    }
    
    func setupContentController()->WKUserContentController{
        let contentController = WKUserContentController()
        //add our custom functions that are called from web-app
//        contentController.add(self, name: B04WebBridgeMethod.request.rawValue)
//        contentController.add(self, name: B04WebBridgeMethod.response.rawValue)
        return contentController
    }

    
    func clearWebView(){
        if webView != nil {
//            webView.configuration.userContentController.removeScriptMessageHandler(forName: B04WebBridgeMethod.request.rawValue)
//            webView.configuration.userContentController.removeScriptMessageHandler(forName: B04WebBridgeMethod.response.rawValue)
            webView.uiDelegate = nil
            webView.navigationDelegate = nil
            webView.stopLoading()
            webView.removeFromSuperview()
            webView = nil
        }
    }
    func loadURL(url : URL){
        self.url = url
        loadUrlIntoWebView()
    }
    
    func loadUrlIntoWebView(){
        let myRequest = URLRequest(url: url)
        print("request \(myRequest)")
        webView.load(myRequest)
    }

        
    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        if challenge.protectionSpace.host == self.url?.host {
            //print("webView: providing credentials...")
//            let credential = (UIApplication.shared.delegate as! AppDelegate).credentials()
//            if credential != nil {
//                completionHandler(.useCredential, credential!)
//                return
//            }
        }
        completionHandler(.performDefaultHandling, nil)
    }
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        print("start loading \(String(describing: navigationAction.request.url)), targetFrame \(String(describing: navigationAction.targetFrame))")
        decisionHandler(.allow)
    }
    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let fullscreen = CGRect.init(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        webView.frame = fullscreen
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("webView didFail \(error)")
    }
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("webView didFailProvisionalNavigation \(error)");
    }
    
}
