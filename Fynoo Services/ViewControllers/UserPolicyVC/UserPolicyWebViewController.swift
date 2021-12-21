//
//  UserPolicyWebViewController.swift
//  Fynoo
//
//  Created by IND-SEN-LP-040 on 18/05/21.
//  Copyright © 2021 neerajTiwari. All rights reserved.
//

import UIKit
import WebKit

class UserPolicyWebViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {

    
    @IBOutlet weak var headerView: NavigationView!
    @IBOutlet weak var headerHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var webView: WKWebView!
    
    
    override func viewDidLoad() {
        ModalController.watermark(self.view)
        super.viewDidLoad()
        webView.navigationDelegate = self
        self.webView.uiDelegate = self
        ModalClass.startLoading(self.view
        )
        self.setupUI()
    }

    func setupUI(){
        self.headerView.menuBtn.isHidden = true
        self.headerView.titleHeader.text = "User Policy".localized;
        self.headerView.viewControl = self
        self.headerHeightConstant.constant = CGFloat(HeaderHeightSingleton.shared.headerHeight)
        let url = Constant.BASE_URL+Constant.privacy_url
        debugPrint(url)
        webView.load(URLRequest(url: URL(string: "\(url)")!))
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {

           ModalClass.stopLoading()
       }
    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        
        if navigationAction.targetFrame == nil {
            
            webView.load(navigationAction.request)
            
        }
        
        return nil
        
    }
}
