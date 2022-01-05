import SwiftUI

struct ContentView: View {
    @ObservedObject var ordersViewModel = OrdersViewModel()
    var body: some View {
        TabView {
            OrdersListView()
                .environmentObject(ordersViewModel)
                .tabItem { 
                    Image(systemName: "cart")
                    Text("Orders")
                }
            UserView()
               
                .tabItem { 
                    Image(systemName: "person")
                    Text("Users")
                }
            
            StatisticsView()
                .environmentObject(ordersViewModel)
                .navigationViewStyle(StackNavigationViewStyle())
                .tabItem {
                    Image(systemName: "chart.xyaxis.line")
                    Text("Statistics")
                }
            SettingView()
                .navigationViewStyle(StackNavigationViewStyle())
                .tabItem {
                    Image(systemName: "wrench.and.screwdriver")
                    Text("Settings")
                }
            
        
        }
    }
}
