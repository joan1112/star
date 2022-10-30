//
//  JWBaseWebKitViewController.swift
//  CoinBull
//
//  Created by WuQiaoqiao on 2020/5/22.
//  Copyright © 2020 Joe. All rights reserved.
//

import UIKit
import WebKit

class JWBaseWebKitViewController: JWBaseViewController {
    
    var urlString : String = ""
    @IBOutlet weak var webkitView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        let request = URLRequest(url: URL(string: urlString)!)
        
        webkitView.load(request)
        
    }
}
