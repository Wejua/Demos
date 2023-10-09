//
//  YYRankingViewController.swift
//  YYVideo
//
//  Created by zhouweijie on 2019/10/10.
//  Copyright © 2019 com.yiyuan. All rights reserved.
//

import UIKit
import WebKit
import MBProgressHUD

class YYWKWebViewController: YYBaseViewController {
    //MARK: - lazy properties
    private(set) var webView: WKWebView!
    
    //MARK: - life functions
    init(webViewConfiguration: WKWebViewConfiguration?, url: URL, title: String?) {
        self.webViewConfiguration = webViewConfiguration
        self.url = url
        super.init(nibName: nil, bundle: nil)
        let configuration = self.webViewConfiguration ?? WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.navigationDelegate = self
        webView.uiDelegate = self
        self.webView = webView
        configuration.userContentController.add(self, name: "goBack")
        webView.configuration.userContentController.add(self, name: "share")
        webView.configuration.userContentController.add(self, name: "getToken")
        webView.configuration.userContentController.add(self, name: "hideBar")
        webView.configuration.userContentController.add(self, name: "afterSalesClick")
        webView.configuration.userContentController.add(self, name: "goForget")
        webView.configuration.userContentController.add(self, name: "chargeBackClick")
        if title != nil {
            self.titleBar.setTitle(title: title!)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if shouldHideTitleBar {
            titleBar.setHidden(isHidden: true, animate: false)
        }
    }
    
    //MARK: - public functions
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            webView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            webView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
        ])
        
        progresHUD = ProgressHUD.showInView(view)
        webView.load(URLRequest(url: url))
    }
    
    //MARK: - other properties
    private(set) var webViewConfiguration: WKWebViewConfiguration?
    
    private(set) var url: URL
    
    private(set) var progresHUD: MBProgressHUD?
    
    var shouldHideTitleBar: Bool = false
    
}

extension YYWKWebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        progresHUD?.hide(animated: true)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {

        guard let url = navigationAction.request.url?.absoluteString else {return}
        if (url.contains("weixin://wap/pay") || url.contains("alipay://alipayclient")) {
            UIApplication.shared.open(navigationAction.request.url!, options: [:], completionHandler: nil)
            decisionHandler(WKNavigationActionPolicy.cancel)
            return
        }
        decisionHandler(WKNavigationActionPolicy.allow)
    }
}

extension YYWKWebViewController: WKUIDelegate, WKScriptMessageHandler {
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "goForget" {
            let vc = YYCheckPhoneVC()
            vc.type = "payPW"
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if message.name == "goBack" {
            self.tabBarController?.tabBar.isHidden = false
            if webView.canGoBack == true {
                webView.goBack()
            } else {
                self.navigationController?.popViewController(animated: true)
            }
        }
        if message.name == "hideBar"{
            let body = message.body as? String
            if body == "0"{
                self.tabBarController?.tabBar.isHidden = false
            }else{
                self.tabBarController?.tabBar.isHidden = true
                self.view.frame = CGRect(x: 0, y: 0, width: YYScreenW, height: YYScreenH + 50)
            }
        }
        if message.name == "getToken"{
         self.tabBarController?.tabBar.isHidden = true
            
           let body = message.body as? String

            if getCookie() == ""{
                webView.evaluateJavaScript("javascript:getToken('\("")')", completionHandler: nil)
                if body == "2"{
                    goToBaseLoginVC()
                }
            }
            else{
                webView.evaluateJavaScript("javascript:getToken('\(getCookie())')", completionHandler: nil)
            }

        }
        if message.name == "afterSalesClick" {
            let vc = YYAfterSaleViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
        if message.name == "chargeBackClick" {
            let vc = YYChargeBackLIstViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

