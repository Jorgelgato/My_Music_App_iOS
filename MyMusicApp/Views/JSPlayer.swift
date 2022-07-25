//
//  JSWebView.swift
//  MyMusicApp
//
//  Created by Jorge Bobrek on 19/07/22.
//

import SwiftUI
import WebKit
import Foundation

struct JSPlayer: UIViewRepresentable {
    
    class Coordinator: NSObject, WKNavigationDelegate, WKScriptMessageHandler {
        var webView: WKWebView?
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            self.webView = webView
            self.sendToken()
        }
        
        // receive message from wkwebview
        func userContentController(
            _ userContentController: WKUserContentController,
            didReceive message: WKScriptMessage
        ) {
            switch message.name {
            case "device":
                UserDefaults.standard.setValue(message.body, forKey: "device_id")
            case "player":
                do {
                    let jsonData = String(describing: message.body).data(using: .utf8)!
                    let result = try JSONDecoder().decode(PlayerModel.self, from: jsonData)
                    PlayerViewModel.shared.player = result
                } catch {
                    print(error)
                }
                break;
            default:
                print(message.body)
            }
        }
        
        func sendToken() {
            self.webView?.evaluateJavaScript("setToken('\(AuthManager.shared.accessToken!)')")
        }
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let coordinator = makeCoordinator()
        let userContentController = WKUserContentController()
        userContentController.add(coordinator, name: "device")
        userContentController.add(coordinator, name: "player")
        userContentController.add(coordinator, name: "log")
        
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = userContentController
        configuration.allowsInlineMediaPlayback = true
        configuration.mediaTypesRequiringUserActionForPlayback = []
        
        let _wkwebview = WKWebView(frame: .zero, configuration: configuration)
        _wkwebview.navigationDelegate = coordinator
        
        return _wkwebview
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        guard let path: String = Bundle.main.path(forResource: "index", ofType: "html") else { return }
        let localHTMLUrl = URL(fileURLWithPath: path, isDirectory: false)
        webView.loadFileURL(localHTMLUrl, allowingReadAccessTo: localHTMLUrl)
    }
    
}

//-----------------------------------------------------------------------------------------------------------------------------------------------------------
