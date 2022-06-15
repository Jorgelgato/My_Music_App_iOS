//
//  AuthViewController.swift
//  MyMusicApp
//
//  Created by Jorge Bobrek on 10/06/22.
//

import SwiftUI
import WebKit

struct AuthViewController: View {
    @State private var showWebView = false
    var body: some View {
        NavigationLink(isActive: self.$showWebView) {
            WebView(url: AuthManager.shared.signInURL!)
        } label: {
            Text("Sign in with Spotify")
        }
    }
}

struct AuthViewController_Previews: PreviewProvider {
    static var previews: some View {
        AuthViewController()
    }
}

struct WebView: UIViewRepresentable {
 
    @State var shouldDismiss = false
    var url: URL
 
    func makeUIView(context: Context) -> WKWebView {
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = prefs
        let webView = WKWebView(frame: .zero, configuration: config)
        return webView    }
 
    func updateUIView(_ webView: WKWebView, context: Context) {
        guard !shouldDismiss || !context.environment.presentationMode.wrappedValue.isPresented else {
            context.environment.presentationMode.wrappedValue.dismiss()
            return
        }
        let request = URLRequest(url: url)
        webView.navigationDelegate = context.coordinator
        webView.load(request)
    }
    
    func makeCoordinator() -> WebViewCoordinator {
        WebViewCoordinator(self)
    }
    
}

class WebViewCoordinator: NSObject, WKNavigationDelegate {
    var parent: WebView
    init(_ parent: WebView) {
         self.parent = parent
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        guard let url = webView.url else {
            return
        }
        guard let code = URLComponents(string: url.absoluteString)?.queryItems?.first(where: { $0.name == "code" })?.value else {
            return
        }
        
        webView.isHidden = true
        
        print("Code: \(code)")
        AuthManager.shared.exchangeCodeForToken(code: code) { success in
            DispatchQueue.main.async {
                print("SOPLAAAAAAAR")
                webView.inputViewController?.navigationController?.popToRootViewController(animated: true)
                self.parent.shouldDismiss = true
            }
        }
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print(error)
    }
    
}
