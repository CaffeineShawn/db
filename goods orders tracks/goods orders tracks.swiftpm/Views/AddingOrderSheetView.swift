import SwiftUI


struct AddingOrderSheetView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var ordersViewModel: OrdersViewModel
    @State var consignor: String = ""
    @State var consignorPhoneNumber: String = "11451419198"
    @State var orderOrigin: String = ""
    @State var consignee: String = ""
    @State var consigneePhoneNumber: String = "13322232223"
    @State var orderDestination: String = ""
    @State var goodName: String = ""
    @State var goodPrice: Double = 0
    @State var goodWeight: Double = 0
    
    private let numberFormatter: NumberFormatter
    init() {
        numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.maximumFractionDigits = 2
    }
    
    var body: some View {
        VStack {
            
            
            Form {
                Section(header: Text("发件方信息")) {
                    TextField("发件人", text: $consignor)
                    TextField("发件人电话", text: $consignorPhoneNumber)
                    TextField("发件地址", text: $orderOrigin)
                }
                
                Section(header: Text("收件方信息")) {
                    TextField("收件人", text: $consignee)
                    TextField("收件人电话", text: $consigneePhoneNumber)
                    TextField("收件地址", text: $orderDestination)
                }
                
                Section(header: Text("货物名称")) {
                    TextField("货物名称", text: $goodName)}
                Section(header: Text("货物价格")) {
                    TextField("货物价格", value: $goodPrice, formatter: numberFormatter)
                        .keyboardType(.numberPad)
                    
                }
                Section(header: Text("货物重量"))  {
                    HStack {
                        TextField("0.00", value: $goodWeight, formatter: MassFormatter().numberFormatter)
                            .keyboardType(.numberPad)
                        Spacer()
                        Text("kg")
                    }
                    Stepper("调整货物重量", onIncrement: {
                        goodWeight += 0.1
                    }, onDecrement: {
                        goodWeight -= 0.1
                    })
                }
                Section {
                    HStack {
                        Spacer()
                        Button { 
                            Task {
                                try await ordersViewModel.addOrderWithGood(orderWithGood: OrderWithGood(goodPrice: goodPrice, goodWeight: goodWeight, orderDestination: orderDestination, orderOrigin: orderOrigin, goodName: orderOrigin, consignorPhone: consignorPhoneNumber, consigneePhone: consigneePhoneNumber, consignor: consignor, consignee: consignee, orderState: GoodStates.ready.rawValue))
                            }
                            dismiss()
                        } label: { 
                            Text("Submit")
                                .disabled(consignee.isEmpty || consignor.isEmpty || consigneePhoneNumber.isEmpty || consignorPhoneNumber.isEmpty || orderOrigin.isEmpty || orderDestination.isEmpty || goodName.isEmpty )
                                .foregroundColor(.accentColor)
                        }
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        Button { 
                            dismiss()
                        } label: { 
                            Text("Cancel")
                                .foregroundColor(.red)
                        }
                        Spacer()
                    }
                }
                
            }
            
            
            
        }
        
        
        
    }
}

struct AddingOrderSheetView_Previews: PreviewProvider {
    static var previews: some View {
        AddingOrderSheetView()
    }
}
