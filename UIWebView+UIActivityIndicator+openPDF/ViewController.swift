//
//  ViewController.swift
//  UIWebView+UIActivityIndicator+openPDF
//
//  Created by Rodion on 11/06/2019.
//  Copyright © 2019 Rodion. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var goBackItem: UIBarButtonItem!
    @IBOutlet weak var goForwardItem: UIBarButtonItem!
    @IBOutlet weak var activityIndikator: UIActivityIndicatorView!
    
    let application = UIApplication.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.delegate = self
        webView.scalesPageToFit = true  // корректно отображает на view
        
        //MARK:- Download PDF
        
//    if let myURLPdf = Bundle.main.url(forResource: "vc", withExtension: "pdf") {
//
//    let request = URLRequest(url: myURLPdf)
//
//    webView.loadRequest(request)
//
//    }
        
        
//MARK:- Download URL
        
            if let myURL = URL(string: "https://www.google.ru") {

            let request = URLRequest(url: myURL)

            print(myURL.port, myURL.user, myURL.scheme)

            webView.loadRequest(request)

        }
        
    }

    
    //MARK:- Method ActivityIndicator
    func isWorkIndicator (isAnimated: Bool, indicator: UIActivityIndicatorView) {
        
        application.isNetworkActivityIndicatorVisible = isAnimated
        if isAnimated {
            activityIndikator.startAnimating()
            activityIndikator.isHidden = false
        } else {
            activityIndikator.stopAnimating()
            activityIndikator.isHidden = true
        }
        
    }
    
    
    //MARK:- UIWebViewDelegate
    func webViewDidStartLoad(_ webView: UIWebView) {
        
//        application.isNetworkActivityIndicatorVisible = true  // индикатор загрузки вверху экрана
  
        isWorkIndicator(isAnimated: true, indicator: activityIndikator)
        self.goBackItem.isEnabled = false
        self.goForwardItem.isEnabled = false
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
 //       application.isNetworkActivityIndicatorVisible = false  // индикатор загрузки вверху экрана
   
         isWorkIndicator(isAnimated: false, indicator: activityIndikator)
        if webView.canGoBack {
            self.goBackItem.isEnabled = true
        } else if webView.canGoForward {
                self.goForwardItem.isEnabled = true
            }
        
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
        
        print("shouldStartLoadWith = ", request)
        return true
    }
    }
    
    
    
    //MARK:- Action
    @IBAction func goBackAction(_ sender: Any) {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    @IBAction func goForwardAction(_ sender: Any) {
        if webView.canGoForward {
            webView.goForward()
        }
    }
    
    @IBAction func refreshAction(_ sender: Any) {
        webView.reload()
    }
    
    
}

