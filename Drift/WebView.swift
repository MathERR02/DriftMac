import SwiftUI
import WebKit

struct WebView: NSViewRepresentable {
    @Binding var urlString: String
    @Binding var webView: WKWebView
    
    func makeNSView(context: Context) -> WKWebView {
        let configuration = WKWebViewConfiguration()
        configuration.preferences.setValue(true, forKey: "developerExtrasEnabled")
        
        configuration.applicationNameForUserAgent = "Safari/16.4"
        
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.customUserAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 14_4) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Safari/605.1.15"
        webView.allowsBackForwardNavigationGestures = true
        
        return webView
    }
    
    func updateNSView(_ nsView: WKWebView, context: Context) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            nsView.load(request)
        }
    }
}
