struct Order: Codable {
    let consignorId: Int
    let consigneeId: Int
    let goodId: Int
    let orderState: String
    let orderOrigin: String
    let orderDestination: String
    
    enum CodingKeys: String, CodingKey {
        case goodId = "good_id"
        case consignorId = "consignor_id"
        case consigneeId = "consignee_id"
        case orderState = "order_state"
        case orderOrigin = "order_origin"
        case orderDestination = "order_destination"
    }
}
