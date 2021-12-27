import Foundation
struct Track: Codable {
    let orderId: Int
    let currentLocation: String
    let currentTime: TimeInterval
    
    enum CodingKeys: String, CodingKey {
        case orderId = "order_id"
        case currentLocation = "current_location"
        case currentTime = "current_time"
        
    }
    
}
