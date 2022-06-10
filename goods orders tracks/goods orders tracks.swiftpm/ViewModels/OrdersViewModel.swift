import SwiftUI
import SwiftUICharts

final class OrdersViewModel: ObservableObject {
    @Published var ordersWithGoods: [OrderWithGood] = []
        
    
    
    @MainActor
    func fetchOrdersWithGoods() async throws {
        guard let url = URL(string: (UserDefaults.standard.object(forKey: "address") == nil ? BaseURL.base.rawValue : UserDefaults.standard.object(forKey: "address") as! String)  + EndPoints.getOrdersWithGoods.rawValue ) else {
            throw HttpErrors.badUrl
        }
        
        ordersWithGoods = try await fetch(url: url)
        
    }
    
    func addOrderWithGood(orderWithGood: OrderWithGood) async throws {
        guard let url = URL(string: (UserDefaults.standard.object(forKey: "address") == nil ? BaseURL.base.rawValue : UserDefaults.standard.object(forKey: "address") as! String) + EndPoints.addOrder.rawValue) else {
            throw HttpErrors.badUrl
        }
        try await sendData(url: url, object: orderWithGood)
    }
    
    func updateOrder(orderId: Int, orderState: String, orderOrigin: String, orderDestination: String) async throws {
        guard let url = URL(string: (UserDefaults.standard.object(forKey: "address") == nil ? BaseURL.base.rawValue : UserDefaults.standard.object(forKey: "address") as! String) + EndPoints.updateOrder.rawValue) else {
            throw HttpErrors.badUrl
        }
        
        var map: [String: Any] = [:]
        map["order_id"] = orderId
        map["order_state"] = orderState
        map["order_origin"] = orderOrigin
        map["order_destination"] = orderDestination
        
        let jsonData = try JSONSerialization.data(withJSONObject: map, options: [])
        print(String(data: jsonData, encoding: .utf8))
        try await sendData(url: url, json: jsonData, method: HttpMethods.PUT.rawValue)
    }
    
    func deleteOrder(orderId: Int) async throws {
        guard let url = URL(string: (UserDefaults.standard.object(forKey: "address") == nil ? BaseURL.base.rawValue : UserDefaults.standard.object(forKey: "address") as! String) + EndPoints.deleteOrder.rawValue + orderId.description) else {
            throw HttpErrors.badUrl
        } 
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethods.DELETE.rawValue
        let (_, response) = try await URLSession.shared.data(for: request)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw HttpErrors.badResponse
        }
    }
    
    
    func updateGood(good: Good) async throws {
        guard let url = URL(string: (UserDefaults.standard.object(forKey: "address") == nil ? BaseURL.base.rawValue : UserDefaults.standard.object(forKey: "address") as! String) + EndPoints.updateGood.rawValue) else {
            throw HttpErrors.badUrl
        }
        
        try await sendData(url: url, object: good, method: HttpMethods.PUT.rawValue)
        try await fetchOrdersWithGoods()
    }
    
    
    func filter(keyWord: String) -> [OrderWithGood] {
        return ordersWithGoods.filter({ orderWithGood in
            orderWithGood.consignee.contains(keyWord) || orderWithGood.consignor.contains(keyWord) || orderWithGood.consigneePhone.contains(keyWord) || orderWithGood.consignorPhone.contains(keyWord) || orderWithGood.goodName.contains(keyWord)
           
        })
    }
    
    
}
