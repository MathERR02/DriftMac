import SwiftUI
import WebKit

struct ContentView: View {
    @State private var tabs = [BrowserTab(urlString: "https://www.apple.com", title: "Apple")]
    @State private var selectedTabIndex = 0
    @State private var webView = WKWebView()
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                TabView(tabs: $tabs, selectedTabIndex: $selectedTabIndex)
                Spacer()
            }
            .background(Color.gray.opacity(0.1))
            
            WebView(urlString: $tabs[selectedTabIndex].urlString, webView: $webView)
            
            HStack(spacing: 8) {
                Button(action: { webView.goBack() }) {
                    Image(systemName: "arrow.left")
                        .frame(width: 30, height: 30)
                        .background(Color.clear)
                        .overlay(
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                }
                .disabled(!webView.canGoBack)
                
                Button(action: { webView.goForward() }) {
                    Image(systemName: "arrow.right")
                        .frame(width: 30, height: 30)
                        .background(Color.clear)
                        .overlay(
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                }
                .disabled(!webView.canGoForward)
                
                Button(action: { webView.reload() }) {
                    Image(systemName: "arrow.clockwise")
                        .frame(width: 30, height: 30)
                        .background(Color.clear)
                        .overlay(
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                }
                
                TextField("Enter URL", text: Binding(
                    get: { tabs[selectedTabIndex].urlString },
                    set: { newValue in
                        tabs[selectedTabIndex].urlString = newValue.hasPrefix("http") ? newValue : "https://\(newValue)"
                    }
                ), onCommit: {
                    if let url = URL(string: tabs[selectedTabIndex].urlString) {
                        webView.load(URLRequest(url: url))
                    }
                })
                .textFieldStyle(PlainTextFieldStyle())
                .font(.system(size: 13))
                .frame(height: 30)
                .padding(.horizontal, 8)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(4)
            }
            .padding()
        }
    }
}
