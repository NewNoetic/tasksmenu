//
//  TaskViewController.swift
//  TaskMenu
//
//  Created by Sidhant Gandhi on 4/10/20.
//  Copyright © 2020 newnoetic. All rights reserved.
//

import Cocoa
import WebKit
import WebKitUrlFix

class TaskViewController: NSViewController {

    weak var parentPopover: NSPopover?
    @IBOutlet weak var webView: WKWebView!
    var webKitFix: WebKitUrlFixer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        webKitFix = WebKitUrlFixer(forwardDelegate: self)
        
        webView.navigationDelegate = webKitFix
        webView.uiDelegate = webKitFix
                
        self.preferredContentSize = NSSize(width: 300, height: 500)

        let url = URL(string: "https://tasks.google.com/embed/?origin=https%3A%2F%2Fmail.google.com")
        let request = URLRequest(url: url!)
        webView.load(request)
    }
}

extension TaskViewController: WKNavigationDelegate, WKUIDelegate {
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        print("close popup on link click")
        self.parentPopover?.close()
        return nil
    }
}

extension TaskViewController {
  // MARK: Storyboard instantiation
  static func freshController() -> TaskViewController {
    //1.
    let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: Bundle.main)
    //2.
    let identifier = NSStoryboard.SceneIdentifier("TaskViewController")
    //3.
    guard let viewcontroller = storyboard.instantiateController(withIdentifier: identifier) as? TaskViewController else {
      fatalError("Why cant i find TaskViewController? - Check Main.storyboard")
    }
    return viewcontroller
  }
}
