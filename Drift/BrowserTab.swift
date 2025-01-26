import SwiftUI
import WebKit

struct BrowserTab: Identifiable {
    let id = UUID()
    var urlString: String
    var title: String
}
