import SwiftUI

struct OrdersListView: View {
    @State private var showAddingOrderSheet = false
    @State private var searchText = ""
    @EnvironmentObject var ordersViewModel: OrdersViewModel
    @Environment(\.colorScheme) var colorScheme
    
    
    
  
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                
                    List {
                        ForEach(searchResults, id: \.orderId!) { orderWithGood in
                            NavigationLink(destination: OrderDetailsView(orderWithGood: orderWithGood)
                                            .environmentObject(ordersViewModel)
                            ) {
                                VStack {
                                    HStack {
//                                        Image(systemName: "person")
                                        Text("\(orderWithGood.consignor)")
                                            .foregroundColor(colorScheme == .dark ? .white.opacity(0.5) : .black.opacity(0.5))
                                            
                                        Spacer()
//                                        Image(systemName: "person")
                                        Text("\(orderWithGood.consignee)")
                                            .foregroundColor(
                                                colorScheme == .dark ? .white.opacity(0.5) :.black.opacity(0.5))
                                    }
                                    
                                    .overlay {
                                        Text(verbatim: "发送给")
                                    }
                                    
                                }
                            }
                        }
                        .onDelete { indexSet in 
//                            print(indexSet.first)
                            let removeId = ordersViewModel.ordersWithGoods[indexSet.first!].orderId
                            ordersViewModel.ordersWithGoods.remove(atOffsets: indexSet)
                            Task {
                                try await ordersViewModel.deleteOrder(orderId: removeId!)
                            }
                            
                        }
                        
                    }
                    .searchable(text: $searchText)
                    

                    .refreshable {
                        Task {
                            try await ordersViewModel.fetchOrdersWithGoods()
                        }
                    }
                    .navigationTitle("Orders")
                    .toolbar {
                        ToolbarItem(placement: ToolbarItemPlacement.automatic) {
                            Button("Add") {
                                showAddingOrderSheet.toggle()
                            }
                        }
                    }
                    
                }
                .onAppear {
                    Task {
                        try await ordersViewModel.fetchOrdersWithGoods()
                    }
                    
                }
                
                
            }
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .sheet(isPresented: $showAddingOrderSheet) {
            AddingOrderSheetView()
                .environmentObject(ordersViewModel)
        }
        
    }
    
    var searchResults: [OrderWithGood] {
        if searchText.isEmpty {
            return ordersViewModel.ordersWithGoods
        } else {
            print(searchText)
            return ordersViewModel.filter(keyWord: searchText)
        }
    }
}

