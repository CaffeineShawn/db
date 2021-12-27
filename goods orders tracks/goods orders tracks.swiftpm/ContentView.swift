import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            OrdersListView()
                .tabItem { 
                    Image(systemName: "cart")
                    Text("Orders")
                }
            UserView()
               
                .tabItem { 
                    Image(systemName: "person")
                    Text("Users")
                }
            SettingView()
                .navigationViewStyle(StackNavigationViewStyle())
                .tabItem {
                    Image(systemName: "paperclip")
                    Text("Settings")
                }
        }
    }
}
