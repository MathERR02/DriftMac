import SwiftUI
import WebKit

struct BrowserTab: Identifiable {
    let id = UUID()
    var urlString: String
    var title: String
}

struct TabView: View {
    @Binding var tabs: [BrowserTab]
    @Binding var selectedTabIndex: Int
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(tabs.indices, id: \.self) { index in
                    Text(tabs[index].title)
                        .padding(8)
                        .background(selectedTabIndex == index ? Color.blue.opacity(0.1) : Color.clear)
                        .cornerRadius(4)
                        .onTapGesture {
                            selectedTabIndex = index
                        }
                }
                
                Button(action: { 
                    tabs.append(BrowserTab(urlString: "https://www.apple.com", title: "New Tab"))
                    selectedTabIndex = tabs.count - 1
                }) {
                    Image(systemName: "plus")
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal)
    }
}
