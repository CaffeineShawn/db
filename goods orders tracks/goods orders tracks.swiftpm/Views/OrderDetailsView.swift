import SwiftUI

struct OrderDetailsView: View {
//    var order: Order
//    var good: Good
    @State private var showingEditGood = false
    @State private var showingEditOrder = false
    @ObservedObject var tracksViewModel = TracksViewModel()
    let orderWithGood: OrderWithGood
    @EnvironmentObject var ordersViewModel: OrdersViewModel
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        
            VStack {
                List {
                    Section {
                        HStack {
                            Text("订单状态")
                            Spacer()
                            Text(orderWithGood.orderState)
                                .foregroundColor(colorScheme == .dark ? .white.opacity(0.5) : .black.opacity(0.5))
                            
                        }
                        HStack {
                            Text("发件地址")
                            Spacer()
                            Text(orderWithGood.orderOrigin)
                                .foregroundColor(colorScheme == .dark ? .white.opacity(0.5) : .black.opacity(0.5))
                        }
                        HStack {
                            Text("收件地址")
                            Spacer()
                            Text(orderWithGood.orderDestination)
                                .foregroundColor(colorScheme == .dark ? .white.opacity(0.5) : .black.opacity(0.5))
                        }
                        Button { 
                            showingEditOrder.toggle()
                        } label: { 
                            Text("编辑")
                                .foregroundColor(.accentColor)
                        }
                        
                    }
                    .sheet(isPresented: $showingEditOrder) {
                        EditOrderView(orderId: orderWithGood.orderId!, orderState: orderWithGood.orderState, orderOrigin: orderWithGood.orderOrigin, orderDestination: orderWithGood.orderDestination)
                            .environmentObject(ordersViewModel)
                    }
                    
                    Section(header: Text("货物信息")){
                        HStack {
                            Text("货物名称")
                            Spacer()
                            Text(orderWithGood.goodName)
                                .foregroundColor(colorScheme == .dark ? .white.opacity(0.5) : .black.opacity(0.5))
                            
                        }
                        HStack {
                            Text("货物重量")
                            Spacer()
                            Text("\(orderWithGood.goodWeight?.description ?? "未知")kg")
                                .foregroundColor(colorScheme == .dark ? .white.opacity(0.5) : .black.opacity(0.5))
                        }
                        HStack {
                            Text("货物价格")
                            Spacer()
                            Text(orderWithGood.goodPrice == nil ? "未知" : orderWithGood.goodPrice!.description + "元")
                                .foregroundColor(colorScheme == .dark ? .white.opacity(0.5) : .black.opacity(0.5))
                            
                        }
                        Button {
                            showingEditGood.toggle()
                        } label: {
                            Text("编辑")
                        }

                    }
                    Section(header: Text("发件信息")) {
                        HStack {
                            Text("发件人")
                            Spacer()
                            Text(orderWithGood.consignor)
                                .foregroundColor(colorScheme == .dark ? .white.opacity(0.5) : .black.opacity(0.5))
                        }
                        
                        HStack {
                            Text("手机号")
                            Spacer()
                            Text(orderWithGood.consignorPhone)
                                .foregroundColor(colorScheme == .dark ? .white.opacity(0.5) : .black.opacity(0.5))
                        }
                        
                    }
                    Section(header: Text("收件信息")) {
                        HStack {
                            Text("收件人")
                            Spacer()
                            Text(orderWithGood.consignee)
                                .foregroundColor(colorScheme == .dark ? .white.opacity(0.5) : .black.opacity(0.5))
                        }
                        
                        HStack {
                            Text("手机号")
                            Spacer()
                            Text(orderWithGood.consigneePhone)
                                .foregroundColor(colorScheme == .dark ? .white.opacity(0.5) : .black.opacity(0.5))
                        }
                        
                    }

                    Section(header: Text("物流信息")) {
                        TrackView(
                            orderId: orderWithGood.orderId ?? 1
                        )
                            .environmentObject(tracksViewModel)
                    }
                    
                        
                    
                    
                }
                .navigationTitle("订单详情")
                .sheet(isPresented: $showingEditGood) {
                    EditGoodView(goodName: orderWithGood.goodName, goodId: orderWithGood.goodId!, goodPrice: orderWithGood.goodPrice ?? 0, goodWeight: orderWithGood.goodWeight ?? 0)
                        .environmentObject(ordersViewModel)
                }
                
            }
            
        

    }
}
//
//struct OrderDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        OrderDetailsView(order: PreviewModels.orders[0], good: PreviewModels.goods[0])
//    }
//}
