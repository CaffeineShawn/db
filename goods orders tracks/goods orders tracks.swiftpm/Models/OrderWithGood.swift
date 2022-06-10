struct OrderWithGood: Codable {
    let consignorPhone: String
    let goodPrice: Double?
    let goodWeight: Double?
    let consignee, goodName, consigneePhone, consignor: String
    let orderState: String
    let orderOrigin: String
    let goodId: Int?
    let orderId: Int?
    let orderDestination: String
    
    
    
    init(goodPrice: Double, goodWeight: Double, orderDestination: String, orderOrigin: String,  goodName: String, consignorPhone: String, consigneePhone: String, consignor: String, consignee: String, orderState: String) {
        self.goodPrice = goodPrice
        self.goodWeight = goodWeight
        self.orderDestination = orderDestination
        self.orderOrigin = orderOrigin
        self.orderState = orderState
        self.goodName = goodName
        self.consigneePhone = consigneePhone
        self.consignorPhone = consignorPhone
        self.consignee = consignee
        self.consignor = consignor
        self.goodId = nil
        self.orderId = nil
    }
    
    
    enum CodingKeys: String, CodingKey {
        case consignorPhone = "consignor_phone"
        case goodPrice = "good_price"
        case goodWeight = "good_weight"
        case consignee
        case goodName = "good_name"
        case consigneePhone = "consignee_phone"
        case consignor
        case orderState = "order_state"
        case orderDestination = "order_destination"
        case orderOrigin = "order_origin"
        case goodId = "good_id"
        case orderId = "order_id"
    }
    
}

