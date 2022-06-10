import SwiftUI

struct OrderGlimpseView: View {
    let orderWithGood: OrderWithGood
    var body: some View {
        VStack {
            List {
                GeometryReader { proxy in
                    VStack(alignment: .center) {
                        ChildView(orderWithGood: orderWithGood)
                            .frame(width: proxy.size.width / 1.5, height: proxy.size.height / 4.5, alignment: .center)
                    }
                    .frame(width: proxy.size.width, height: proxy.size.height, alignment: .center)
                    .background(
                        //                    Color.red
                    )
                }
            }
            .listStyle(PlainListStyle())
            
        }
        
    }
}

struct ChildView: View {
    @Environment(\.colorScheme) var colorScheme
    let orderWithGood: OrderWithGood
    var body: some View {
        VStack {
            HStack {
                Text("发货方")
                    .fontWeight(.bold)
                Spacer()
                Text(orderWithGood.consignor)
                    .foregroundColor(colorScheme == .dark ? .white.opacity(0.5) :.black.opacity(0.5))
                
                    
            }
            .padding(.bottom, 10)
            HStack {
                Text("收货方")
                    .fontWeight(.bold)
                Spacer()
                Text(orderWithGood.consignee)
                    .foregroundColor(colorScheme == .dark ? .white.opacity(0.5) :.black.opacity(0.5))
                
            }
            .padding(.bottom, 10)
            Spacer()
            HStack {
                Text("订单号")
                Spacer()
                Text(orderWithGood.orderId?.description ?? "没有订单号")
                    .foregroundColor(colorScheme == .dark ? .white.opacity(0.5) :.black.opacity(0.5))
                
            }
            .padding(.bottom, 10)
            HStack {
                Text("订单货物")
                Spacer()
                Text(orderWithGood.goodName)
                    .foregroundColor(colorScheme == .dark ? .white.opacity(0.5) :.black.opacity(0.5))
                
            }
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .frame(maxHeight: .infinity)
        .background(
            .thinMaterial
            ,in: RoundedRectangle(cornerRadius: 20)
        )
    }
}

struct OrderGlimpseView_Previews: PreviewProvider {
    static var previews: some View {
        OrderGlimpseView(orderWithGood: OrderWithGood(goodPrice: 114.514, goodWeight: 1919.81, orderDestination: "cnm", orderOrigin: "tiananmensquare", goodName: "jibamao", consignorPhone: "13353297342", consigneePhone: "13800027724", consignor: "sadasda", consignee: "sb", orderState: GoodStates.onTheWay.rawValue))
    }
}
