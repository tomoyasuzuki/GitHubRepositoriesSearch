//
//  DetailViewController.swift
//  GitHubRepositoriesSearch
//
//  Created by 鈴木友也 on 2019/10/20.
//  Copyright © 2019 tomoya.suzuki. All rights reserved.
//

import UIKit
import WebKit

final class DetailViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    
    var urlString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureWebView()
    }
    
    private func configureWebView() {
        guard let urlString = urlString else {
            return
        }
        
        let urlReq = URLRequest(url: URL(string: urlString)!)
        webView.load(urlReq)
    }
}
