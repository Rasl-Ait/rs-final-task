//
//  WebViewController.swift
//  SpaseX
//
//  Created by rasul on 9/18/21.
//

import UIKit
import WebKit

final class WebViewController: BaseViewController {
  private lazy var webView = WKWebView()
  
  private lazy var backButton: UIBarButtonItem = {
    let button = AnimationButton(image: .setImage(.chevronLeft))
    button.tintColor = .navigationBarTintColor
    button.addTarget(self, action: #selector(goBack), for: .touchUpInside)
    let view = UIBarButtonItem(customView: button)
    view.isEnabled = false
    return view
  }()
  
  private lazy var forwardButton: UIBarButtonItem = {
    let button = AnimationButton(image: .setImage(.chevronRight))
    button.tintColor = .navigationBarTintColor
    button.addTarget(self, action: #selector(goForward), for: .touchUpInside)
    let view = UIBarButtonItem(customView: button)
    view.isEnabled = false
    return view
  }()
  
  private lazy var shareButton: UIBarButtonItem = {
    let button = AnimationButton(image: .setImage(.shareAndArrowUp))
    button.tintColor = .navigationBarTintColor
    button.addTarget(self, action: #selector(share), for: .touchUpInside)
    let view = UIBarButtonItem(customView: button)
    return view
  }()
  
  private lazy var safariButton: UIBarButtonItem = {
    let button = AnimationButton(image: .setImage(.safari))
    button.tintColor = .navigationBarTintColor
    button.addTarget(self, action: #selector(safari), for: .touchUpInside)
    let view = UIBarButtonItem(customView: button)
    return view
  }()
  
  private lazy var reloadButton: UIBarButtonItem = {
    let button = AnimationButton(image: .setImage(.arrowClockwise))
    button.tintColor = .navigationBarTintColor
    button.addTarget(self, action: #selector(reload), for: .touchUpInside)
    let view = UIBarButtonItem(customView: button)
    return view
  }()
  
  private lazy var toolbar: UIToolbar = {
     let bar = UIToolbar()
    bar.disableAutoresizingMask()
    bar.backgroundColor = .navigationBarBarTintColor
    bar.tintColor = .navigationBarTintColor
    return bar
  }()
  
  var stringURL = ""
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    configureNavigationBar(isHidden: false, barStyle: .default)
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    webView.stopLoading()
  }
}

// MARK: private WebViewController
private extension WebViewController {
  func setupViews() {
    view.backgroundColor = .backgroundColor
    guard stringURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) != nil else { return }
    if let url = URL(string: stringURL) {
      let request = URLRequest(url: url)
      webView.load(request)
    }
    
    setupNavigationAndToolbar()
    setupWebView()
    view.addSubview(toolbar)
    setupLayoutUI()
    webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
  }
  
  func setupWebView() {
    webView.disableAutoresizingMask()
    webView.navigationDelegate = self
    view.addSubview(webView)
  }
  
  func setupNavigationAndToolbar() {
    let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    
    navigationController?.navigationBar.prefersLargeTitles = false
    
    let toolbarItems = [backButton, spacer, forwardButton, spacer, shareButton, spacer, safariButton]
    
    toolbar.setItems(toolbarItems, animated: true)
    navigationItem.rightBarButtonItem = reloadButton
  }
  
  func setupLayoutUI() {
    NSLayoutConstraint.activate([
      webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      
      toolbar.topAnchor.constraint(equalTo: webView.bottomAnchor),
      toolbar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      toolbar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      toolbar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
      
    ])
  }
  
  // MARK: Action
  @objc func reload() {
    webView.reload()
  }
  
  @objc func goBack() {
    webView.goBack()
  }
  
  @objc func goForward() {
    webView.goForward()
  }
  @objc func share() {
    let activityItems = [stringURL]
    let activityController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
    activityController.excludedActivityTypes = [.mail]
    present(activityController, animated: true, completion: nil)
  }
  
  @objc func safari() {
    UIApplication.shared.open(URL(string: stringURL)!)
  }
}

// MARK: WKNavigationDelegate
extension WebViewController: WKNavigationDelegate {
  override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
   
    if keyPath == "estimatedProgress" {
      reloadButton.isEnabled = webView.isLoading
      backButton.isEnabled = webView.canGoBack
      forwardButton.isEnabled = webView.canGoForward
    }
  }
}
