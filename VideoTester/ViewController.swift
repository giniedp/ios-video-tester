//
//  ViewController.swift
//  VideoTester
//
//  Created by Heiko on 26.01.22.
//

import UIKit

class ViewController: UIViewController {
    
    var mainWebView : MainWebViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainWebView = MainWebViewController()
        self.addChild(mainWebView!)
        self.view.addSubview(mainWebView!.view)
        mainWebView!.view.frame = self.view.frame
        mainWebView?.didMove(toParent: self)

    }


}

