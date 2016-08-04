//
//  VacationViewController.swift
//  WorldTrotter
//
//  Created by Sam Lee on 8/2/16.
//  Copyright © 2016 Sam Lee. All rights reserved.
//

import UIKit
import WebKit

class VacationViewController: UIViewController {
    var webView: WKWebView!
    
    override func loadView() {
        webView = WKWebView()
        let url = NSURL(string:"https://www.bignerdranch.com")
        let req = NSURLRequest(URL: url!)
        webView.loadRequest(req)
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("VacationView did load")
    }
    
}