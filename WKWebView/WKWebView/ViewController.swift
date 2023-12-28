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
    let searchBar  = UISearchBar()
    let toolBarSearch = UIToolbar()
    let space = UIBarButtonItem(systemItem: .flexibleSpace)
    var barViewSearch = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        view.addSubview(toolBar)
        view.addSubview(searchBar)
        view.addSubview(toolBarSearch)
       
        barViewSearch = UIBarButtonItem(customView: searchBar)
        webView.translatesAutoresizingMaskIntoConstraints = false
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        toolBarSearch.translatesAutoresizingMaskIntoConstraints = false
    
        
        toolBar.items = [backButton,forwardButton,space,refreshButton]
        toolBarSearch.items = [barViewSearch]
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            toolBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            toolBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            toolBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            toolBar.topAnchor.constraint(equalTo: toolBarSearch.bottomAnchor),
            
            toolBarSearch.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            toolBarSearch.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            toolBarSearch.bottomAnchor.constraint(equalTo: toolBar.topAnchor),
            toolBarSearch.topAnchor.constraint(equalTo: webView.bottomAnchor),

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

