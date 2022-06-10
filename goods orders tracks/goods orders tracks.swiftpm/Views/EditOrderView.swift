import SwiftUI

struct EditOrderView: View {
    let orderStateCode = 0...2
    let orderId: Int
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var ordersViewModel: OrdersViewModel
    @State var orderState: String
    @State var orderOrigin: String
    @State var orderDestination: String
    var body: some View {
        Form {
            Section(header: Text("订单状态")){
                Picker("订单状态", selection: $orderState) { 
                    ForEach(OrderStates.allCases, id: \.self) {
                        Text($0)
                    }
                }
                
                .pickerStyle(SegmentedPickerStyle())
            }
            
            Section(header: Text("发件地址")) {
                TextField("请输入订单的发件地址", text: $orderOrigin)
            }
            Section(header: Text("收件地址")) {
                TextField("请输入订单的收件地址", text: $orderDestination)
            }
            
            Section {
                Button { 
                    Task {
                        try await ordersViewModel.updateOrder(orderId: orderId, orderState: orderState, orderOrigin: orderOrigin, orderDestination: orderDestination)
                        try await ordersViewModel.fetchOrdersWithGoods()
                    }
                    dismiss()
                } label: { 
                    Text("更新订单")
                    
                }
                Button { 
                    dismiss()
                } label: { 
                    Text("Cancel")
                        .foregroundColor(.red)
                }
                
            }
            
        }
    }
}
//
//struct EditOrderView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditOrderView()
//    }
//}
