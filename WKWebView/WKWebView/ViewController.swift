//
//  ViewController.swift
//  WKWebView
//
//  Created by Darya on 26.12.23.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {

    let webView = WKWebView()
    let toolBar = UIToolbar()
    let backButton  =  UIBarButtonItem(systemItem: .rewind)
    let forwardButton = UIBarButtonItem(systemItem: .fastForward)
    let refreshButton = UIBarButtonItem(systemItem: .refresh)
    var searchBar  = UISearchBar()
    let space = UIBarButtonItem(systemItem: .flexibleSpace)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        view.addSubview(toolBar)
        view.addSubview(searchBar)
       
        webView.translatesAutoresizingMaskIntoConstraints = false
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        toolBar.items = [backButton,forwardButton,space,refreshButton]
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            toolBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            toolBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            toolBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            toolBar.topAnchor.constraint(equalTo: webView.bottomAnchor),
            
            searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)

        ])
        
        homePage()
        backButton.action = #selector(backButtonAction)
        forwardButton.action = #selector(forwardAction)
        refreshButton.action = #selector(refreshAction)
        
        webView.navigationDelegate = self
    }

    func homePage() {
        guard let url = URL(string: "https://www.google.com") else {return}
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
    }
    
    @objc func backButtonAction() {
        guard webView.canGoBack else {return}
        webView.goBack()
    }
    @objc func forwardAction() {
        guard webView.canGoForward else { return }
        webView.goForward()
    }
    @objc func refreshAction() {
        webView.reload()
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        backButton.isEnabled = webView.canGoBack
        forwardButton.isEnabled = webView.canGoForward
    }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        searchBar.text = webView.url?.description
    }

}

